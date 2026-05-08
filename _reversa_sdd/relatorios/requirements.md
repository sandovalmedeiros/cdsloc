# Relatórios, Requisitos

> Especificação funcional da feature de relatórios do sistema CDsLoc
> Gerado pelo Reversa em 2026-05-08

---

## Visão Geral

Feature responsável pela geração e impressão de relatórios do sistema, utilizando Crystal Reports como motor de relatórios. Os relatórios cobrem as principais entidades do sistema: clientes, dependentes, músicas, CDs, títulos e reservas.

---

## Responsabilidades

- Gerar relatório de Clientes Sintético
- Gerar relatório de Clientes Analítico
- Gerar relatório de Dependentes
- Gerar relatório de Músicas/Intérpretes
- Gerar relatório de Apenas Músicas
- Gerar relatório de CDs Físicos
- Gerar relatório de Títulos
- Gerar relatório de Reservas
- Configurar impressora

---

## Regras de Negócio

### Relatórios

| Regra | Descrição | Confiança |
|--------|-----------|-----------|
| **Crystal Reports** | Sistema usa Crystal Reports para gerar relatórios | 🟢 CONFIRMADO |
| **Somente Leitura** | Relatórios não permitem alteração de dados | 🟢 CONFIRMADO |
| **Impressão Direta** | Relatórios podem ser enviados diretamente para impressora | 🟢 CONFIRMADO |

---

## Requisitos Funcionais

| ID | Requisito | Prioridade | Critério de Aceite |
|----|-----------|-----------|-------------------|
| RF-REL-01 | Selecionar tipo de relatório | Must | Tipos disponíveis: Clientes Sintético, Clientes Analítico, Dependentes, Músicas/Intérpretes, Apenas Músicas, CDs, Títulos, Reservas |
| RF-REL-02 | Gerar relatório de Clientes Sintético | Should | Relatório gerado via `clien01.rpt` |
| RF-REL-03 | Gerar relatório de Clientes Analítico | Should | Relatório gerado via `clien02.rpt` |
| RF-REL-04 | Gerar relatório de Dependentes | Should | Relatório gerado via `depend.rpt` |
| RF-REL-05 | Gerar relatório de Músicas/Intérpretes | Should | Relatório gerado via `musicas.rpt` |
| RF-REL-06 | Gerar relatório de Apenas Músicas | Should | Relatório gerado via `musicas1.rpt` |
| RF-REL-07 | Gerar relatório de CDs Físicos | Should | Relatório gerado via `cds.rpt` |
| RF-REL-08 | Gerar relatório de Títulos | Should | Relatório gerado via `titulos.rpt` |
| RF-REL-09 | Gerar relatório de Reservas | Should | Relatório gerado via `reserva.rpt` |
| RF-REL-10 | Configurar impressora | Could | Diálogo de configuração de impressora exibido |

---

## Requisitos Não Funcionais

| Tipo | Requisito inferido | Evidência no código | Confiança |
|------|--------------------|---------------------|-----------|
| Integração | Crystal Reports deve estar instalado | Uso de controle Crystal Reports | 🟢 CONFIRMADO |
| Performance | Relatórios devem ser gerados em tempo razoável | Uso de Crystal Reports otimizado | 🟢 CONFIRMADO |

---

## Critérios de Aceitação

```gherkin
# Geração de Relatório de Clientes

Dado que o usuário está autenticado no sistema
E acessa o menu Imprimir
E seleciona o relatório "Clientes Sintético"
Quando clica em imprimir
Então o sistema carrega o arquivo `clien01.rpt`
E o Crystal Reports Viewer é exibido
E os dados dos clientes são mostrados
E o usuário pode imprimir ou salvar como PDF

# Geração de Relatório de CDs

Dado que o usuário acessa o menu Imprimir
E seleciona o relatório "CDs Físicos"
Quando clica em imprimir
Então o sistema carrega o arquivo `cds.rpt`
E os dados dos CDs são mostrados
E a situação (Disponível/Locado) é visível

# Configuração de Impressora

Dado que o usuário acessa o menu Imprimir
E seleciona "Configurar Impressora"
Quando clica no menu
Então o diálogo de configuração de impressora do Windows é exibido
E o usuário pode selecionar a impressora padrão
```

---

## Prioridade (MoSCoW)

| Requisito | MoSCoW | Justificativa |
|-----------|--------|---------------|
| Selecionar tipo e gerar relatório | Must | Funcionalidade principal - sem geração, não há relatórios |
| Relatórios de Clientes e CDs | Should | Relatórios mais utilizados |
| Demais relatórios | Should | Relatórios importantes, mas menos utilizados |
| Configurar impressora | Could | Configuração, não essencial |

---

## Rastreabilidade de Código

| Arquivo | Função / Classe | Cobertura |
|---------|-----------------|-----------|
| `MENU02.FRM` | Menu Imprimir | 🟢 CONFIRMADO |
| `clien01.rpt` | Relatório Clientes Sintético | 🟢 CONFIRMADO |
| `clien02.rpt` | Relatório Clientes Analítico | 🟢 CONFIRMADO |
| `depend.rpt` | Relatório Dependentes | 🟢 CONFIRMADO |
| `musicas.rpt` | Relatório Músicas/Intérpretes | 🟢 CONFIRMADO |
| `musicas1.rpt` | Relatório Apenas Músicas | 🟢 CONFIRMADO |
| `cds.rpt` | Relatório CDs Físicos | 🟢 CONFIRMADO |
| `titulos.rpt` | Relatório Títulos | 🟢 CONFIRMADO |
| `reserva.rpt` | Relatório Reservas | 🟢 CONFIRMADO |

---

## Lacunas Pendentes (🔴)

Nenhuma lacuna identificada para esta feature.
