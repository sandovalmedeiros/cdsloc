---
schemaVersion: 1
generatedAt: 2026-05-12T00:00:00Z
reversa:
  version: "1.2.34"
kind: discard_log
producedBy: curator
hash: "sha256:<hash do corpo abaixo do front-matter>"
---

# Discard Log

> Registro completo do que foi descartado da migração e por quê. Cada item tem rastreabilidade para a origem no legado.

---

## Itens descartados

### BR-DESCARTAR-001 - Criptografia XOR de Senha
- **Origem**: `_reversa_sdd/code-analysis.md` § Algoritmo de Criptografia (XOR)
- **Descrição**: Senha armazenada codificada com XOR chave 255 (fraca, reversível)
- **Justificativa**: Criptografia XOR é insegura por padrão. Sistema moderno deve usar hash unidirecional forte (bcrypt/argon2). Gap documentado em `gaps.md`.
- **Vinculado a paradigma**: sim
  - Paradigma legado: Criptografia reversível simples em VB6 procedural
  - Paradigma alvo absorve via: Pydantic validator com passlib.hash.bcrypt; FastAPI OAuth2PasswordBearer para JWT tokens
- **Reposição no sistema novo**: Substituído por bcrypt (hash unidirecional) + JWT para autenticação stateless
- **Risco de descartar**: baixo — XOR é obsoleto e inseguro; substituição é melhoria obrigatória

### BR-DESCARTAR-002 - Código Sequencial Gerado em Memória (geracod())
- **Origem**: `_reversa_sdd/code-analysis.md` § Algoritmo geracod()
- **Descrição**: Função `geracod()` usa MoveLast() para pegar último registro e adiciona 1. Em ambiente multiusuário, pode causar colisões.
- **Justificativa**: Geração de ID em memória é pattern antigo. Banco moderno fornece mecanismo de sequência confiável.
- **Vinculado a paradigma**: sim
  - Paradigma legado: Recordsets globais + código sequencial manual em VB6 procedural
  - Paradigma alvo absorve via: PostgreSQL SERIAL column (auto-increment) com atomicidade garantida pelo banco
- **Reposição no sistema novo**: Substituído por SERIAL/IDENTITY do PostgreSQL (ou UUID se necessário)
- **Risco de descartar**: baixo — SERIAL é padrão em PostgreSQL, atomicidade garantida

### BR-DESCARTAR-003 - Tratamento de Erros Imperativo (On Error GoTo)
- **Origem**: `_reversa_sdd/cadastro-clientes/design.md` § Tratamento de Erros
- **Descrição**: Sistema usa `On Error GoTo ErrorHandler` com `Case 3200` para integridade referencial.
- **Justificativa**: Tratamento de erros via goto não é idiomático em Python/FastAPI. Paradigma alvo usa exceções estruturadas + HTTP status codes.
- **Vinculado a paradigma**: sim
  - Paradigma legado: Tratamento imperativo com goto em VB6 procedural
  - Paradigma alvo absorve via: try/except/else/finally do Python + HTTPException do FastAPI com códigos de status apropriados
- **Reposição no sistema novo**: Substituído por try/except com exceções específicas (ForeignKeyViolationError, etc.) convertidas em HTTPException
- **Risco de descartar**: baixo — exceções estruturadas são padrão em Python

### BR-DESCARTAR-004 - Crystal Reports como Motor de Relatórios
- **Origem**: `_reversa_sdd/relatorios/requirements.md` § Regras de Negócio
- **Descrição**: Sistema usa Crystal Reports (arquivos `.rpt`) para gerar relatórios. Tecnologia descontinuada há anos.
- **Justificativa**: Crystal Reports é tecnologia proprietária obsoleta, requer instalação de runtime Windows, não roda em Linux/Docker. Gap documentado em `gaps.md`.
- **Vinculado a paradigma**: não
  - Não é questão de paradigma, mas de tecnologia legado
- **Reposição no sistema novo**: Substituído por HTML/PDF gerados dinamicamente via Jinja2 + WeasyPrint (ou similar). Decisão do usuário confirmada em P-12.
- **Risco de descartar**: baixo — decisão confirmada pelo usuário; tecnologias alternativas são maduras e open source

---

## Itens descartados por mudança de paradigma (subseção dedicada)

> Lista apenas dos itens cujo `Vinculado a paradigma = sim`. Auditoria explícita para o agente de codificação.

| ID | Origem | Paradigma legado | Substituto no paradigma alvo |
|---|---|---|---|
| BR-DESCARTAR-001 | `_reversa_sdd/code-analysis.md` § XOR | Criptografia reversível simples em VB6 procedural | bcrypt (hash unidirecional) + JWT |
| BR-DESCARTAR-002 | `_reversa_sdd/code-analysis.md` § geracod() | Recordsets globais + código sequencial manual | PostgreSQL SERIAL column |
| BR-DESCARTAR-003 | `_reversa_sdd/cadastro-clientes/design.md` § On Error | Tratamento imperativo com goto | try/except + HTTPException |

---

## Notas

1. **Segurança Primordial**: Descartar criptografia XOR não é opcional — é obrigação de segurança. Sistema novo NÃO deve implementar XOR para senhas.

2. **Atomicidade**: SERIAL do PostgreSQL resolve o problema de concorrência do `geracod()`. Agente de codificação deve usar SERIAL em todas as tabelas PK (cliente, titulo, cd, etc.).

3. **Tratamento de Erros**: On Error GoTo não deve ser replicado. Agente de codificação deve usar:
   - `try/except` no código Python
   - `HTTPException` para erros de validação (400 Bad Request)
   - `HTTPException` para violação de FK (409 Conflict)
   - `HTTPException` para não encontrado (404 Not Found)

4. **Relatórios**: Arquivos `.rpt` não devem ser analisados para estrutura de campos. Estrutura de relatórios HTML/PDF deve ser definida baseada em requisitos de negócio, não no layout do Crystal Reports legado.
