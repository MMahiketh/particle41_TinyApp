FROM node:25
COPY code/ /opt/server/
RUN npm install --prefix /opt/server/ \
    && addgroup -S expense \
    && adduser -S expense -G expense
EXPOSE 3000
CMD ["node", "/opt/server/index.js"]