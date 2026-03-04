# Stage 1: build
FROM node:18-alpine AS build
WORKDIR /app
COPY brain-tasks-app/package*.json ./brain-tasks-app/
RUN npm install --prefix brain-tasks-app
COPY brain-tasks-app/ ./brain-tasks-app
RUN npm run build --prefix brain-tasks-app

# Stage 2: runtime
FROM nginx:alpine
COPY --from=build /app/brain-tasks-app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
