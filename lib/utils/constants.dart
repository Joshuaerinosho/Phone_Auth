import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum VerificationState { SHOW_FORM_STATE, SHOW_OTP_STATE }

//variables
VerificationState currentState = VerificationState.SHOW_FORM_STATE;
final phoneController = TextEditingController();
final otpController = TextEditingController();
final auth = FirebaseAuth.instance;
bool showLoading = false;
String? verificationId1;

//UI related
const buttonSize = Size(200, 40);
const primaryColor = Color.fromRGBO(225, 212, 112, 1);
const primaryPadding = EdgeInsets.symmetric(horizontal: 20);
const mainAlignment = MainAxisAlignment.center;
const buttonTextColor = Colors.black;
const loginButtonText = Text('Next');
const otpButtonText = Text('Verify');
const spacer = Spacer();
const formHeightSizedBox = SizedBox(height: 60);
const phoneTextFieldDecoration = InputDecoration(hintText: 'Mobile Number');
const otpTextFieldDecoration = InputDecoration(hintText: 'Enter otp');

//Decoration
final idleDecoration = BoxDecoration(
    color: Colors.grey[100], borderRadius: BorderRadius.circular(15));

final activeDecoration = BoxDecoration(
    color: Colors.grey[300], borderRadius: BorderRadius.circular(10));

const formSectionDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(70),
  ),
);
