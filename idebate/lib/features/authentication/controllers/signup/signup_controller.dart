import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController
{
  final nationalId = TextEditingController();
  final email  = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  final otp = TextEditingController();
  final hidePassword = true.obs;
}