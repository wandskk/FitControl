import { PrismaClient } from '@prisma/client';
import { tb_academia } from '../db/tb_academia.js';
import { tb_plano_user } from '../db/tb_plano_user.js';
import { tb_usuario } from '../db/tb_usuario.js';
import { tb_aluno } from '../db/tb_aluno.js';
import { tb_planosacademia } from '../db/tb_planosacademia.js';
import { tb_planos_personalizado } from '../db/tb_planos_personalizado.js';

const prisma = new PrismaClient();

function parseDate(date) {
  if (!date || date === 'NULL' || date === '') return null;
  return new Date(date);
}

function omitId(obj) {
  const rest = { ...obj };
  delete rest.id;
  return rest;
}

function sanitizeAluno(aluno) {
  const validTipoPlano = ['ANUAL','BIMESTRAL','MENSAL','SEMESTRAL','TRIMESTRAL'];
  const validStatusAluno = ['ATIVO', 'INATIVO', 'RENOVAR'];
  const parsedUpdateAt = parseDate(aluno.update_at);
  return {
    ...omitId(aluno),
    data_fim: parseDate(aluno.data_fim),
    data_inicio: parseDate(aluno.data_inicio),
    update_at: (parsedUpdateAt instanceof Date && !isNaN(parsedUpdateAt)) ? parsedUpdateAt : null,
    nome: typeof aluno.nome === 'string' ? aluno.nome : null,
    numero_telefone: typeof aluno.numero_telefone === 'string' ? aluno.numero_telefone : null,
    status_aluno: validStatusAluno.includes(aluno.status_aluno) ? aluno.status_aluno : null,
    tipo_plano: validTipoPlano.includes(aluno.tipo_plano) ? aluno.tipo_plano : null,
    academia_id: typeof aluno.academia_id === 'number' ? aluno.academia_id : null,
    medidas_id: typeof aluno.medidas_id === 'number' ? aluno.medidas_id : null,
    rua: typeof aluno.rua === 'string' ? aluno.rua : null,
    tipo_plano_personalizado: typeof aluno.tipo_plano_personalizado === 'string' ? aluno.tipo_plano_personalizado : null,
  };
}

const allowedAlunoFields = [
  'data_fim', 'data_inicio', 'nome', 'numero_telefone', 'status_aluno', 'tipo_plano',
  'rua', 'tipo_plano_personalizado', 'update_at', 'tb_academia'
];

function filterAlunoFields(data) {
  const filtered = {};
  for (const key of allowedAlunoFields) {
    if (data[key] !== undefined) filtered[key] = data[key];
  }
  return filtered;
}

async function main() {
  // Limpar tabelas na ordem correta (filhos antes dos pais)
  await prisma.tb_recuperacao.deleteMany({});
  await prisma.tb_usuario.deleteMany({});
  await prisma.tb_aluno.deleteMany({});
  await prisma.tb_medidas.deleteMany({});
  await prisma.tb_planos_personalizado.deleteMany({});
  await prisma.tb_planosacademia.deleteMany({});
  await prisma.tb_plano_user.deleteMany({});
  await prisma.tb_academia.deleteMany({});

  // Otimizar inserção em lote (createMany) para tabelas sem dependência de id gerado
  // tb_academia
  const academiasData = tb_academia.map((academia, idx) => ({
    ...omitId(academia),
    id: idx + 1, // garantir ids sequenciais
    data_fechamento_mes: parseDate(academia.data_fechamento_mes),
  }));
  await prisma.tb_academia.createMany({ data: academiasData });
  const academiaIdMap = new Map(tb_academia.map((a, idx) => [a.id, idx + 1]));

  // tb_plano_user
  const planosUserData = tb_plano_user.map((plano, idx) => ({ ...omitId(plano), id: idx + 1 }));
  await prisma.tb_plano_user.createMany({ data: planosUserData });
  const planoUserIdMap = new Map(tb_plano_user.map((p, idx) => [p.id, idx + 1]));

  // tb_planos_personalizado
  await prisma.tb_planos_personalizado.createMany({
    data: tb_planos_personalizado.map(plano => ({
      ...omitId(plano),
      valor_plano_personalizado: Number(plano.valor_plano_personalizado),
      academia_id: academiaIdMap.has(plano.academia_id) ? academiaIdMap.get(plano.academia_id) : null,
    }))
  });

  // tb_planosacademia
  await prisma.tb_planosacademia.createMany({
    data: tb_planosacademia.map(plano => ({
      ...omitId(plano),
      valor_plano: Number(plano.valor_plano),
      academia_id: academiaIdMap.has(plano.academia_id) ? academiaIdMap.get(plano.academia_id) : null,
    }))
  });

  // tb_usuario (precisa de mapeamento de ids)
  for (const usuario of tb_usuario) {
    await prisma.tb_usuario.create({
      data: {
        ...omitId(usuario),
        expiracao_user: parseDate(usuario.expiracao_user),
        user_verificado: usuario.user_verificado === "_binary '\u0001" ? true : false,
        verificacao_wpp: usuario.verificacao_wpp === "_binary '\u0001" ? true : false,
        academia_id: academiaIdMap.has(usuario.academia_id) ? academiaIdMap.get(usuario.academia_id) : null,
        plano_user_id: planoUserIdMap.has(usuario.plano_user_id) ? planoUserIdMap.get(usuario.plano_user_id) : null,
      },
    });
  }

  // tb_aluno (precisa de mapeamento de ids)
  for (const aluno of tb_aluno) {
    const data = sanitizeAluno(aluno);
    if (!(data.data_fim instanceof Date) || isNaN(data.data_fim)) {
      continue;
    }
    const { academia_id, ...rest } = data;
    await prisma.tb_aluno.create({
      data: filterAlunoFields({
        ...rest,
        tb_academia: academiaIdMap.has(academia_id) ? { connect: { id: academiaIdMap.get(academia_id) } } : undefined,
      })
    });
  }
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  }); 