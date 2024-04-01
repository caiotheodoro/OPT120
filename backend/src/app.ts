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

app.get("/api/users/get/:id", async (req, res) => {
  const response = await pool.query('SELECT * FROM "user" WHERE id = $1', [
    req.params.id,
  ]);
  console.log(response);
  res.status(200).send(response.rows);
});

app.put("/api/users/update/:id", async (req, res) => {
  await pool.query(
    'UPDATE "user" SET name = $1, email = $2 WHERE id = $3',
    [req.body.name, req.body.email, req.params.id],
  );
  res.status(200).send(`User modified with ID: ${req.params.id}`);
});

app.delete("/api/users/delete/:id", async (req, res) => {
  await pool.query('DELETE FROM "user" WHERE id = $1', [req.params.id]);
  res.status(200).send(`User deleted with ID: ${req.params.id}`);
});


//activities
app.get("/activities", async (req, res) => {
  const response = await pool.query('SELECT * FROM "activity"');
  console.log(response.rows);
  res.status(200).send(response.rows);
});

// CREATE TABLE activity (
//   id SERIAL PRIMARY KEY,
//   title VARCHAR(200) NOT NULL,
//   description VARCHAR(500) NOT NULL,
//   "date" TIMESTAMP NOT NULL
// );

// CREATE TABLE user_activity (
//   userId INTEGER REFERENCES "user"(id) NOT NULL,
//   activityId INTEGER REFERENCES activity(id) NOT NULL,
//   deliver TIMESTAMP,
//   grade DOUBLE PRECISION
// );

app.post("/activities", async (req, res) => {
  console.log(req.body);
  await pool.query(
    'INSERT INTO "activity" (title, description, date) VALUES ($1, $2, $3)',
    [req.body.title, req.body.description, req.body.date],
  );

  res.status(201).send("Atividade adicionada com sucesso");
});

app.get("/api/activities/get/:id", async (req, res) => {
  const response = await pool.query('SELECT * FROM "activity" WHERE id = $1', [
    req.params.id,
  ]);
  console.log(response);
  res.status(200).send(response.rows);
});

app.put("/api/activities/update/:id", async (req, res) => {
  await pool.query(
    'UPDATE "activity" SET title = $1, description = $2, date = $3 WHERE id = $4',
    [req.body.title, req.body.description, req.body.date, req.params.id],
  );
  res.status(200).send(`Activity modified with ID: ${req.params.id}`);
});

app.delete("/api/activities/delete/:id", async (req, res) => {
  await pool.query('DELETE FROM "activity" WHERE id = $1', [req.params.id]);
  res.status(200).send(`Activity deleted with ID: ${req.params.id}`);
});


//user_activity
app.get("/user-activities", async (req, res) => {
  const response = await pool.query('SELECT * FROM "user_activity"');
  console.log(response.rows);
  res.status(200).send(response.rows);
});

app.post("/user-activities", async (req, res) => {
  console.log(req.body);
  await pool.query(
    'INSERT INTO "user_activity" (userId, activityId, deliver, grade) VALUES ($1, $2, $3, $4)',
    [req.body.userId, req.body.activityId, req.body.deliver, req.body.grade],
  );

  res.status(201).send("Atividade adicionada com sucesso");
});

app.get("/api/user-activities/get/:id", async (req, res) => {
  const response = await pool.query('SELECT * FROM "user_activity" WHERE id = $1', [
    req.params.id,
  ]);
  console.log(response);
  res.status(200).send(response.rows);
});

app.put("/api/user-activities/update/:id", async (req, res) => {
  await pool.query(
    'UPDATE "user_activity" SET userId = $1, activityId = $2, deliver = $3, grade = $4 WHERE id = $5',
    [req.body.userId, req.body.activityId, req.body.deliver, req.body.grade, req.params.id],
  );
  res.status(200).send(`user-activities modified with ID: ${req.params.id}`);
});

app.delete("/api/user-activities/delete/:id", async (req, res) => {
  await pool.query('DELETE FROM "user_activity" WHERE id = $1', [req.params.id]);
  res.status(200).send(`user-activities deleted with ID: ${req.params.id}`);
});


app.listen(3025, () => {
  console.log("Listening to 3025");
});
