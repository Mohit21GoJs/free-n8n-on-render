# Use the official n8n image as base
FROM docker.n8n.io/n8nio/n8n:latest

# Set the working directory
WORKDIR /home/node

# Create necessary directories
USER root
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n

# Switch back to node user
USER node

# Expose the port that n8n will run on
EXPOSE 10000

# Set default environment variables (these can be overridden by Render)
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=10000
ENV N8N_PROTOCOL=https

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:10000/healthz || exit 1

# The CMD will be overridden by dockerCommand in render.yaml
CMD ["n8n", "start"] 