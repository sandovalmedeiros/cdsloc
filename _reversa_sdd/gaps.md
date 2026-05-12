# Gaps e Lacunas de Implementação — CDsLoc

> Gerado pelo Reversa em 2026-05-12
> Documenta tarefas de implementação adicionais identificadas durante a análise

---

## Gaps Prioritários

### Prioridade ALTA

1. **Implementar validação de CPF** com algoritmo de dígito verificador
   - Impacto: Integridade de dados de clientes
   - Localização: cadastro-clientes

2. **Implementar cálculo de multa** (R$ 3,50/dia) na devolução
   - Impacto: Receita e regras de negócio críticas
   - Localização: movimentacao

3. **Implementar controle de transação** em locação/devolução
   - Impacto: Consistência de dados
   - Localização: movimentacao

4. **Implementar validação de estoque** ao cadastrar CDs físicos
   - Impacto: Integridade de inventário
   - Localização: cadastro-cds

5. **Implementar atualização automática** do campo `qtde` do título
   - Impacto: Sincronização de dados
   - Localização: cadastro-cds

### Prioridade MÉDIA

6. Adicionar situação "Reservado" ao ciclo de vida do CD
   - Impacto: Fluxo completo de reservas
   - Localização: cadastro-cds, reservas

7. Implementar bloqueio de reserva duplicada
   - Impacto: Evitar conflitos
   - Localização: reservas

8. Implementar cálculo de data prevista baseado em disponibilidade
   - Impacto: Experiência do cliente
   - Localização: reservas

9. Substituir Crystal Reports por gerador HTML/PDF
   - Impacto: Modernização e suporte
   - Localização: relatorios

10. Adicionar filtros parametrizados aos relatórios
    - Impacto: Flexibilidade de consultas
    - Localização: relatorios

---

## Decisões Pendentes

Nenhuma. Todas as questões críticas foram resolvidas com validação do usuário (15/15 respondidas).

---

## Notas de Implementação

- Sistema legado em Visual Basic 6.0 com DAO 2.5
- Banco de dados Access (Jet)
- Criptografia XOR usada para senhas (deve ser substituída por bcrypt/argon2)
- Sistema de impressão Crystal Reports deve ser reavaliado
- Funciona em ambiente Windows desktop (requer modernização para web)

---

**Gerado por:** Reversa Migration Briefing
**Data:** 2026-05-12
