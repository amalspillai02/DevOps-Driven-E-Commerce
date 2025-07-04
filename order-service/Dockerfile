FROM node:18-alpine

# ✅ Set working directory
WORKDIR /app

# ✅ Install netcat for readiness checks
RUN apk add --no-cache netcat-openbsd

# ✅ Install app dependencies
COPY package*.json ./
RUN npm install

# ✅ Copy rest of the app
COPY . .

# ✅ Expose port (default for order-service)
EXPOSE 5002

# ✅ Start the service
CMD ["npm", "start"]
