FROM node:18-alpine

WORKDIR /app

# ✅ Install netcat-openbsd (fixes missing package error)
RUN apt-get update && apt-get install -y netcat-openbsd

COPY package*.json ./
RUN npm install

COPY . .

COPY wait-for-it.sh .
RUN chmod +x wait-for-it.sh

EXPOSE 5002

CMD ["./wait-for-it.sh", "postgres", "5432", "--", "npm", "start"]
