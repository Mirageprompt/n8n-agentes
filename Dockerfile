FROM n8nio/n8n:latest

# Railway setup
USER root
RUN apk add --no-cache curl
USER node

# Environment variables for Railway
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=${PORT:-5678}
ENV N8N_PROTOCOL=https
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=admin
ENV N8N_BASIC_AUTH_PASSWORD=agentes123
ENV DB_TYPE=sqlite
ENV N8N_LOG_LEVEL=info
ENV N8N_PUBLIC_API_DISABLED=false

# Expose Railway port
EXPOSE ${PORT:-5678}

# Start without aggressive healthcheck
CMD ["n8n", "start"]