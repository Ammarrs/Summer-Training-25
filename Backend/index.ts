import express, { Request, Response } from "express";
import dotenv from 'dotenv';
dotenv.config();

const app = express();
const host = process.env.HOST;
const port = process.env.PORT;

app.get('/', (req: Request, res: Response) => {
  res.send(`Test the app on port: ${port}`);
});

app.listen(port, () => {
  console.log(`server running on http://${host}:${port}/`);
});