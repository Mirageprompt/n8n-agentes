FROM n8nio/n8n:latest

# Configurações Railway
USER root

# Instalar dependências
RUN apk add --no-cache curl

# Criar diretório de trabalho
WORKDIR /home/node/.n8n

# Voltar para usuário node
USER node

# Variáveis de ambiente Railway
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=${PORT:-5678}
ENV N8N_PROTOCOL=https
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=admin
ENV N8N_BASIC_AUTH_PASSWORD=agentes123
ENV DB_TYPE=sqlite
ENV N8N_LOG_LEVEL=info
ENV N8N_PUBLIC_API_DISABLED=false
ENV N8N_DIAGNOSTICS_ENABLED=false
ENV N8N_VERSION_NOTIFICATIONS_ENABLED=false

# Expor porta dinâmica do Railway
EXPOSE ${PORT:-5678}

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:${PORT:-5678}/healthz || exit 1

# Comando de inicialização
ENTRYPOINT []
CMD ["npx", "n8n", "start"]