---
schemaVersion: 1
generatedAt: 2026-05-12T00:00:00Z
reversa:
  version: "1.2.34"
kind: cutover_plan
producedBy: strategist
hash: "sha256:<hash do corpo abaixo do front-matter>"
---

# Cutover Plan — CDsLoc

> Plano detalhado de cutover para a estratégia Big Bang recomendada.

---

## Visão Geral

**Estratégia:** Big Bang (substituição completa em um único evento)
**Janela de cutover:** 4 horas
**Dia/hora sugerido:** Domingo das 8h às 12h (menor impacto operacional)
**Sistema legado:** VB6 + Access (local por estação)
**Sistema novo:** Python + FastAPI + PostgreSQL (centralizado)
**Backup antes do cutover:** Obrigatório

---

## Pré-Requisitos

### Técnicos

| Item | Responsável | Status |
|------|-------------|--------|
| Desenvolvimento completo do sistema novo | Engenharia | ⏳ Pendente |
| Testes de paridade automatizados (agente Inspector) | QA/Engenharia | ⏳ Pendente |
| Script de migração Access → PostgreSQL testado | Engenharia | ⏳ Pendente |
| Backup completo do banco Access (BD_CDLOC.mdb) | Operações | ⏳ Pendente |
| Ambiente PostgreSQL configurado e otimizado | DevOps | ⏳ Pendente |
| Deploy automatizado configurado (CI/CD) | DevOps | ⏳ Pendente |
| Monitoramento de performance configurado | DevOps | ⏳ Pendente |

### Organizacionais

| Item | Responsável | Status |
|------|-------------|--------|
| Usuários de teste selecionados | Operações | ⏳ Pendente |
| Treinamento de usuários concluído | Produto/Operações | ⏳ Pendente |
| Guia de migração distribuído | Produto | ⏳ Pendente |
| Stakeholders notificados do cutover | Liderança | ⏳ Pendente |
| Equipe de suporte em standby (canal dedicado) | Operações | ⏳ Pendente |
| Plano de comunicação de incidentes pronto | Operações | ⏳ Pendente |

---

## Checklist de Cutover (Cronograma)

### T-7 dias (pré-cutover)

| Passo | Ação | Responsável | Duração |
|-------|-------|-------------|----------|
| 1 | Finalizar desenvolvimento do sistema novo | Engenharia | - |
| 2 | Executar testes de paridade completos | QA/Engenharia | - |
| 3 | Validar script de migração com dados reais (cópia) | Engenharia | - |
| 4 | Realizar backup completo do banco Access | Operações | 30 min |
| 5 | Validar backup (restaurar em estação de teste) | Operações | 1 hora |
| 6 | Configurar ambiente PostgreSQL de produção | DevOps | 2 horas |
| 7 | Testar deploy em ambiente de staging | DevOps | 1 hora |
| 8 | Finalizar guia de migração para usuários | Produto | - |
| 9 | Treinar usuários-chave (workshop) | Produto/Operações | 2 horas |
| 10 | Notificar stakeholders (email, comunicado) | Liderança | - |

### T-1 dia (véspera)

| Passo | Ação | Responsável | Duração |
|-------|-------|-------------|----------|
| 11 | Validar todos os pré-requisitos técnicos | DevOps | 30 min |
| 12 | Preparar equipe de suporte (canais, procedimentos) | Operações | 1 hora |
| 13 | Backup final do banco Access (ponto de restauração) | Operações | 30 min |
| 14 | Distribuir comunicado final de cutover | Liderança | - |
| 15 | Confirmar disponibilidade da equipe (cutover team) | Liderança | - |

### Dia do Cutover (Janela: 8h-12h)

| Passo | Ação | Responsável | Duração | Owner |
|-------|-------|-------------|----------|-------|
| 16 | **INÍCIO DO CUTOVER** - Sinalizar início | Liderança | - | Liderança |
| 17 | Parar uso do sistema legado (comunicar usuários) | Operações | 15 min | Operações |
| 18 | Backup de segurança do banco Access (último) | Operações | 15 min | Operações |
| 19 | Validar backup de segurança | Operações | 15 min | Operações |
| 20 | Executar script de migração Access → PostgreSQL | Engenharia | 30 min | Engenharia |
| 21 | Validar contagem de registros (Access vs. PostgreSQL) | Engenharia | 15 min | Engenharia |
| 22 | Deploy do sistema novo (API + Frontend) | DevOps | 30 min | DevOps |
| 23 | Testes smoke (endpoints críticos respondendo) | QA | 15 min | QA |
| 24 | Validar autenticação (login com usuários de teste) | QA | 15 min | QA |
| 25 | Testar fluxo completo de locação | QA | 20 min | QA |
| 26 | Testar fluxo completo de devolução (com multa) | QA | 20 min | QA |
| 27 | Testar fluxo completo de reserva | QA | 15 min | QA |
| 28 | Testar consulta de clientes | QA | 10 min | QA |
| 29 | Testar geração de relatório de CDs | QA | 15 min | QA |
| 30 | **GO/NO-GO DECISION** - Equipe valida checklist completo | Liderança | 30 min | Liderança |
| 31 | Se NO-GO: Executar rollback (ver seção Rollback) | Operações | 1 hora | Operações |
| 32 | Se GO: Notificar usuários (sistema disponível) | Operações | 15 min | Operações |
| 33 | Suporte monitora primeiras interações de usuários | Operações | Contínuo | Operações |
| 34 | Registrar e classificar incidentes reportados | Suporte | Contínuo | Suporte |
| 35 | **FIM DA JANELA ATIVA** - Suporte normal | Liderança | - | Liderança |

### T+1 dia (pós-cutover)

| Passo | Ação | Responsável | Duração |
|-------|-------|-------------|----------|
| 36 | Análise de incidentes do dia anterior | Engenharia/Operações | 2 horas |
| 37 | Priorização e correção de bugs críticos | Engenharia | - |
| 38 | Deploy de hotfixes se necessário | DevOps | 1 hora |
| 39 | Coleta de feedback de usuários | Produto | - |
| 40 | Atualizar documentação e guias | Produto | - |

### T+7 dias (estabilização)

| Passo | Ação | Responsável | Duração |
|-------|-------|-------------|----------|
| 41 | Análise completa de performance | DevOps/Engenharia | 2 horas |
| 42 | Ajustes de otimização (índices, queries) | DevOps/Engenharia | - |
| 43 | Revisão de riscos (quais se concretizaram, quais não) | Liderança | 1 hora |
| 44 | Lições aprendidas documentadas | Liderança | 2 horas |
| 45 | Decisão: descomissionar sistema legado definitivamente | Liderança | - |

---

## Plano de Rollback

### Gatilhos de Rollback

**ROLLBACK IMEDIATO se:**
- Sistema novo não responde por mais de 15 minutos após deploy
- Erro crítico de perda de dados detectado
- Múltiplos usuários não conseguem logar (>50% de tentativas falham)
- Erro financeiro (multa calculada incorretamente) reportado

**ROLLBACK DECORRIDO (após análise) se:**
- Performance inaceitável (tempo de resposta > 5s em operações básicas)
- Erros não críticos mas frequentes (> 10 incidentes/hora)
- Reclamações de UX que impedem operação básica

### Procedimento de Rollback

| Passo | Ação | Responsável | Duração |
|-------|-------|-------------|----------|
| 1 | Notificar usuários (sistema em manutenção, iniciando rollback) | Operações | 15 min |
| 2 | Parar sistema novo (stop containers) | DevOps | 10 min |
| 3 | Restaurar backup do banco Access | Operações | 30 min |
| 4 | Distribuir executável legado (se necessário reinstalar) | Operações | 30 min |
| 5 | Validar sistema legado (login + fluxo básico) | QA | 15 min |
| 6 | Notificar usuários (sistema legado restaurado) | Operações | 15 min |
| 7 | Coletar logs para análise do problema | Engenharia | - |
| 8 | Reunir equipe para análise de causa raiz | Liderança | 1 hora |

**Tempo total estimado de rollback:** 2 horas

---

## Critérios de Go/No-Go

### Go (prosseguir com cutover)

| Critério | Métrica/Verificação | Responsável |
|----------|---------------------|-------------|
| Backup do Access validado | Restaurado com sucesso em teste | Operações |
| Migração concluída sem erros | COUNT Access = COUNT PostgreSQL | Engenharia |
| Deploy concluído sem erros | Todos os containers rodando | DevOps |
| Smoke tests passaram | Todos os endpoints críticos respondem | QA |
| Autenticação funcionando | Login bem-sucedido com usuários de teste | QA |
| Fluxo locação funcionando | Locação completa do início ao fim | QA |
| Fluxo devolução funcionando | Devolução com cálculo correto de multa | QA |
| Suporte em standby | Equipe disponível nos canais configurados | Operações |
| Liderança aprovação | Checklist completo aprovado | Liderança |

### No-Go (abortar e rollback)

| Critério | Gatilho |
|----------|----------|
| Backup do Access falhou | Restauração em teste não funcionou |
| Migração falhou | Erro crítico no script ou COUNT divergente > 5% |
| Deploy falhou | Containers não iniciaram ou crash loop |
| Smoke tests falharam | > 50% dos endpoints críticos não respondem |
| Autenticação falhou | Login não funciona para usuários de teste |
| Fluxo crítico falhou | Locação ou devolução não completa |
| Problema de performance | Tempo de resposta > 10s em operações básicas |
| Liderança não aprovação | Decisão baseada em risco percebido |

---

## Matriz de Comunicação

| Estágio | Canal | Audiência | Mensagem |
|---------|-------|------------|----------|
| T-7 dias | Email + Slack | Todos | "Migração do sistema CDsLoc agendada para [data]. Haverá janela de manutenção de 4h." |
| T-1 dia | Email + Slack | Todos | "Migração amanhã às 8h. Sistema indisponível das 8h às 12h. Guia de migração anexo." |
| Início do cutover | Email | Stakeholders | "Cutover iniciado. Próxima atualização em 2h." |
| Go/No-Go (GO) | Email + Slack | Todos | "Sistema novo disponível. Acessar em [URL]. Suporte em [canal]." |
| Go/No-Go (NO-GO + rollback) | Email + Slack | Todos | "Problema no cutover. Retornando ao sistema legado. Próxima tentativa em [data]." |
| Incidente crítico | Slack canal #incidents | Suporte/Engenharia | Prioridade alta, investigação imediata |
| Fim da janela | Email + Slack | Todos | "Cutover concluído com sucesso. Suporte disponível em [canal]." |
| T+1 dia | Email | Stakeholders | "Resumo do primeiro dia: [N] incidentes, [N] hotfixes. Sistema estável." |

---

## Plano de Suporte

### Equipe de Suporte (Dia do Cutover)

| Papel | Responsável | Disponibilidade | Canal |
|-------|-------------|-----------------|--------|
| Líder técnico | Engenharia | 8h-18h | Slack #suporte |
| Suporte nível 1 | Operações | 8h-18h | WhatsApp/E-mail + Slack |
| DevOps | DevOps | 8h-14h | Slack #incidentes |
| Engenharia (hotfix) | Engenharia | 8h-18h | Slack #incidentes |

### Classificação de Incidentes

| Severidade | SLA de resposta | Exemplo |
|------------|-----------------|---------|
| Crítica | 15 minutos | Sistema indisponível, perda de dados, erro financeiro |
| Alta | 30 minutos | Fluxo crítico não funciona (locação/devolução) |
| Média | 1 hora | Funcionalidade não crítica não funciona, performance ruim |
| Baixa | 4 horas | Problema de UX, questão esclarecimento |

---

## Notas Finais

1. **Backup é não-negociável:** Cutover não pode ser iniciado sem backup do Access validado.

2. **Testes de paridade são críticos:** Dada a mudança de paradigma (alto gap), validar que cálculos de multa, controle de estoque e validações estão corretos é obrigatório.

3. **Rollback deve ser testado:** Simular rollback em ambiente de teste antes do cutover real.

4. **Comunicação transparente:** Usuários devem ser informados em todas as etapas, especialmente em caso de rollback.

5. **Lições aprendidas:** Documentar tudo que der errado (e certo) para melhorar em próximas migrações.

---

**Aprovado por:** [nome do stakeholder], [data]  
**Versão:** 1.0
