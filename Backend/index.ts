import express, { Request, Response } from "express";
import authRoutes from './src/routes/auth';
import scheduleRoutes from './src/routes/schedule';
import performanceRoutes from "./src/routes/performance";
import profileRoutes from "./src/routes/profile";
import aiRoutes from "./src/routes/ai";
import mongoose from 'mongoose';
import dotenv from 'dotenv';
dotenv.config();

const mongo_uri = process.env.MONGO_URI || "mongodb://localhost:27017/TarteebDB";

mongoose.connect(mongo_uri).then(() => console.log("MongoDB Connected Successfully DB_Name: TarteebDB")).catch((err) => {console.log("MongoDB connection error: ", err)});


const app = express();
app.use(express.json());
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