FROM node:alpine

# Create app directory
WORKDIR /usr/src/app

# Copy package.json
COPY package*.json ./

# Install dependencies
RUN npm install express

# Copy all files
COPY . .

# Expose port 3000
EXPOSE 3000

# Run app
CMD [ "node", "index.js" ]