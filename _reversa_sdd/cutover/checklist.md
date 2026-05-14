# Cutover Checklist — CDsLoc

> Execução: Big Bang — Domingo 8h-12h
> Sistema Legado: VB6 + Access (BD_CDLOC.mdb)
> Sistema Novo: Python + FastAPI + PostgreSQL (centralizado)

---

## Pré-Cutover (T-7 dias)

- [ ] Desenvolvimento do sistema novo finalizado
- [ ] Testes de paridade automatizados executados
- [ ] Script de migração Access → PostgreSQL testado
- [ ] Backup completo do banco Access (BD_CDLOC.mdb)
- [ ] Backup do Access validado (restaurado em teste)
- [ ] Ambiente PostgreSQL configurado e otimizado
- [ ] Deploy automatizado testado em staging
- [ ] Guia de migração finalizado
- [ ] Treinamento de usuários concluído
- [ ] Stakeholders notificados
- [ ] Equipe de suporte preparada
- [ ] Plano de comunicação pronto

---

## Véspera (T-1 dia)

- [ ] Pré-requisitos técnicos validados
- [ ] Equipe de suporte preparada
- [ ] Backup final do banco Access (ponto de restauração)
- [ ] Comunicado final distribuído
- [ ] Equipe de cutover confirmada

---

## Dia do Cutover (Janela: 8h-12h)

### Início (8h-8h30)

- [ ] **08:00** — INÍCIO DO CUTOVER (sinalizar início)
- [ ] **08:05** — Parar uso do sistema legado (comunicar usuários)
- [ ] **08:15** — Backup de segurança do banco Access
- [ ] **08:30** — Validar backup de segurança

### Migração e Deploy (8h30-9h30)

- [ ] **08:45** — Executar script de migração Access → PostgreSQL
- [ ] **09:00** — Validar contagem de registros (Access vs. PostgreSQL)
- [ ] **09:15** — Deploy do sistema novo (API + Frontend)
- [ ] **09:30** — Testes smoke (endpoints críticos)

### Validação (9h30-11h)

- [ ] **09:45** — Validar autenticação (login com usuários de teste)
- [ ] **10:00** — Testar fluxo completo de locação
- [ ] **10:15** — Testar fluxo completo de devolução (com multa)
- [ ] **10:30** — Testar fluxo completo de reserva
- [ ] **10:40** — Testar consulta de clientes
- [ ] **10:50** — Testar geração de relatório de CDs

### Go/No-Go (11h-11h30)

- [ ] **11:00** — GO/NO-GO DECISION (equipe valida checklist)
- [ ] Se NO-GO: executar rollback
- [ ] Se GO: notificar usuários

### Pós-Cutover (11h30-12h)

- [ ] **11:30** — Suporte monitora primeiras interações
- [ ] **11:45** — Registrar e classificar incidentes
- [ ] **12:00** — FIM DA JANELA ATIVA

---

## Critérios de Go/No-Go

### Go (prosseguir)

- [ ] Backup do Access validado
- [ ] Migração concluída sem erros (COUNT Access = COUNT PostgreSQL)
- [ ] Deploy concluído sem erros
- [ ] Smoke tests passaram
- [ ] Autenticação funcionando
- [ ] Fluxo locação funcionando
- [ ] Fluxo devolução funcionando
- [ ] Suporte em standby
- [ ] Liderança aprovação

### No-Go (abortar e rollback)

- [ ] Backup do Access falhou
- [ ] Migração falhou
- [ ] Deploy falhou
- [ ] Smoke tests falharam
- [ ] Autenticação falhou
- [ ] Fluxo crítico falhou
- [ ] Problema de performance
- [ ] Liderança não aprovação

---

## Contatos de Emergência

| Papel | Nome | Telefone | Canal |
|-------|------|----------|--------|
| Líder técnico | [Nome] | [Número] | Slack #suporte |
| Suporte nível 1 | [Nome] | [Número] | WhatsApp |
| DevOps | [Nome] | [Número] | Slack #incidents |

---

## Observações

- **Backup é não-negociável**: Não inicie sem backup validado
- **Rollback deve ser testado**: Certifique-se que funciona antes do cutover real
- **Comunicação transparente**: Informe usuários em todas as etapas
