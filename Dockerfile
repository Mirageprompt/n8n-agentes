FROM n8nio/n8n:latest

# Instalar curl para health check
USER root
RUN apk add --no-cache curl
USER node

# Configurações
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=https
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=admin
ENV N8N_BASIC_AUTH_PASSWORD=agentes123
ENV DB_TYPE=sqlite
ENV N8N_LOG_LEVEL=info
ENV N8N_PUBLIC_API_DISABLED=false

EXPOSE 5678

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD curl -f http://localhost:5678/healthz || exit 1

CMD ["n8n", "start"]