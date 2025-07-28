import { Types } from 'mongoose';
import {userModel, IUser} from '../models/user';

export const findUserByEmail = async (email: string): Promise<IUser | null> => {
  return await userModel.findOne({ email });
}

export const findUserById = async (id: string): Promise<IUser | null> => {
  return await userModel.findById(id);
};

export const createUser = async (userData: {
  username: string;
  email: string;
  password: string;
  college: string;
  major: string;
  gender: "male" | "female";
}): Promise<IUser | null> => {
  const newUser = new userModel(userData);
  return await newUser.save();
};


export const updateUser = async (userId: string, updatedData: Partial<IUser>): Promise<IUser | null> => {
  return await userModel.findByIdAndUpdate(
    new Types.ObjectId(userId),
    updatedData,
    { new: true },
  );
};

export const deleteUserById = async (userId: string): Promise<IUser | null> => {
  return await userModel.findByIdAndDelete(new Types.ObjectId(userId));
};

