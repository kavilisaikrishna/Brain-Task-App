# Stage 1: Build React app
FROM node:18-alpine AS build
WORKDIR /app

COPY brain-tasks-app/package*.json ./brain-tasks-app/
RUN npm install --prefix brain-tasks-app

COPY brain-tasks-app/ ./brain-tasks-app
RUN npm run build --prefix brain-tasks-app

# Stage 2: Nginx runtime
FROM nginx:alpine
COPY --from=build /app/brain-tasks-app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
