import express, { Request, Response } from "express";
import authRoutes from './src/routes/auth';
import scheduleRoutes from './src/routes/schedule';
import performanceRoutes from "./src/routes/performance";
import profileRoutes from "./src/routes/profile";
import aiRoutes from "./src/routes/ai";
import cors from "cors";
import mongoose from 'mongoose';
import dotenv from 'dotenv';
dotenv.config();

const mongo_uri = process.env.MONGO_URI || "mongodb://192.168.1.101:27017/TarteebDB";

mongoose.connect(mongo_uri).then(() => console.log("MongoDB Connected Successfully DB_Name: TarteebDB")).catch((err) => {console.log("MongoDB connection error: ", err)});


const app = express();
app.use(express.json());
app.use(cors());
const host = process.env.HOST || "0.0.0.0";
const port = parseInt(process.env.PORT || "5000", 10);

app.use('/api/auth', authRoutes);
app.use("/api/profile", profileRoutes);
app.use('/api', scheduleRoutes);
app.use("/api", performanceRoutes);
app.use("/api/ai", aiRoutes);

app.listen(port, host, () => {
  console.log(`server running on http://${host}:${port}/`);
});