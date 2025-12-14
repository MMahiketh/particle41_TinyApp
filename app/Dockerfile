FROM node:25 AS builder
# Copy Code files to temporary docker image (~builder)
COPY code/ /opt/server/
# Installs npm dependencies
RUN npm install --prefix /opt/server/

FROM node:25-alpine3.23
# This doesn't open any port but hints user that 3000 port is where the app is running
EXPOSE 3000
# Creating a user and a group in docker image
RUN addgroup -S app \
    && adduser -S app -G app
# Takes the compiled files from temporary image and moves into this docker image. So that it can run.
COPY --from=builder /opt/server/ /opt/server/
# Changing the user to non-root user(app)
USER app
# Serves index.js file using Node.
CMD ["node", "/opt/server/index.js"]