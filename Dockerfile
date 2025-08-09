# Base image oficial Node.js
FROM node:18-alpine

# Instalar dependências do sistema
RUN apk add --no-cache \
    curl \
    git \
    bash \
    python3 \
    make \
    g++ \
    cairo-dev \
    jpeg-dev \
    pango-dev \
    giflib-dev

# Criar usuário node se não existir
RUN addgroup -g 1000 node || true
RUN adduser -u 1000 -G node -s /bin/sh -D node || true

# Instalar n8n globalmente
RUN npm install -g n8n

# Criar diretório de trabalho
WORKDIR /home/node/.n8n
RUN chown -R node:node /home/node

# Mudar para usuário node
USER node

# Variáveis de ambiente
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

# Expor porta
EXPOSE ${PORT:-5678}

# Comando de inicialização
CMD ["n8n", "start"]