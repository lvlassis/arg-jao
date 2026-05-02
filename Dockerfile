# Dockerfile para o projeto Nuxt
FROM node:20-alpine AS base

# Instalar dependências necessárias para better-sqlite3
RUN apk add --no-cache python3 make g++

WORKDIR /app

# Estágio de dependências
FROM base AS deps

COPY package*.json ./
RUN npm ci

# Estágio de build
FROM base AS builder

COPY --from=deps /app/node_modules ./node_modules
COPY . .

RUN npm run build

# Estágio de produção
FROM node:20-alpine AS runner

WORKDIR /app

# Copiar apenas os arquivos necessários para produção
COPY --from=builder /app/.output ./.output
COPY --from=builder /app/package*.json ./

ENV NODE_ENV=production
ENV HOST=0.0.0.0
ENV PORT=3000

EXPOSE 3000

CMD ["node", ".output/server/index.mjs"]
