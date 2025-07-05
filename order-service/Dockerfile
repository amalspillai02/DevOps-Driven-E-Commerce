# Use Node.js Alpine base image
FROM node:18-alpine

# Create app directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the app code
COPY . .

# Expose the port
EXPOSE 5002

# Start the service
CMD ["npm", "start"]
