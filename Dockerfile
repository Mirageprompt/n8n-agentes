FROM n8nio/n8n:0.234.0

# Railway configuration
USER root

# Install curl for healthcheck
RUN apk add --no-cache curl

# Switch back to node user
USER node

# Set working directory
WORKDIR /home/node/.n8n

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
ENV N8N_DIAGNOSTICS_ENABLED=false

# Expose port
EXPOSE ${PORT:-5678}

# Use the original entrypoint and command from n8n image
ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
CMD ["n8n"]