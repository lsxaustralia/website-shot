# Use compatible Node version
FROM node:18-alpine

# Set working directory
WORKDIR /usr/src/website-shot

# Install Chromium and a fallback font
RUN apk add --no-cache git chromium font-noto --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing

# Copy and install dependencies
COPY package*.json ./
RUN yarn install

# Copy the rest of the app
COPY . .

# Generate static files (Nuxt)
RUN yarn generate
RUN yarn build

# Set environment variables
ENV NUXT_HOST=0.0.0.0
ENV NUXT_PORT=3000
ENV PASSWORD_PROTECT=0
ENV PASSWORD=null
ENV RUNNING_DOCKER=1
ENV USER_AGENT="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36"
ENV BLOCK_ADS=1
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

# Expose port
EXPOSE 3000

# Start the app
CMD ["yarn", "start"]
