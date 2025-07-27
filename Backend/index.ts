import express, { Request, Response } from "express";
import authRoutes from './src/routes/auth';
import mongoose from 'mongoose';
import dotenv from 'dotenv';
dotenv.config();

const mongo_uri = process.env.MONGO_URI || "mongodb://localhost:27017/TarteebDB";

mongoose.connect(mongo_uri).then(() => console.log("MongoDB Connected Successfully DB_Name: TarteebDB")).catch((err) => {console.log("MongoDB connection error: ", err)});


const app = express();
app.use(express.json());
const host = process.env.HOST || "localhost";
const port = process.env.PORT || 5000;

app.use('/api/auth', authRoutes);

app.listen(port, () => {
  console.log(`server running on http://${host}:${port}/`);
});