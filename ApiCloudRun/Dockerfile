# Imagen base oficial de Node.js
FROM node:18-slim

# Directorio de trabajo
WORKDIR /app

# Copiar dependencias y código
COPY package*.json ./
RUN npm install --only=production
COPY . .

# Variable de puerto
ENV PORT=8080

# Exponer puerto (para referencia)
EXPOSE 8080

# Comando de arranque
CMD ["npm", "start"]