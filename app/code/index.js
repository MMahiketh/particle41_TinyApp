const http = require("http");

const server = http.createServer((req, res) => {
  const ip =
    req.headers["x-forwarded-for"] || req.socket.remoteAddress || null;

  const result = {
    timestamp: new Date().toISOString(),
    ip: ip
  };

  res.writeHead(200, { "Content-Type": "application/json" });
  res.end(JSON.stringify(result, null, 2));
});

server.listen(3000, () => {
  console.log("Server running on port 3000");
});