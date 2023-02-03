## Build Stage
# Node as base image to build the product
FROM node:16-alpine as builder

# Create the work directory and switch to it
WORKDIR /app

# Install all dependencies
COPY package.json .
RUN npm install
COPY . .
# Build the product
RUN npm run build

# Run Stage
# Base image for production server
FROM nginx

# Copy the image of the build stage
COPY --from=builder /app/build /usr/share/nginx/html

# In this case, no need to specifically state CMD for the start command