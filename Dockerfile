# Stage 1: build
FROM node:18-alpine AS build
WORKDIR /app

# Copy package.json first, then install dependencies
COPY brain-tasks-app/package*.json ./brain-tasks-app/
RUN npm install --prefix brain-tasks-app

# Copy all source files
COPY brain-tasks-app/ ./brain-tasks-app

# Build the React app
RUN npm run build --prefix brain-tasks-app

# Stage 2: Nginx runtime
FROM nginx:alpine
# Copy build output from stage 1
COPY --from=build /app/brain-tasks-app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

