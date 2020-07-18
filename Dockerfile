# builder is the name of phase 
# everything below this is a builder phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# there is no need of as now docker will itself
# understand that new FROM means new phase
FROM nginx
# here we are copying everything from builder phase to
# nginx folder from where it serves static content
# you can get /usr location from docker hub documnet for
# nginx image
COPY --from=builder /app/build /usr/share/nginx/html
