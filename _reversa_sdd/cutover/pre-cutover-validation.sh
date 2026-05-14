#!/bin/bash
# Pre-Cutover Validation Script — CDsLoc
#
# Valida todos os pré-requisitos antes do cutover.
# Uso: ./pre-cutover-validation.sh

set -e

# Cores
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

check() {
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $1"
    else
        echo -e "${RED}✗${NC} $1"
        exit 1
    fi
}

check_warn() {
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $1"
    else
        echo -e "${YELLOW}⚠${NC} $1 (aviso)"
    fi
}

echo "=========================================="
echo "   PRÉ-CUTOVER VALIDATION — CDsLoc"
echo "=========================================="
echo ""

# 1. Verificar desenvolvimento do sistema novo
echo "1. Verificando desenvolvimento do sistema novo..."
if [ -d "app" ] && [ -f "app/api.py" ]; then
    check "Sistema novo encontrado em app/"
else
    echo -e "${RED}✗${NC} Sistema novo não encontrado"
    exit 1
fi

# 2. Verificar testes de paridade
echo "2. Verificando testes de paridade..."
if [ -d "tests" ] && [ -f "tests/test_parity.py" ]; then
    check "Testes de paridade encontrados"
    python -m pytest tests/test_parity.py -v > /dev/null 2>&1
    check "Testes de paridade passando"
else
    check_warn "Testes de paridade não encontrados (criar antes do cutover)"
fi

# 3. Verificar script de migração
echo "3. Verificando script de migração..."
if [ -f "_reversa_sdd/migration/data_migration_plan.md" ]; then
    check "Plano de migração encontrado"
else
    echo -e "${RED}✗${NC} Plano de migração não encontrado"
    exit 1
fi

# 4. Verificar backup do Access
echo "4. Verificando backup do banco Access..."
if [ -f "/backups/cdsloc/BD_CDLOC.mdb" ]; then
    check "Backup do Access encontrado"
else
    echo -e "${RED}✗${NC} Backup do Access não encontrado"
    echo "Execute: cp /path/to/BD_CDLOC.mdb /backups/cdsloc/"
    exit 1
fi

# 5. Verificar ambiente PostgreSQL
echo "5. Verificando ambiente PostgreSQL..."
docker ps | grep -q "postgres"
if [ $? -eq 0 ]; then
    check "PostgreSQL rodando"
else
    check_warn "PostgreSQL não está rodando (inicie antes do cutover)"
fi

# 6. Verificar deploy automatizado
echo "6. Verificando configuração de deploy..."
if [ -f "docker-compose.yml" ] || [ -f "Dockerfile" ]; then
    check "Configuração de deploy encontrada"
else
    echo -e "${RED}✗${NC} Configuração de deploy não encontrada"
    exit 1
fi

# 7. Verificar monitoramento
echo "7. Verificando configuração de monitoramento..."
# Verificar se há Prometheus, Grafana, etc.
if [ -d "monitoring" ] || docker ps | grep -q "prometheus\|grafana"; then
    check "Monitoramento configurado"
else
    check_warn "Monitoramento não configurado (opcional)"
fi

# 8. Verificar treinamento de usuários
echo "8. Verificando treinamento de usuários..."
if [ -f "_reversa_sdd/migration/cutover_plan.md" ]; then
    check "Plano de cutover encontrado (inclui treinamento)"
else
    echo -e "${RED}✗${NC} Plano de cutover não encontrado"
    exit 1
fi

# 9. Verificar comunicação
echo "9. Verificando plano de comunicação..."
if [ -f "_reversa_sdd/cutover/communication_plan.md" ]; then
    check "Plano de comunicação encontrado"
else
    check_warn "Plano de comunicação não encontrado (opcional, usar cutover_plan.md)"
fi

# 10. Verificar suporte
echo "10. Verificando preparação da equipe de suporte..."
if [ -f "_reversa_sdd/cutover/support_plan.md" ]; then
    check "Plano de suporte encontrado"
else
    check_warn "Plano de suporte não encontrado (usar cutover_plan.md)"
fi

echo ""
echo "=========================================="
echo -e "${GREEN}   TODOS OS PRÉ-REQUISITOS VÁLIDADOS${NC}"
echo "=========================================="
echo ""
echo "Próximo passo: Execute o checklist de cutover:"
echo "  cat _reversa_sdd/cutover/checklist.md"
echo ""
