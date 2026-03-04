# Stage 1: Build React app
FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./           # Copy root package.json if npm is at root
RUN npm install
COPY . .                        # Copy everything
RUN npm run build                # This generates dist/

# Stage 2: Nginx runtime
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

