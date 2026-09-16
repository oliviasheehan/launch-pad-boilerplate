const http = require("http");

const PORT = process.env.PORT || 3000;

const server = http.createServer((req, res) => {
  res.writeHead(200, { "Content-Type": "text/html" });
  res.end(`
    <html>
      <body style="font-family: sans-serif; text-align: center; padding: 4rem;">
        <h1>🚀 It works!</h1>
        <p>Live, served over HTTPS, with Postgres ready to go on DATABASE_URL.</p>
        <p>Replace this <code>app/</code> directory with your actual project.</p>
      </body>
    </html>
  `);
});

server.listen(PORT, () => console.log(`Listening on port ${PORT}`));
