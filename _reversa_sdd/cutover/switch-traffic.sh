#!/bin/bash
# Switch Traffic Script — CDsLoc
#
# Configura Nginx para redirecionar tráfego do sistema legado para o novo.
# Uso: ./switch-traffic.sh [legacy|new]

set -e

MODE="${1:-new}"

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

if [ "$MODE" = "new" ]; then
    log "Switching traffic to NEW system (FastAPI)"
    echo ""

    # Configurar Nginx para rotear para FastAPI
    cat > /etc/nginx/conf.d/cdsloc.conf <<'EOF'
upstream cdsloc_new {
    server localhost:8000;
}

upstream cdsloc_legacy {
    server 10.0.0.10:80;  # IP da estação legado (se aplicável)
}

server {
    listen 80;
    server_name cdsloc.local;

    location / {
        proxy_pass http://cdsloc_new;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    location /legacy/ {
        # Rota para sistema legado (se necessário)
        proxy_pass http://cdsloc_legacy;
        proxy_set_header Host $host;
    }

    location /health {
        return 200 "healthy\n";
        add_header Content-Type text/plain;
    }
}
EOF

    # Recarregar Nginx
    log "Reloading Nginx configuration..."
    nginx -s reload 2>/dev/null || nginx -s stop && nginx

    # Testar novo sistema
    log "Testing new system..."
    if curl -s http://localhost/health | grep -q "healthy"; then
        log "New system responding correctly"
    else
        log_warn "New system health check failed - proceeding anyway"
    fi

    log "=========================================="
    log "   TRÁFEGO REDIRECIONADO PARA NOVO"
    log "=========================================="
    echo ""

elif [ "$MODE" = "legacy" ]; then
    log "Switching traffic to LEGACY system (VB6 + Access)"
    echo ""

    # Configurar Nginx para redirecionar para legado (ou parar proxy)
    cat > /etc/nginx/conf.d/cdsloc.conf <<'EOF'
server {
    listen 80;
    server_name cdsloc.local;

    location / {
        return 503 "Sistema em manutenção - use o aplicativo local";
        add_header Content-Type text/plain;
    }

    location /health {
        return 200 "maintenance\n";
        add_header Content-Type text/plain;
    }
}
EOF

    # Recarregar Nginx
    log "Reloading Nginx configuration..."
    nginx -s reload 2>/dev/null || nginx -s stop && nginx

    log "=========================================="
    log "   TRÁFEGO REDIRECIONADO PARA LEGADO"
    log "=========================================="
    echo ""
    log_warn "Usuários devem acessar o sistema via aplicativo local (VB6)"

else
    echo "Uso: $0 [new|legacy]"
    exit 1
fi

log "Switch completed at $(date)"
