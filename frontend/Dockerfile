# Build stage with VITE_API_URL as build argument
FROM node:20 AS builder

# Set build argument for API URL
ARG VITE_API_URL=http://localhost:8001
ENV VITE_API_URL=${VITE_API_URL}

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# Build with the API URL
RUN npm run build

FROM nginx:alpine

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
