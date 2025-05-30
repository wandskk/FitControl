-- CreateEnum
CREATE TYPE "StatusAluno" AS ENUM ('ATIVO', 'INATIVO', 'RENOVAR');

-- CreateEnum
CREATE TYPE "TipoPlano" AS ENUM ('ANUAL', 'BIMESTRAL', 'MENSAL', 'SEMESTRAL', 'TRIMESTRAL');

-- CreateTable
CREATE TABLE "tb_academia" (
    "id" BIGSERIAL NOT NULL,
    "data_fechamento_mes" TIMESTAMP(3),
    "nome" TEXT,

    CONSTRAINT "tb_academia_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_aluno" (
    "id" SERIAL NOT NULL,
    "data_fim" TIMESTAMP(3),
    "data_inicio" TIMESTAMP(3),
    "nome" TEXT,
    "numero_telefone" TEXT,
    "status_aluno" "StatusAluno",
    "tipo_plano" "TipoPlano",
    "academia_id" BIGINT,
    "medidas_id" BIGINT,
    "rua" TEXT,
    "tipo_plano_personalizado" TEXT,
    "update_at" TIMESTAMP(3),

    CONSTRAINT "tb_aluno_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_despesas" (
    "id" BIGSERIAL NOT NULL,
    "data_cadastro" TIMESTAMP(3),
    "nome_despesa" TEXT,
    "valor_despesa" DECIMAL(38,2),
    "academia_id" BIGINT,

    CONSTRAINT "tb_despesas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_faturamento" (
    "id" BIGSERIAL NOT NULL,
    "data_fechamento" TIMESTAMP(3),
    "nome_mes" TEXT,
    "numero_mes" INTEGER NOT NULL,
    "valor" DOUBLE PRECISION,
    "academia_id" BIGINT,

    CONSTRAINT "tb_faturamento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_medidas" (
    "id" BIGSERIAL NOT NULL,
    "abdomen" TEXT,
    "altura" DOUBLE PRECISION,
    "antebraco_direito" TEXT,
    "antebraco_esquerdo" TEXT,
    "braco_direito" TEXT,
    "braco_esquerdo" TEXT,
    "cintura" TEXT,
    "coxa_direita" TEXT,
    "coxa_esquerda" TEXT,
    "panturrilha_direito" TEXT,
    "panturrilha_esquerda" TEXT,
    "peito" TEXT,
    "peso" BIGINT,

    CONSTRAINT "tb_medidas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_plano_user" (
    "id" BIGSERIAL NOT NULL,
    "nome" TEXT,
    "qtd_alunos" BIGINT,

    CONSTRAINT "tb_plano_user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_planos_personalizado" (
    "id" BIGSERIAL NOT NULL,
    "nome_plano_personalizado" TEXT,
    "qtd_dias_plano" BIGINT,
    "valor_plano_personalizado" DECIMAL(38,2),
    "academia_id" BIGINT,

    CONSTRAINT "tb_planos_personalizado_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_planosacademia" (
    "id" BIGSERIAL NOT NULL,
    "qtd_mes_plano" BIGINT,
    "tipo_plano" "TipoPlano",
    "valor_plano" DECIMAL(38,2),
    "academia_id" BIGINT,

    CONSTRAINT "tb_planosacademia_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_recuperacao" (
    "id" BIGSERIAL NOT NULL,
    "data_expiracao" TIMESTAMP(3),
    "token" TEXT,
    "user_id" BIGINT,

    CONSTRAINT "tb_recuperacao_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_usuario" (
    "id" BIGSERIAL NOT NULL,
    "email" TEXT,
    "expiracao_user" TIMESTAMP(3),
    "login" TEXT,
    "nome" TEXT,
    "nome_academia" TEXT,
    "numero_telefone" TEXT,
    "password" TEXT,
    "preference_id" TEXT,
    "role" TEXT,
    "token_recuperar" TEXT,
    "user_verificado" BOOLEAN,
    "verificacao_wpp" BOOLEAN,
    "academia_id" BIGINT,
    "plano_user_id" BIGINT,

    CONSTRAINT "tb_usuario_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "tb_aluno_medidas_id_key" ON "tb_aluno"("medidas_id");

-- CreateIndex
CREATE UNIQUE INDEX "tb_usuario_academia_id_key" ON "tb_usuario"("academia_id");

-- CreateIndex
CREATE UNIQUE INDEX "tb_usuario_plano_user_id_key" ON "tb_usuario"("plano_user_id");

-- AddForeignKey
ALTER TABLE "tb_aluno" ADD CONSTRAINT "tb_aluno_academia_id_fkey" FOREIGN KEY ("academia_id") REFERENCES "tb_academia"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_aluno" ADD CONSTRAINT "tb_aluno_medidas_id_fkey" FOREIGN KEY ("medidas_id") REFERENCES "tb_medidas"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_despesas" ADD CONSTRAINT "tb_despesas_academia_id_fkey" FOREIGN KEY ("academia_id") REFERENCES "tb_academia"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_faturamento" ADD CONSTRAINT "tb_faturamento_academia_id_fkey" FOREIGN KEY ("academia_id") REFERENCES "tb_academia"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_planos_personalizado" ADD CONSTRAINT "tb_planos_personalizado_academia_id_fkey" FOREIGN KEY ("academia_id") REFERENCES "tb_academia"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_planosacademia" ADD CONSTRAINT "tb_planosacademia_academia_id_fkey" FOREIGN KEY ("academia_id") REFERENCES "tb_academia"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_recuperacao" ADD CONSTRAINT "tb_recuperacao_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "tb_usuario"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_usuario" ADD CONSTRAINT "tb_usuario_academia_id_fkey" FOREIGN KEY ("academia_id") REFERENCES "tb_academia"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_usuario" ADD CONSTRAINT "tb_usuario_plano_user_id_fkey" FOREIGN KEY ("plano_user_id") REFERENCES "tb_plano_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;
