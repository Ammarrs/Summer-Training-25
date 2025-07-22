import express, { Request, Response } from "express";
import tasksRoute from './src/router/tasks'
import dotenv from 'dotenv';
dotenv.config();

const app = express();
const host = process.env.HOST;
const port = process.env.PORT;

app.use('/tasks', tasksRoute);

app.listen(port, () => {
  console.log(`server running on http://${host}:${port}/`);
});