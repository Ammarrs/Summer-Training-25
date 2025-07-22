import mongoose, { Document, Schema } from 'mongoose';
import Joi from 'joi';

export interface IUser extends Document {
  username: string,
  email: string,
  password: string,
  college: string,
  major: string,
  createdAt: Date,
}


const userSchema: Schema<IUser> = new Schema({
  username: {
    type: String,
    required: true,
    trim: true,
    minlength: 3,
    maxlength: 30,
  },
  email: {
    type: String,
    required: true,
    unique: true,
    trim: true,
    minlength: 3,
    maxlength: 30,
  },
  password: {
    type: String,
    required: true,
    trim: true,
    minlength: 8,
  },
  college: {
    type: String,
    required: true,
    trim: true,
  },
  major: {
    type: String,
    required: true,
    trim: true,
  },
}, {
  timestamps: true
});

export type userInput = {
  username: string;
  email: string;
  password: string;
  confirmPassword: string;
  college: string;
  major: string;
};


export const registerValidation = (obj: userInput) => {
  const schema = Joi.object({
    username: Joi.string().trim().min(3).max(30).required().messages({
      "string.base": "Username must be String!",
      "string.empty": "Username can't be emrty!",
      "string.min": "Username must be at least 3 characters",
      "string.max": "Username must be less than 20 characters",
    }),
    email: Joi.string().trim().email().required().messages({
      "string.email": "please enter a valid email...",
      "string.empty": "Email can't be empty",
    }),
    password: Joi.string().trim().required().min(8).messages({
      "string.min": "Password can't be less than 3",
      "string.empty": "Password is required",
    }),
    confirmPassword: Joi.string().trim().valid(Joi.ref("password")).required().messages({
      "any.only": "Passwords do not match",
      "string.empty": "Confirm password is required",
      }),
    college: Joi.string().trim().required().messages({
      "string.empty": "College is required",
    }),
    major: Joi.string().trim().required().messages({
      "string.empty": "Major is required",
    }),
  });

  return schema.validate(obj);
}

export const userModel = mongoose.model<IUser>("User", userSchema);
