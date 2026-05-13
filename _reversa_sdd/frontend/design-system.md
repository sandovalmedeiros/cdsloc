# Design System — CDsLoc

> Sistema de design unificado para a interface do CDsLoc.
> Baseado na análise visual dos formulários VB6 legados, modernizado para web.

---

## 1. Paleta de Cores

### 1.1 Cores Primárias

| Token | HEX | RGB | Uso | Confiança |
|-------|-----|-----|-----|-----------|
| `--color-primary` | `#0066CC` | rgb(0, 102, 204) | Ações principais, links, brand | 🟡 INFERIDO |
| `--color-primary-hover` | `#0052A3` | rgb(0, 82, 163) | Hover sobre primária | 🟡 INFERIDO |
| `--color-primary-light` | `#E6F0FF` | rgb(230, 240, 255) | Background de estados focados | 🟡 INFERIDO |

**Legado:** Títulos de frames usavam azul (`&H00FF0000&` = RGB(0,0,255))

### 1.2 Cores de Estado (Semânticas)

| Token | HEX | RGB | Uso | Confiança |
|-------|-----|-----|-----|-----------|
| `--color-success` | `#059669` | rgb(5, 150, 105) | Status "Ativo", sucesso | 🟢 CONFIRMADO |
| `--color-success-bg` | `#ECFDF5` | rgb(236, 253, 245) | Background success | 🟡 INFERIDO |
| `--color-danger` | `#DC2626` | rgb(220, 38, 38) | Status "Cancelado", erros | 🟢 CONFIRMADO |
| `--color-danger-bg` | `#FEF2F2` | rgb(254, 242, 242) | Background danger | 🟡 INFERIDO |
| `--color-warning` | `#D97706` | rgb(217, 119, 6) | Avisos, pendências | 🟡 INFERIDO |
| `--color-warning-bg` | `#FFFBEB` | rgb(255, 251, 235) | Background warning | 🟡 INFERIDO |
| `--color-info` | `#0284C7` | rgb(2, 132, 199) | Informações neutras | 🟡 INFERIDO |
| `--color-info-bg` | `#F0F9FF` | rgb(240, 249, 255) | Background info | 🟡 INFERIDO |

**Legado:**
- OptAtivo_Cli: verde (`&H0000FF00&`)
- OptCanc_Cli: vermelho (`&H000000FF&`)

### 1.3 Cores Neutras

| Token | HEX | RGB | Uso | Confiança |
|-------|-----|-----|-----|-----------|
| `--color-bg-primary` | `#FFFFFF` | rgb(255, 255, 255) | Background principal | 🟡 INFERIDO |
| `--color-bg-secondary` | `#F9FAFB` | rgb(249, 250, 251) | Background secundário, cards | 🟡 INFERIDO |
| `--color-bg-tertiary` | `#F3F4F6` | rgb(243, 244, 246) | Background terciário, painéis | 🟢 CONFIRMADO |
| `--color-border` | `#E5E7EB` | rgb(229, 231, 235) | Bordas, divisores | 🟡 INFERIDO |
| `--color-border-light` | `#F3F4F6` | rgb(243, 244, 246) | Bordas sutis | 🟡 INFERIDO |
| `--color-text-primary` | `#111827` | rgb(17, 24, 39) | Texto principal | 🟡 INFERIDO |
| `--color-text-secondary` | `#6B7280` | rgb(107, 114, 128) | Texto secundário, labels | 🟡 INFERIDO |
| `--color-text-tertiary` | `#9CA3AF` | rgb(156, 163, 175) | Texto terciário, placeholders | 🟡 INFERIDO |
| `--color-text-disabled` | `#D1D5DB` | rgb(209, 213, 219) | Texto desabilitado | 🟡 INFERIDO |

**Legado:**
- SSPanel.BackColor: `12632256` = RGB(192, 192, 192) — cinza claro
- TextBox: cor de texto padrão do sistema

### 1.4 Cores Específicas do Domínio

| Token | HEX | Uso | Confiança |
|-------|-----|-----|-----------|
| `--color-cd-available` | `#059669` | CD disponível para locação | 🟡 INFERIDO |
| `--color-cd-rented` | `#DC2626` | CD locado | 🟡 INFERIDO |
| `--color-cd-reserved` | `#D97706` | CD reservado | 🟡 INFERIDO |

---

## 2. Tipografia

### 2.1 Font Family

| Token | Valor | Fallback | Confiança |
|-------|-------|----------|-----------|
| `--font-family-sans` | `'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif` | system sans | 🟡 INFERIDO |

**Legado:** MS Sans Serif, 8.25pt

### 2.2 Tamanhos de Fonte

| Token | px | rem | Uso | Confiança |
|-------|----|-----|-----|-----------|
| `--font-size-xs` | 12px | 0.75rem | Texto pequeno, captions | 🟡 INFERIDO |
| `--font-size-sm` | 14px | 0.875rem | Texto secundário, labels | 🟡 INFERIDO |
| `--font-size-base` | 16px | 1rem | Texto padrão (≈ 12pt VB6) | 🟡 INFERIDO |
| `--font-size-lg` | 18px | 1.125rem | Subtítulos, headers | 🟡 INFERIDO |
| `--font-size-xl` | 20px | 1.25rem | Títulos de seção | 🟡 INFERIDO |
| `--font-size-2xl` | 24px | 1.5rem | Títulos de página | 🟡 INFERIDO |
| `--font-size-3xl` | 32px | 2rem | Títulos principais | 🟡 INFERIDO |

### 2.3 Pesos de Fonte

| Token | Valor | Uso | Confiança |
|-------|-------|-----|-----------|
| `--font-weight-normal` | 400 | Texto padrão | 🟢 CONFIRMADO |
| `--font-weight-medium` | 500 | Texto com ênfase leve | 🟡 INFERIDO |
| `--font-weight-semibold` | 600 | Labels, headings | 🟡 INFERIDO |
| `--font-weight-bold` | 700 | Títulos, cabeçalhos | 🟡 INFERIDO |

---

## 3. Espaçamentos

| Token | px | rem | Uso | Confiança |
|-------|----|-----|-----|-----------|
| `--spacing-0` | 0px | 0rem | Sem espaçamento | 🟡 INFERIDO |
| `--spacing-1` | 4px | 0.25rem | Espaçamento mínimo | 🟡 INFERIDO |
| `--spacing-2` | 8px | 0.5rem | Espaçamento pequeno | 🟡 INFERIDO |
| `--spacing-3` | 12px | 0.75rem | Espaçamento médio-pequeno | 🟡 INFERIDO |
| `--spacing-4` | 16px | 1rem | Espaçamento padrão | 🟡 INFERIDO |
| `--spacing-5` | 20px | 1.25rem | Espaçamento médio-grande | 🟡 INFERIDO |
| `--spacing-6` | 24px | 1.5rem | Espaçamento grande | 🟡 INFERIDO |
| `--spacing-8` | 32px | 2rem | Espaçamento extra-grande | 🟡 INFERIDO |
| `--spacing-12` | 48px | 3rem | Espaçamento seções | 🟡 INFERIDO |

---

## 4. Bordas e Sombras

### 4.1 Border Radius

| Token | Valor | Uso | Confiança |
|-------|-------|-----|-----------|
| `--radius-none` | 0px | Sem arredondamento | 🟡 INFERIDO |
| `--radius-sm` | 4px | Inputs pequenos, badges | 🟡 INFERIDO |
| `--radius-md` | 8px | Cards, botões padrão | 🟡 INFERIDO |
| `--radius-lg` | 12px | Modais, grandes cards | 🟡 INFERIDO |
| `--radius-xl` | 16px | Elementos decorativos | 🟡 INFERIDO |

### 4.2 Sombras

| Token | Valor CSS | Uso | Confiança |
|-------|-----------|-----|-----------|
| `--shadow-sm` | `0 1px 2px 0 rgb(0 0 0 / 0.05)` | Elevação pequena | 🟡 INFERIDO |
| `--shadow-md` | `0 4px 6px -1px rgb(0 0 0 / 0.1)` | Cards padrão | 🟡 INFERIDO |
| `--shadow-lg` | `0 10px 15px -3px rgb(0 0 0 / 0.1)` | Modais, dropdowns | 🟡 INFERIDO |
| `--shadow-xl` | `0 20px 25px -5px rgb(0 0 0 / 0.1)` | Painéis flutuantes | 🟡 INFERIDO |

**Legado:** SSPanel com `BevelOuter = 1` (efeito 3D de borda)

---

## 5. Componentes Base

### 5.1 Botão (Button)

```vue
<!-- Base Button -->
<Button
  variant="primary"  /* primary, secondary, danger, success */
  size="md"          /* sm, md, lg */
  :loading="false"
  :disabled="false"
  icon="save"
  @click="handleClick"
>
  Gravar
</Button>
```

| Prop | Tipo | Padrão | Descrição |
|------|------|---------|-----------|
| `variant` | `'primary' \| 'secondary' \| 'danger' \| 'success' \| 'ghost'` | `'primary'` | Variante visual |
| `size` | `'sm' \| 'md' \| 'lg'` | `'md'` | Tamanho |
| `loading` | `boolean` | `false` | Estado de carregamento |
| `disabled` | `boolean` | `false` | Estado desabilitado |
| `icon` | `string` | - | Ícone (nome do ícone) |
| `block` | `boolean` | `false` | Largura total |

**Mapeamento Legado:** SSCommand → Button

### 5.2 Input (TextField)

```vue
<!-- Text Input -->
<TextField
  v-model="form.name"
  label="Nome do Cliente"
  placeholder="Digite o nome..."
  :maxlength="50"
  :required="true"
  :error="errors.name"
  @keydown.enter="handleEnter"
/>
```

| Prop | Tipo | Padrão | Descrição |
|------|------|---------|-----------|
| `modelValue` | `string` | - | Valor do campo |
| `label` | `string` | - | Rótulo do campo |
| `placeholder` | `string` | - | Texto de placeholder |
| `maxlength` | `number` | - | Tamanho máximo |
| `required` | `boolean` | `false` | Campo obrigatório |
| `disabled` | `boolean` | `false` | Campo desabilitado |
| `error` | `string` | - | Mensagem de erro |
| `icon` | `string` | - | Ícone prefixo |

**Mapeamento Legado:** TextBox → TextField

### 5.3 Input com Máscara (MaskedInput)

```vue
<!-- CPF -->
<MaskedInput
  v-model="form.cpf"
  label="CPF"
  mask="###.###.###-##"
  placeholder="___.___.___-__"
/>

<!-- CEP -->
<MaskedInput
  v-model="form.cep"
  label="CEP"
  mask="#####-###"
  placeholder="_____-___"
/>

<!-- Telefone -->
<MaskedInput
  v-model="form.phone"
  label="Telefone"
  mask="####-####"
  placeholder="____-____"
/>
```

| Prop | Tipo | Padrão | Descrição |
|------|------|---------|-----------|
| `modelValue` | `string` | - | Valor do campo |
| `mask` | `string` | - | Máscara de formatação |
| `placeholder` | `string` | - | Texto de placeholder |

**Mapeamento Legado:** MaskEdBox → MaskedInput

**Máscaras Legado:**
- Data: `##/##/####`
- CEP: `#####-###`
- Telefone: `####-####`
- CPF: `###.###.###-##`

### 5.4 Seleção de Data (DatePicker)

```vue
<!-- Single Date -->
<DatePicker
  v-model="form.birthDate"
  label="Data de Nascimento"
  format="dd/MM/yyyy"
  :max-date="new Date()"
/>

<!-- Date Range -->
<DatePicker
  v-model="form.dateRange"
  label="Período"
  format="dd/MM/yyyy"
  is-range
/>
```

| Prop | Tipo | Padrão | Descrição |
|------|------|---------|-----------|
| `modelValue` | `Date \| Date[]` | - | Valor da data |
| `label` | `string` | - | Rótulo do campo |
| `format` | `string` | `'dd/MM/yyyy'` | Formato de exibição |
| `isRange` | `boolean` | `false` | Seleção de intervalo |
| `minDate` | `Date` | - | Data mínima |
| `maxDate` | `Date` | - | Data máxima |

**Mapeamento Legado:** MaskEdBox com data → DatePicker

### 5.5 Select (Dropdown)

```vue
<Select
  v-model="form.neighborhood"
  label="Bairro"
  :options="neighborhoods"
  option-label="name"
  option-value="id"
  placeholder="Selecione..."
  :required="true"
  :searchable="true"
/>
```

| Prop | Tipo | Padrão | Descrição |
|------|------|---------|-----------|
| `modelValue` | `any` | - | Valor selecionado |
| `label` | `string` | - | Rótulo do campo |
| `options` | `array` | - | Lista de opções |
| `optionLabel` | `string` | - | Campo para exibição |
| `optionValue` | `string` | - | Campo para valor |
| `placeholder` | `string` | - | Texto de placeholder |
| `searchable` | `boolean` | `false` | Pesquisa nas opções |

**Mapeamento Legado:** DBCombo → Select

### 5.6 Radio Group (RadioGroup)

```vue
<RadioGroup
  v-model="form.status"
  label="Situação"
  :options="[
    { value: 'active', label: 'Ativo', color: 'success' },
    { value: 'cancelled', label: 'Cancelado', color: 'danger' }
  ]"
/>
```

| Prop | Tipo | Padrão | Descrição |
|------|------|---------|-----------|
| `modelValue` | `string` | - | Valor selecionado |
| `label` | `string` | - | Rótulo do grupo |
| `options` | `array` | - | Lista de opções |

**Mapeamento Legado:** OptionButton (Ativo/Cancelado) → RadioGroup

### 5.7 Status Badge (StatusBadge)

```vue
<StatusBadge
  :status="client.status"
  :status-map="{
    active: { label: 'Ativo', variant: 'success' },
    cancelled: { label: 'Cancelado', variant: 'danger' }
  }"
/>
```

| Prop | Tipo | Padrão | Descrição |
|------|------|---------|-----------|
| `status` | `string` | - | Valor do status |
| `statusMap` | `object` | - | Mapeamento de status |

### 5.8 Data Grid (DataGrid)

```vue
<DataGrid
  :data="clients"
  :columns="columns"
  :loading="loading"
  :pagination="pagination"
  :sortable="true"
  @row-click="handleRowClick"
  @page-change="handlePageChange"
/>
```

| Prop | Tipo | Padrão | Descrição |
|------|------|---------|-----------|
| `data` | `array` | `[]` | Dados da tabela |
| `columns` | `array` | `[]` | Definição das colunas |
| `loading` | `boolean` | `false` | Estado de carregamento |
| `pagination` | `object` | - | Configuração de paginação |
| `sortable` | `boolean` | `false` | Ordenação habilitada |
| `selectable` | `boolean` | `false` | Seleção de linhas |

**Mapeamento Legado:** MSFlexGrid, ListBox → DataGrid

### 5.9 Card (Card)

```vue
<Card>
  <template #header>
    <h3>Dados Pessoais</h3>
  </template>
  <!-- Conteúdo -->
</Card>
```

| Slot | Descrição |
|------|-----------|
| `header` | Cabeçalho do card |
| `default` | Conteúdo principal |
| `footer` | Rodapé do card |

**Mapeamento Legado:** SSFrame → Card

### 5.10 Tabs (Tabs)

```vue
<Tabs v-model="activeTab">
  <Tab name="clients" label="Clientes">
    <!-- Conteúdo da aba Clientes -->
  </Tab>
  <Tab name="dependents" label="Dependentes">
    <!-- Conteúdo da aba Dependentes -->
  </Tab>
</Tabs>
```

| Prop | Tipo | Padrão | Descrição |
|------|------|---------|-----------|
| `modelValue` | `string` | - | Aba ativa |
| `tabs` | `array` | - | Lista de abas |

**Mapeamento Legado:** SSTab → Tabs

### 5.11 Dialog/Modal (Dialog)

```vue
<Dialog
  v-model="isOpen"
  title="Confirmar Exclusão"
  :width="'md'"
>
  <p>Deseja realmente excluir este registro?</p>
  <template #footer>
    <Button variant="secondary" @click="isOpen = false">
      Cancelar
    </Button>
    <Button variant="danger" @click="confirmDelete">
      Excluir
    </Button>
  </template>
</Dialog>
```

| Prop | Tipo | Padrão | Descrição |
|------|------|---------|-----------|
| `modelValue` | `boolean` | `false` | Estado de abertura |
| `title` | `string` | - | Título do dialog |
| `width` | `'sm' \| 'md' \| 'lg' \| 'xl'` | `'md'` | Largura do dialog |

**Mapeamento Legado:** MsgBox → Dialog

### 5.12 Toast (Notificação)

```vue
<Toast
  v-model="show"
  :type="'success'"
  :message="'Registro salvo com sucesso!'"
  :duration="3000"
/>
```

| Prop | Tipo | Padrão | Descrição |
|------|------|---------|-----------|
| `modelValue` | `boolean` | `false` | Estado de exibição |
| `type` | `'success' \| 'error' \| 'warning' \| 'info'` | `'info'` | Tipo de notificação |
| `message` | `string` | - | Mensagem |
| `duration` | `number` | `3000` | Duração em ms |

---

## 6. Atalhos de Teclado (Preservados do Legado)

| Atalho | Ação | Confiança |
|--------|-------|-----------|
| `F10` | Abrir diálogo de pesquisa por nome | 🟢 CONFIRMADO |
| `Enter` | Navegar para próximo campo / Confirmar ação | 🟢 CONFIRMADO |
| `Esc` | Cancelar ação / Fechar modal | 🟡 INFERIDO |
| `Ctrl+S` | Salvar formulário | 🟡 INFERIDO |
| `Ctrl+F` | Buscar na lista/grid | 🟡 INFERIDO |
| `Ctrl+N` | Novo registro | 🟡 INFERIDO |
| `Ctrl+E` | Editar registro selecionado | 🟡 INFERIDO |
| `Ctrl+D` | Excluir registro selecionado | 🟡 INFERIDO |

---

## 7. Estados e Feedbacks

### 7.1 Estados de Loading

```
Spinner (circular) no centro do conteúdo
Skeleton screens para listas carregando
Overlay com spinner para ações assíncronas
```

### 7.2 Estados Vazios

```
Ilustração + mensagem quando não há dados
Botão de ação principal quando apropriado
```

### 7.3 Estados de Erro

```
Ilustração de erro + mensagem
Botão "Tentar novamente"
Detalhes técnicos em expand/collapse (se disponível)
```

---

## 8. Responsividade

| Breakpoint | px | Dispositivo | Layout |
|------------|----|-------------|--------|
| `xs` | < 640px | Celular | Coluna única, menu hambúrguer |
| `sm` | 640px - 768px | Celular grande | Coluna única |
| `md` | 768px - 1024px | Tablet | Coluna única com sidebar recolhível |
| `lg` | 1024px - 1280px | Desktop | 2-3 colunas |
| `xl` | 1280px+ | Desktop grande | 3-4 colunas |

---

## 9. Acessibilidade (WCAG 2.1 AA)

- Contraste mínimo de 4.5:1 para texto normal
- Contraste mínimo de 3:1 para texto grande
- Navegação completa por teclado
- Focus visível em todos os elementos interativos
- ARIA labels para campos de formulário
- Alt text para imagens
- Screen reader compatível
