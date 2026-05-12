---
schemaVersion: 1
generatedAt: 2026-05-12T00:00:00Z
reversa:
  version: "1.2.34"
kind: target_business_rules
producedBy: curator
hash: "sha256:<hash do corpo abaixo do front-matter>"
---

# Target Business Rules

> Catálogo das regras de negócio do legado com decisão de migração: MIGRAR, DESCARTAR ou DECISÃO HUMANA.
> Cada item rastreia para a origem em `_reversa_sdd/` e respeita o `paradigm_decision.md`.

---

## Resumo
- Total de regras analisadas: 58
- MIGRAR: 52
- DESCARTAR: 4 (detalhe em `discard_log.md`)
- DECISÃO HUMANA: 2 (todas RESOLVIDAS)

---

## Regras MIGRAR

### BR-MIGRAR-001 - Senha Global
- **Origem**: `_reversa_sdd/domain.md` § Autenticação e Acesso
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Sistema possui uma única senha para acesso (tabela `senha`)
- **Justificativa de migração**: Mecanismo de autenticação básico necessário para controle de acesso. Deve ser evoluido para JWT com múltiplos usuários.
- **Compatibilidade com paradigma alvo**: Transformar em autenticação JWT com middleware FastAPI. Senha única deve evoluir para múltiplos usuários.

### BR-MIGRAR-002 - Máximo 3 Tentativas
- **Origem**: `_reversa_sdd/domain.md` § Autenticação e Acesso
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Após 3 tentativas de senha incorreta, sistema encerra
- **Justificativa de migração**: Proteção contra força bruta é segurança essencial.
- **Compatibilidade com paradigma alvo**: Implementar rate limiting via FastAPI middleware ou dependência.

### BR-MIGRAR-003 - Troca de Senha
- **Origem**: `_reversa_sdd/domain.md` § Autenticação e Acesso
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Usuário pode alterar senha se checkbox marcado durante login
- **Justificativa de migração**: Funcionalidade de gestão de credenciais necessária.
- **Compatibilidade com paradigma alvo**: Endpoint PUT /users/password com validação.

### BR-MIGRAR-004 - Confirmação Dupla
- **Origem**: `_reversa_sdd/domain.md` § Autenticação e Acesso
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Alteração de senha requer digitação duas vezes idênticas
- **Justificativa de migração**: Prevenção de erro de digitação é UX padrão.
- **Compatibilidade com paradigma alvo**: Validar via Pydantic (password e password_confirmation).

### BR-MIGRAR-005 - Limite de Senha
- **Origem**: `_reversa_sdd/domain.md` § Autenticação e Acesso
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Senha máxima de 10 caracteres
- **Justificativa de migração**: Validação de formato necessária.
- **Compatibilidade com paradigma alvo**: Validar via Pydantic (max_length=10). **Nota**: 10 caracteres é muito curto para padrões modernos; recomendar aumentar para mínimo 8.

### BR-MIGRAR-006 - Código Sequencial de Cliente
- **Origem**: `_reversa_sdd/cadastro-clientes/requirements.md` § Regras de Negócio
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Código de cliente gerado automaticamente (sequencial)
- **Justificativa de migração**: Identificador único necessário para rastreabilidade.
- **Compatibilidade com paradigma alvo**: Usar PostgreSQL SERIAL ou UUID via Pydantic.

### BR-MIGRAR-007 - Campos Obrigatórios de Cliente
- **Origem**: `_reversa_sdd/cadastro-clientes/requirements.md` § Regras de Negócio
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Código, nome, endereço, data de nascimento, bairro e identidade são obrigatórios
- **Justificativa de migração**: Validação de dados essenciais para integridade.
- **Compatibilidade com paradigma alvo**: Validar via Pydantic (fields com ...).

### BR-MIGRAR-008 - Validação de Data de Nascimento
- **Origem**: `_reversa_sdd/cadastro-clientes/requirements.md` § Requisitos Não Funcionais
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Data de nascimento deve ser válida (`IsDate()`)
- **Justificativa de migração**: Validação de data necessária.
- **Compatibilidade com paradigma alvo**: Validar via Pydantic (Date type + validator custom para range: não futuro, >= 1900). **Resposta do usuário**: P-14 confirmou.

### BR-MIGRAR-009 - Bairro Selecionável
- **Origem**: `_reversa_sdd/cadastro-clientes/requirements.md` § Regras de Negócio
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Bairro deve ser escolhido de lista (DBCombo) pré-cadastrada
- **Justificativa de migração**: Normalização de dados necessária.
- **Compatibilidade com paradigma alvo**: FK bairro via Pydantic + endpoint GET /bairros.

### BR-MIGRAR-010 - CPF Opcional com Validação
- **Origem**: `_reversa_sdd/cadastro-clientes/requirements.md` § Lacunas Pendentes
- **Confiança original**: 🔴 LACUNA (resolvida P-13)
- **Descrição**: CPF não é obrigatório para cadastro, mas se informado deve ser validado (dígito verificador)
- **Justificativa de migração**: Validação de documento fiscal é importante para negócio.
- **Compatibilidade com paradigma alvo**: Validar via Pydantic com validator custom (algoritmo do dígito verificador). **Resposta do usuário**: P-13 confirmou validação completa.

### BR-MIGRAR-011 - Pesquisa Flexível de Cliente
- **Origem**: `_reversa_sdd/cadastro-clientes/requirements.md` § Regras de Negócio
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Pesquisa por nome funciona como substring case-insensitive
- **Justificativa de migração**: UX de busca essencial.
- **Compatibilidade com paradigma alvo**: Endpoint GET /clientes com query param ?q=termo, usando ILIKE no PostgreSQL.

### BR-MIGRAR-012 - Cancelamento de Cliente (Soft Delete)
- **Origem**: `_reversa_sdd/cadastro-clientes/requirements.md` § Regras de Negócio
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Cliente marcado como cancelado não pode fazer novas locações
- **Justificativa de migração**: Retenção de histórico é importante para negócio.
- **Compatibilidade com paradigma alvo**: Campo cancelado boolean + filtro em locações.

### BR-MIGRAR-013 - Dependentes Ilimitados
- **Origem**: `_reversa_sdd/cadastro-clientes/requirements.md` § Regras de Negócio
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Cliente ativo pode cadastrar dependentes ilimitados
- **Justificativa de migração**: Flexibilidade para negócio.
- **Compatibilidade com paradigma alvo**: Relação one-to-many cliente → dependentes.

### BR-MIGRAR-014 - Bloqueio de Dependentes em Cliente Cancelado
- **Origem**: `_reversa_sdd/cadastro-clientes/requirements.md` § Lacunas Pendentes
- **Confiança original**: 🟡 INFERIDO
- **Descrição**: Cliente cancelado não pode cadastrar novos dependentes
- **Justificativa de migração**: Consistência com regra de cancelamento.
- **Compatibilidade com paradigma alvo**: Validar FK.cliente.cancelado = False ao criar dependente.

### BR-MIGRAR-015 - Retirada por Dependente
- **Origem**: `_reversa_sdd/domain.md` § Dependentes
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Dependente pode retirar CDs em nome do titular
- **Justificativa de migração**: Flexibilidade de operação.
- **Compatibilidade com paradigma alvo**: Campo opcional cod_dependente em locação.

### BR-MIGRAR-016 - Título vs CD Físico
- **Origem**: `_reversa_sdd/domain.md` § Catálogo de CDs
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Título é o catálogo; CD físico é o exemplar individual
- **Justificativa de migração**: Estrutura de dados correta para negócio.
- **Compatibilidade com paradigma alvo**: Relação one-to-many titulo → cd.

### BR-MIGRAR-017 - Quantidade por Título
- **Origem**: `_reversa_sdd/domain.md` § Catálogo de CDs
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Campo `qtde` define quantos exemplares físicos existem do título
- **Justificativa de migração**: Controle de estoque necessário.
- **Compatibilidade com paradigma alvo**: Campo qtde em titulo, validado vs COUNT(cd por titulo). **Resposta do usuário**: P-02 e P-03 confirmaram.

### BR-MIGRAR-018 - Valor por Locação
- **Origem**: `_reversa_sdd/domain.md` § Catálogo de CDs
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Cada título tem valor definido para locação
- **Justificativa de migração**: Precificação necessária.
- **Compatibilidade com paradigma alvo**: Campo valor em titulo (Decimal).

### BR-MIGRAR-019 - Tipo de Locação (24h/48h)
- **Origem**: `_reversa_sdd/domain.md` § Catálogo de CDs
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Título pode ser 24h ou 48h
- **Justificativa de migração**: Diferenciação de prazos necessária.
- **Compatibilidade com paradigma alvo**: Campo tipo_locacao enum ('24h', '48h').

### BR-MIGRAR-020 - Classificação Opcional
- **Origem**: `_reversa_sdd/domain.md` § Catálogo de CDs
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Grupo, Estilo e Intérprete são opcionais
- **Justificativa de migração**: Enriquecimento de catálogo é nice-to-have.
- **Compatibilidade com paradigma alvo**: FKs opcionais (nullable=True).

### BR-MIGRAR-021 - Situação "Reservado" do CD
- **Origem**: `_reversa_sdd/cadastro-cds/requirements.md` § Lacunas Pendentes
- **Confiança original**: 🔴 LACUNA (resolvida P-04)
- **Descrição**: CDs podem ter situação "Reservado" além de "Disponível" e "Locado"
- **Justificativa de migração**: Estado intermediário necessário para fluxo completo de reservas.
- **Compatibilidade com paradigma alvo**: Campo situacao enum ('Disponível', 'Locado', 'Reservado'). **Resposta do usuário**: P-04 confirmou.

### BR-MIGRAR-022 - Cliente Necessário para Locação
- **Origem**: `_reversa_sdd/domain.md` § Locação de CDs
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Locação exige cliente ativo (não cancelado)
- **Justificativa de migração**: Controle de negócio essencial.
- **Compatibilidade com paradigma alvo**: Validar FK.cliente.cancelado = False.

### BR-MIGRAR-023 - Dependente Autorizado
- **Origem**: `_reversa_sdd/domain.md` § Locação de CDs
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Checkbox permite indicar retirada por dependente
- **Justificativa de migração**: Flexibilidade de operação.
- **Compatibilidade com paradigma alvo**: Campo opcional cod_dependente em locação.

### BR-MIGRAR-024 - CD Disponível para Locação
- **Origem**: `_reversa_sdd/domain.md` § Locação de CDs
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Apenas CDs com `situacao = "Disponível"` podem ser locados
- **Justificativa de migração**: Controle de estoque essencial.
- **Compatibilidade com paradigma alvo**: Validar WHERE cd.situacao = 'Disponível'.

### BR-MIGRAR-025 - Cálculo de Data Prevista (24h)
- **Origem**: `_reversa_sdd/domain.md` § Locação de CDs
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Locação 24h: data + 1 dia (2 se domingo)
- **Justificativa de migração**: Cálculo de prazo necessário.
- **Compatibilidade com paradigma alvo**: Implementar service LocacaoService.calcular_data_prevista() com lógica de domingo.

### BR-MIGRAR-026 - Cálculo de Data Prevista (48h)
- **Origem**: `_reversa_sdd/domain.md` § Locação de CDs
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Locação 48h: data + 2 dias (3 se domingo)
- **Justificativa de migração**: Cálculo de prazo necessário.
- **Compatibilidade com paradigma alvo**: Implementar service LocacaoService.calcular_data_prevista() com lógica de domingo.

### BR-MIGRAR-027 - Múltiplos Itens na Locação
- **Origem**: `_reversa_sdd/domain.md` § Locação de CDs
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Locação pode incluir vários CDs (acumulados no recibo)
- **Justificativa de migração**: UX de compra múltipla necessária.
- **Compatibilidade com paradigma alvo**: Relação one-to-many recibo → locacao (itens).

### BR-MIGRAR-028 - Atualização de Estado na Locação
- **Origem**: `_reversa_sdd/domain.md` § Locação de CDs
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Ao locar, CD marca `situacao = "Locado"` e `locado = True`
- **Justificativa de migração**: Controle de estado essencial.
- **Compatibilidade com paradigma alvo**: Atualizar cd.situacao = 'Locado' em transação.

### BR-MIGRAR-029 - Transação Atômica na Locação
- **Origem**: `_reversa_sdd/movimentacao/requirements.md` § Lacunas Pendentes
- **Confiança original**: 🔴 LACUNA (resolvida P-15)
- **Descrição**: Locação e atualização do CD devem ser atômicas
- **Justificativa de migração**: Consistência de dados crítica.
- **Compatibilidade com paradigma alvo**: Usar async with async_session.begin() em repository. **Resposta do usuário**: P-15 confirmou.

### BR-MIGRAR-030 - Recibo Obrigatório para Devolução
- **Origem**: `_reversa_sdd/domain.md` § Devolução de CDs
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Devolução exige recibo de locação pendente
- **Justificativa de migração**: Rastreabilidade necessária.
- **Compatibilidade com paradigma alvo**: Validar recibo.devolvido = False.

### BR-MIGRAR-031 - Múltiplos Recibos Pendentes
- **Origem**: `_reversa_sdd/domain.md` § Devolução de CDs
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Cliente pode ter mais de um recibo pendente (exige seleção)
- **Justificativa de migração**: Flexibilidade de operação.
- **Compatibilidade com paradigma alvo**: Endpoint GET /clientes/{id}/recibos-pendentes.

### BR-MIGRAR-032 - Verificação de Atraso
- **Origem**: `_reversa_sdd/domain.md` § Devolução de CDs
- **Confiança original**: 🟡 INFERIDO
- **Descrição**: Sistema calcula dias de atraso ao devolver
- **Justificativa de migração**: Cálculo de multa necessário.
- **Compatibilidade com paradigma alvo**: Implementar service LocacaoService.calcular_atraso().

### BR-MIGRAR-033 - Cálculo de Multa por Atraso
- **Origem**: `_reversa_sdd/movimentacao/requirements.md` § Lacunas Pendentes
- **Confiança original**: 🔴 LACUNA (resolvida P-01)
- **Descrição**: Valor fixo por dia de atraso: R$ 3,50
- **Justificativa de migração**: Receita de negócio crítica.
- **Compatibilidade com paradigma alvo**: Implementar service LocacaoService.calcular_multa(): valor = dias_atraso * 3.50. **Resposta do usuário**: P-01 confirmou.

### BR-MIGRAR-034 - Atualização de Estado na Devolução
- **Origem**: `_reversa_sdd/domain.md` § Devolução de CDs
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Ao devolver, CD marca `situacao = "Disponível"` e `locado = False`
- **Justificativa de migração**: Controle de estado essencial.
- **Compatibilidade com paradigma alvo**: Atualizar cd.situacao = 'Disponível' em transação.

### BR-MIGRAR-035 - Recibo Baixado
- **Origem**: `_reversa_sdd/domain.md` § Devolução de CDs
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Recibo marcado como `devolvido = True` após baixa
- **Justificativa de migração**: Controle de ciclo necessário.
- **Compatibilidade com paradigma alvo**: Atualizar recibo.devolvido = True em transação.

### BR-MIGRAR-036 - Cliente Ativo para Reserva
- **Origem**: `_reversa_sdd/domain.md` § Reservas
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Cliente cancelado não pode fazer reservas
- **Justificativa de migração**: Consistência com regra de cancelamento.
- **Compatibilidade com paradigma alvo**: Validar FK.cliente.cancelado = False.

### BR-MIGRAR-037 - Reserva por Título
- **Origem**: `_reversa_sdd/domain.md` § Reservas
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Reserva é feita por título, não por CD físico específico
- **Justificativa de migração**: Lógica de negócio correta.
- **Compatibilidade com paradigma alvo**: Relação reserva → titulo (não cd).

### BR-MIGRAR-038 - Sem Garantia de Disponibilidade
- **Origem**: `_reversa_sdd/domain.md` § Reservas
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Reserva não garante disponibilidade física na retirada
- **Justificativa de migração**: UX de aviso necessária.
- **Compatibilidade com paradigma alvo**: Documentar em API, verificar disponibilidade ao converter em locação.

### BR-MIGRAR-039 - Bloqueio de Reserva Duplicada
- **Origem**: `_reversa_sdd/questions.md` § P-08
- **Confiança original**: 🔴 LACUNA (resolvida P-08)
- **Descrição**: Cliente não pode fazer múltiplas reservas do mesmo título
- **Justificativa de migração**: Evitar duplicidade de pedido.
- **Compatibilidade com paradigma alvo**: Validar COUNT(reserva WHERE cod_cliente=X AND cod_titulo=Y AND situacao='Pendente') = 0. **Resposta do usuário**: P-08 confirmou bloqueio.

### BR-MIGRAR-040 - Verificação de Data de Reserva
- **Origem**: `_reversa_sdd/domain.md` § Reservas
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Sistema alerta se já existe reserva para o mesmo título/data
- **Justificativa de migração**: UX de aviso necessária.
- **Compatibilidade com paradigma alvo**: Validar e retornar 409 Conflict se duplicidade.

### BR-MIGRAR-041 - Cancelamento de Reserva
- **Origem**: `_reversa_sdd/domain.md` § Reservas
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Reservas podem ser canceladas/excluídas
- **Justificativa de migração**: Gestão de necessidades.
- **Compatibilidade com paradigma alvo**: Endpoint DELETE /reservas/{id}.

### BR-MIGRAR-042 - Conversão de Reserva em Locação
- **Origem**: `_reversa_sdd/questions.md` § P-07
- **Confiança original**: 🔴 LACUNA (resolvida P-07)
- **Descrição**: Ao converter reserva em locação, situação da reserva é marcada como "Confirmada"
- **Justificativa de migração**: Rastreabilidade de histórico.
- **Compatibilidade com paradigma alvo**: Atualizar reserva.situacao = 'Confirmada' ao criar locação. **Resposta do usuário**: P-07 confirmou.

### BR-MIGRAR-043 - Data Prevista da Reserva
- **Origem**: `_reversa_sdd/questions.md` § P-09
- **Confiança original**: 🔴 LACUNA (resolvida P-09)
- **Descrição**: Data prevista calculada baseada na disponibilidade do título
- **Justificativa de migração**: UX de informação útil.
- **Compatibilidade com paradigma alvo**: Implementar service ReservaService.calcular_data_prevista() baseado em disponibilidade. **Resposta do usuário**: P-09 confirmou.

### BR-MIGRAR-044 - Modos de Pesquisa
- **Origem**: `_reversa_sdd/consultas/requirements.md` § Regras de Negócio
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Três modos: Todas as Ocorrências (substring), Palavras Exatas (frase), Palavra Inicial (prefixo)
- **Justificativa de migração**: Flexibilidade de busca é importante.
- **Compatibilidade com paradigma alvo**: Implementar via query params: ?mode=contains|exact|starts_with.

### BR-MIGRAR-045 - Case-Insensitive em Consultas
- **Origem**: `_reversa_sdd/consultas/requirements.md` § Regras de Negócio
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Pesquisas funcionam com maiúsculas e minúsculas
- **Justificativa de migração**: UX padrão de busca.
- **Compatibilidade com paradigma alvo**: Usar ILIKE no PostgreSQL.

### BR-MIGRAR-046 - Visualização de Locado em Consultas
- **Origem**: `_reversa_sdd/consultas/requirements.md` § Regras de Negócio
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Consultas mostram se CD está locado (`locado = True/False`)
- **Justificativa de migração**: Informação útil para operação.
- **Compatibilidade com paradigma alvo**: Incluir campo situacao em response schemas.

### BR-MIGRAR-047 - Consultas Somente Leitura
- **Origem**: `_reversa_sdd/consultas/requirements.md` § Regras de Negócio
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Consultas não permitem alteração de dados
- **Justificativa de migração**: Separação de responsabilidades REST.
- **Compatibilidade com paradigma alvo**: Endpoints GET apenas, sem POST/PUT/DELETE.

### BR-MIGRAR-048 - Integridade Referencial (Erro 3200)
- **Origem**: `_reversa_sdd/domain.md` § Regras de Integridade
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Violação de integridade referencial ao excluir registro com dependentes
- **Justificativa de migração**: Proteção de dados essencial.
- **Compatibilidade com paradigma alvo**: Usar FK constraints no PostgreSQL + tratamento de 400 Bad Request.

### BR-MIGRAR-049 - Bloqueio de Exclusão de Cliente com Locações
- **Origem**: `_reversa_sdd/questions.md` § P-05
- **Confiança original**: 🔴 LACUNA (resolvida P-05)
- **Descrição**: Exclusão bloqueada se cliente tem locações pendentes
- **Justificativa de migração**: Integridade de histórico necessária.
- **Compatibilidade com paradigma alvo**: Validar COUNT(locacao WHERE cod_cliente=X AND devolvido=False) = 0. **Resposta do usuário**: P-05 confirmou.

### BR-MIGRAR-050 - Bloqueio de Exclusão de Título com CDs Físicos
- **Origem**: `_reversa_sdd/questions.md` § P-06
- **Confiança original**: 🔴 LACUNA (resolvida P-06)
- **Descrição**: Exclusão bloqueada se título tem CDs físicos cadastrados
- **Justificativa de migração**: Integridade referencial necessária.
- **Compatibilidade com paradigma alvo**: Validar COUNT(cd WHERE cod_titulo=X) = 0. **Resposta do usuário**: P-06 confirmou.

### BR-MIGRAR-051 - Relatórios de Clientes, CDs, Locações, etc.
- **Origem**: `_reversa_sdd/relatorios/requirements.md` § Requisitos Funcionais
- **Confiança original**: 🟢 CONFIRMADO
- **Descrição**: Gerar 8 tipos de relatórios diferentes (Clientes Sintético/Analítico, Dependentes, Músicas, CDs, Títulos, Reservas)
- **Justificativa de migração**: Relatórios são essenciais para gestão.
- **Compatibilidade com paradigma alvo**: Implementar como HTML/PDF gerados dinamicamente via Jinja2 + WeasyPrint. **Resposta do usuário**: P-12 confirmou.

### BR-MIGRAR-052 - Parâmetros de Relatório
- **Origem**: `_reversa_sdd/questions.md` § P-11
- **Confiança original**: 🔴 LACUNA (resolvida P-11)
- **Descrição**: Relatórios devem aceitar filtros (período, cliente, status, etc.)
- **Justificativa de migração**: Flexibilidade de relatórios é útil.
- **Compatibilidade com paradigma alvo**: Implementar query params em endpoints de relatório. **Resposta do usuário**: P-11 confirmou.

---

## Regras DESCARTAR (resumo)

| ID | Origem | Motivo curto | Vínculo a paradigma? |
|---|---|---|---|
| BR-DESCARTAR-001 | `_reversa_sdd/domain.md` § Autenticação e Acesso | Criptografia XOR insegura substituída por bcrypt | sim |
| BR-DESCARTAR-002 | `_reversa_sdd/code-analysis.md` § geracod() | Código sequencial em memória substituído por SERIAL do PostgreSQL | sim |
| BR-DESCARTAR-003 | `_reversa_sdd/cadastro-clientes/design.md` § Tratamento de Erros | On Error GoTo substituído por exceções estruturadas + HTTP status codes | sim |
| BR-DESCARTAR-004 | `_reversa_sdd/relatorios/requirements.md` | Crystal Reports substituído por HTML/PDF dinâmico | não (tecnologia obsoleta) |

> Detalhe completo em `discard_log.md`.

---

## Regras DECISÃO HUMANA

### BR-HUMANA-001 - Evolução de Autenticação: Senha Única para Múltiplos Usuários
- **Origem**: `_reversa_sdd/domain.md` § Autenticação e Acesso
- **Tipo de ambiguidade**: ⚠️ AMBÍGUA (estratégia evolutiva)
- **Descrição**: Sistema legado usa uma única senha global. Paradigma alvo sugere JWT com múltiplos usuários/roles.
- **Opções**:
  1. Manter senha única (simplificar migração)
  2. Evoluir para múltiplos usuários com roles (padrão moderno)
  3. Híbrido: senha única inicial + capacidade de criar usuários
- **Recomendação do Curator**: Opção 2 (Evoluir para múltiplos usuários). Justificativa: Paradigma transformational adotado,JWT é padrão em FastAPI, múltiplos usuários é esperado em API REST.
- **Status**: RESOLVIDA
  - **Escolha**: Opção 2 - Evoluir para múltiplos usuários com JWT
  - **Decisor**: Sandoval
  - **Data**: 2026-05-12

### BR-HUMANA-002 - Estrutura Detalhada de Relatórios
- **Origem**: `_reversa_sdd/questions.md` § P-10
- **Tipo de ambiguidade**: ⚠️ AMBÍGUA (escopo de análise)
- **Descrição**: Usuário respondeu "Sim, análise detalhada dos campos de cada relatório" para P-10, mas os arquivos `.rpt` do Crystal Reports não foram analisados.
- **Opções**:
  1. Analisar arquivos `.rpt` para documentar campos exatos
  2. Definir estrutura de relatórios baseada em requisitos de negócio (independente de legado)
  3. Deixar estrutura flexível para definição durante implementação
- **Recomendação do Curator**: Opção 2 (Definir estrutura baseada em requisitos). Justificativa: Crystal Reports é tecnologia obsoleta sendo descartada; estrutura deve ser definida para HTML/PDF novo, não copiada do legado.
- **Status**: RESOLVIDA
  - **Escolha**: Opção 2 - Descartar Crystal Reports, definir estrutura baseada em requisitos
  - **Decisor**: Sandoval
  - **Data**: 2026-05-12

---

## Notas

1. **Resolução de Lacunas**: Todas as 15 perguntas críticas em `questions.md` foram respondidas pelo usuário, eliminando lacunas (🔴) e transformando-as em requisitos confirmados.

2. **Paradigma Transformational**: A maioria das regras descartadas está vinculada à mudança de paradigma (recordsets globais, tratamento de erros imperativo, código sequencial em memória). O paradigma alvo (OO com DI + async) absorve essas necessidades por construção.

3. **Segurança**: Criptografia XOR e senha única são patentes de dívida técnica que devem ser evoluidas no sistema novo. Recomendação forte para bcrypt/argon2 e JWT com múltiplos usuários.

4. **Integridade de Dados**: Validações de CPF, data de nascimento e estoque foram confirmadas como necessárias pelo usuário.

5. **Transações**: Confirmação do usuário para uso de transações atômicas em locação/devolução é crítica para consistência de dados.

6. **Relatórios**: Substituição de Crystal Reports por HTML/PDF gerados dinamicamente é decisão técnica confirmada pelo usuário. Estrutura detalhada de campos requer decisão sobre como definir (análise `.rpt` vs baseada em requisitos).
