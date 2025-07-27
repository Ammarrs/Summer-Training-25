import nodemailer from 'nodemailer';
import dotenv from 'dotenv';
dotenv.config();

const email_from = process.env.EMAIL_FROM;
const email_pass = process.env.EMAIL_PASS;


export const sendEmail = async (to: string, subject: string, html: string) => {
  const transport = nodemailer.createTransport({
    service: "gmail",
    auth: {
      user: email_from,
      pass: email_pass
    }
  });

  await transport.sendMail({
    from: email_from,
    to,
    subject,
    html
  });
};