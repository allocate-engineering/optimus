const express = require("express");
const { Pool } = require("pg");
const app = express();
const port = process.env.PORT || 3000;

const dbConnectionString = process.env.DB_CONNECTION_STRING;
if (!dbConnectionString) {
  console.error(
    "DB_CONNECTION_STRING environment variable is missing. Format: postgresql://user:pass@hostname:5432/database",
  );
  process.exit(1);
}

const pool = new Pool({
  connectionString: dbConnectionString,
});

app.get("/", (req, res) => {
  pool.query("SELECT NOW()", (err, result) => {
    if (err) {
      res.status(500).send("Error connecting to the database");
    } else {
      res.send(`Hello from backend! Database time: ${result.rows[0].now}`);
    }
  });
});

app.get("/health", (req, res) => {
  res.status(200).send("OK");
});

app.listen(port, () => {
  console.log(`Backend listening on port ${port}`);
});

