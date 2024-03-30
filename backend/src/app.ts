import express, { Application, Request, Response, NextFunction } from "express";
import cors from "cors";
import bodyParser from "body-parser";
import { pool, initalize } from "./database";
const app = express();
app.use(cors());
app.use(bodyParser.json());
initalize();
app.get("/", async (req, res) => {
  res.send("Heylo");
});
app.get("/users", async (req, res) => {
  const response = await pool.query('SELECT id, name, email FROM "user"');
  console.log(response.rows);
  //send response body and status code
  res.status(200).send(response.rows);
});

app.post("/users", async (req, res) => {
  console.log(req.body);
  await pool.query(
    'INSERT INTO "user" (name, email, password) VALUES ($1, $2, $3)',
    [req.body.name, req.body.email, req.body.password],
  );

  res.status(201).send("Usuario adicionado com sucesso");
});

app.get("/api/get/:id", async (req, res) => {
  const response = await pool.query('SELECT * FROM "user" WHERE id = $1', [
    req.params.id,
  ]);
  console.log(response);
  res.status(200).send(response.rows);
});

app.listen(3025, () => {
  console.log("Listening to 3025");
});
