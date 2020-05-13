# Production File

# Run Build Phase
# Using the AS command we create a spcific phase, that will allow us to
# later get some of the data in another phase or step in the image
# build process.
FROM node:12-alpine AS builder

WORKDIR /app

COPY package.json .
RUN npm install

COPY . .

RUN npm run build

FROM nginx
EXPOSE 80

# Copy only the files from the /app/build folder in the builder
# phase to the target folder indicated by the nginx docs
COPY --from=builder /app/build /usr/share/nginx/html
