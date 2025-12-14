FROM node:25 AS builder
COPY code/ /opt/server/
RUN npm install --prefix /opt/server/

FROM node:25-alpine3.23
EXPOSE 3000
RUN addgroup -S app \
    && adduser -S app -G app
COPY --from=builder /opt/server/ /opt/server/
USER app
CMD ["node", "/opt/server/index.js"]