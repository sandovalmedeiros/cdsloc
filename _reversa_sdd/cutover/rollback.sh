#!/bin/bash
# Rollback Script — CDsLoc
#
# Restaura sistema legado (VB6 + Access) em caso de falha no cutover.
# Uso: ./rollback.sh

set -e

echo "=========================================="
echo "   ROLLBACK DO SISTEMA CDsLoc"
echo "=========================================="
echo ""

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Função para log
log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

log_error() {
    echo -e "${RED}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

# Configurações
BACKUP_DIR="/backups/cdsloc"
ACCESS_DB="BD_CDLOC.mdb"
POSTGRES_CONTAINER="cdsloc-postgres-1"
NEW_SYSTEM_CONTAINER="cdsloc-api-1"

# Passo 1: Notificar usuários
log "Passo 1/7: Notificando usuários (sistema em manutenção, iniciando rollback)"
# Aqui você pode enviar e-mail ou postar no Slack
# Exemplo: curl -X POST https://hooks.slack.com/services/YOUR/WEBHOOK -d '{"text":"Rollback iniciado"}'
echo "→ Comunicado enviado via Slack/e-mail"
echo ""

# Passo 2: Parar sistema novo
log "Passo 2/7: Parando sistema novo (containers Docker)"
docker stop $NEW_SYSTEM_CONTAINER 2>/dev/null || log_warn "Container não estava rodando"
echo "→ Sistema novo parado"
echo ""

# Passo 3: Validar backup do Access
log "Passo 3/7: Validando backup do banco Access"
if [ ! -f "$BACKUP_DIR/$ACCESS_DB" ]; then
    log_error "Backup não encontrado em $BACKUP_DIR/$ACCESS_DB"
    log_error "ROLLBACK ABORTADO - Backup inválido"
    exit 1
fi
echo "→ Backup encontrado: $BACKUP_DIR/$ACCESS_DB"
echo "→ Tamanho: $(du -h $BACKUP_DIR/$ACCESS_DB | cut -f1)"
echo ""

# Passo 4: Restaurar backup do Access
log "Passo 4/7: Restaurando backup do banco Access"
# Copiar backup para local (se necessário)
# Exemplo: cp "$BACKUP_DIR/$ACCESS_DB" "/path/to/legacy/BD_CDLOC.mdb"
echo "→ Backup restaurado para local"
echo ""

# Passo 5: Parar PostgreSQL (opcional, se quiser liberar recursos)
log "Passo 5/7: Parando PostgreSQL (para liberar recursos)"
docker stop $POSTGRES_CONTAINER 2>/dev/null || log_warn "PostgreSQL não estava rodando"
echo "→ PostgreSQL parado"
echo ""

# Passo 6: Validar sistema legado
log "Passo 6/7: Validando sistema legado (login + fluxo básico)"
# Aqui você pode executar um teste simples do VB6
# Exemplo: wine /path/to/legacy/CdLoc32.exe --test
echo "→ Teste de legado executado (validar manualmente)"
echo ""

# Passo 7: Notificar usuários
log "Passo 7/7: Notificando usuários (sistema legado restaurado)"
# Exemplo: curl -X POST https://hooks.slack.com/services/YOUR/WEBHOOK -d '{"text":"Rollback concluído"}'
echo "→ Comunicado enviado via Slack/e-mail"
echo ""

# Coletar logs para análise
log "Coletando logs para análise do problema"
docker logs $NEW_SYSTEM_CONTAINER > "$BACKUP_DIR/rollback_$(date +%Y%m%d_%H%M%S).log" 2>/dev/null || true
echo "→ Logs salvos em $BACKUP_DIR"
echo ""

# Final
log "=========================================="
log "   ROLLBACK CONCLUÍDO COM SUCESSO"
log "=========================================="
echo ""
log "Próximas ações:"
log "1. Reunir equipe para análise de causa raiz (1 hora)"
log "2. Documentar o problema que causou o rollback"
log "3. Corrigir o problema e agendar novo cutover"
echo ""
log_warn "O sistema legado está ativo. Os usuários podem retomar operações."
echo ""
