# Stage 1: build
FROM node:18-alpine AS build
WORKDIR /app
# Copy package.json and package-lock.json from app folder
COPY brain-tasks-app/package*.json ./
RUN npm install
# Copy all source files
COPY brain-tasks-app/ ./
# Build the React app
RUN npm run build

# Stage 2: runtime
FROM nginx:alpine
# Copy build output to nginx html folder
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
