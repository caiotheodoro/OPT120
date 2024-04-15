import express from "express";
import cors from "cors";
import bodyParser from "body-parser";
import { pool } from "./database";
import { ActivityController,UserActivityController,UserController } from "./modules";


const app = express();
app.use(cors());
app.use(bodyParser.json());

const userActivityController = new UserActivityController(pool);
const userController = new UserController(pool);
const activitiesController = new ActivityController(pool);

app.use("/user-activities", userActivityController.getRouter());
app.use("/users", userController.getRouter());
app.use("/activities", activitiesController.getRouter());

app.listen(3025, () => {
  console.log("Listening to 3025");
});
