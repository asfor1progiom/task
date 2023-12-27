import 'package:flutter/material.dart';

class Constants {
  static const baseUrl = 'https://testapi.alifouad91.com/api';
  static const loginApiUrl = baseUrl + '/login';
  static const registerApiUrl = baseUrl + '/user/register';
  static const getUserApiUrl = baseUrl + '/user/';
  static const updateInformation = baseUrl + '/user/update';
  static const updatePassword = baseUrl + '/user/changepassword';
  static const deleteAccount = baseUrl + '/user/delete';
}

class AppColors {
  static const primary = Color(0xff370A45);
}
