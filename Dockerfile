FROM node as builder
WORKDIR /usr/app
COPY package.json .

RUN npm config set registry https://registry.npmmirror.com \
    && npm install \
    && mkdir node_modules/.cache \
    && chmod -R 777 node_modules/.cache
COPY . .
RUN npm run build

#  /usr/app/build <--- this is the folder that we care about

FROM nginx
COPY --from=builder /usr/app/build /usr/share/nginx/html

# the default command of nginx image is to start nginx, so we don't need to specify it here


