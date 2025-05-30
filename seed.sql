-- SEED DE DADOS FICTÍCIOS PARA O BANCO

-- tb_academia
INSERT INTO tb_academia (id, data_fechamento_mes, nome) VALUES
  (1, '2025-01-01', 'Academia Alpha'),
  (2, '2025-02-01', 'Academia Beta'),
  (3, '2025-03-01', 'Academia Gama');

-- tb_plano_user
INSERT INTO tb_plano_user (id, nome, qtd_alunos) VALUES
  (1, 'Plano Bronze', 100),
  (2, 'Plano Prata', 200),
  (3, 'Plano Ouro', 300);

-- tb_usuario
INSERT INTO tb_usuario (id, email, expiracao_user, login, nome, nome_academia, numero_telefone, password, preference_id, role, token_recuperar, user_verificado, verificacao_wpp, academia_id, plano_user_id) VALUES
  (1, 'alpha@email.com', '2025-12-31', 'alphauser', 'Alpha User', 'Academia Alpha', '(11) 99999-1111', 'senha123', 'pref1', 'ADMIN', 'token1', 1, 1, 1, 1),
  (2, 'beta@email.com', '2025-11-30', 'betauser', 'Beta User', 'Academia Beta', '(22) 99999-2222', 'senha456', 'pref2', 'USER', 'token2', 0, 1, 2, 2),
  (3, 'gama@email.com', '2025-10-31', 'gamauser', 'Gama User', 'Academia Gama', '(33) 99999-3333', 'senha789', 'pref3', 'USER', 'token3', 1, 0, 3, 3);

-- tb_medidas
INSERT INTO tb_medidas (id, abdomen, altura, antebraco_direito, antebraco_esquerdo, braco_direito, braco_esquerdo, cintura, coxa_direita, coxa_esquerda, panturrilha_direito, panturrilha_esquerda, peito, peso) VALUES
  (1, '80', 1.75, '30', '29', '35', '34', '85', '55', '54', '38', '37', '100', 75),
  (2, '85', 1.80, '31', '30', '36', '35', '90', '56', '55', '39', '38', '105', 80),
  (3, '90', 1.70, '32', '31', '37', '36', '95', '57', '56', '40', '39', '110', 85);

-- tb_aluno
INSERT INTO tb_aluno (id, data_fim, data_inicio, nome, numero_telefone, status_aluno, tipo_plano, academia_id, medidas_id, rua, tipo_plano_personalizado, update_at) VALUES
  (1, '2025-12-31', '2025-01-01', 'Aluno Um', '(11) 98888-1111', 'ATIVO', 'MENSAL', 1, 1, 'Rua A', 'Personalizado A', '2025-01-01 10:00:00'),
  (2, '2025-11-30', '2025-02-01', 'Aluno Dois', '(22) 98888-2222', 'INATIVO', 'ANUAL', 2, 2, 'Rua B', 'Personalizado B', '2025-02-01 11:00:00'),
  (3, '2025-10-31', '2025-03-01', 'Aluno Três', '(33) 98888-3333', 'RENOVAR', 'TRIMESTRAL', 3, 3, 'Rua C', 'Personalizado C', '2025-03-01 12:00:00');

-- tb_despesas
INSERT INTO tb_despesas (id, data_cadastro, nome_despesa, valor_despesa, academia_id) VALUES
  (1, '2025-01-05', 'Energia', 500.00, 1),
  (2, '2025-02-10', 'Água', 200.00, 2),
  (3, '2025-03-15', 'Internet', 150.00, 3);

-- tb_faturamento
INSERT INTO tb_faturamento (id, data_fechamento, nome_mes, numero_mes, valor, academia_id) VALUES
  (1, '2025-01-31', 'Janeiro', 1, 10000.00, 1),
  (2, '2025-02-28', 'Fevereiro', 2, 12000.00, 2),
  (3, '2025-03-31', 'Março', 3, 11000.00, 3);

-- tb_planos_personalizado
INSERT INTO tb_planos_personalizado (id, nome_plano_personalizado, qtd_dias_plano, valor_plano_personalizado, academia_id) VALUES
  (1, 'Plano Família', 30, 99.90, 1),
  (2, 'Plano Individual', 30, 79.90, 2),
  (3, 'Plano Premium', 60, 149.90, 3);

-- tb_planosacademia
INSERT INTO tb_planosacademia (id, qtd_mes_plano, tipo_plano, valor_plano, academia_id) VALUES
  (1, 1, 'MENSAL', 120.00, 1),
  (2, 6, 'SEMESTRAL', 600.00, 2),
  (3, 12, 'ANUAL', 1100.00, 3);

-- tb_recuperacao
INSERT INTO tb_recuperacao (id, data_expiracao, token, user_id) VALUES
  (1, '2025-01-10 10:00:00', 'tokenrec1', 1),
  (2, '2025-02-10 11:00:00', 'tokenrec2', 2),
  (3, '2025-03-10 12:00:00', 'tokenrec3', 3); 