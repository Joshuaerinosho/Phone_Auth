import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth/screens/home_screen.dart';
import 'package:phone_auth/utils/constants.dart';
import 'package:phone_auth/utils/widgets.dart';
import 'package:pinput/pin_put/pin_put.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void signInWithPhoneCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
          await auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });

      if (authCredential.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message!),
      ));
    }
  }

// Displays Mobile number form
  getPhoneForm(context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: primaryColor,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: mainAlignment,
          children: [
            const Expanded(child: PhoneFormDescription()),
            Expanded(
              child: Container(
                decoration: formSectionDecoration,
                child: Padding(
                  padding: primaryPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: phoneController,
                        decoration: phoneTextFieldDecoration,
                        keyboardType: TextInputType.number,
                      ),
                      formHeightSizedBox,
                      TextButton(
                        onPressed: () async {
                          setState(() {
                            showLoading = true;
                          });
                          await auth.verifyPhoneNumber(
                              phoneNumber: phoneController.text,
                              verificationCompleted: (authCredential) async {
                                /** Uncomment this to verify OTP automatically */
                                // signInWithPhoneCredential(authCredential);
                                setState(() {
                                  showLoading = false;
                                });
                              },
                              verificationFailed: (failedVerification) async {
                                setState(() {
                                  showLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(failedVerification.message!),
                                  ),
                                );
                              },
                              codeSent: (verificationId, resendToken) async {
                                setState(() {
                                  showLoading = false;
                                  verificationId1 = verificationId;
                                  currentState =
                                      VerificationState.SHOW_OTP_STATE;
                                });
                              },
                              codeAutoRetrievalTimeout:
                                  (verificationId) async {});
                        },
                        child: loginButtonText,
                        style: TextButton.styleFrom(
                            backgroundColor: primaryColor,
                            primary: buttonTextColor,
                            fixedSize: buttonSize),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Displays Otp form
  getOTPForm(context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: primaryColor,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: mainAlignment,
          children: [
            const Expanded(child: OtpFormDescription()),
            Expanded(
              child: Container(
                decoration: formSectionDecoration,
                child: Padding(
                  padding: primaryPadding,
                  child: Column(
                    mainAxisAlignment: mainAlignment,
                    children: [
                      spacer,
                      PinPut(
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        fieldsCount: 6,
                        selectedFieldDecoration: idleDecoration,
                        followingFieldDecoration: idleDecoration,
                        submittedFieldDecoration: activeDecoration,
                      ),
                      formHeightSizedBox,
                      TextButton(
                        onPressed: () async {
                          PhoneAuthCredential phoneAuthCredential =
                              PhoneAuthProvider.credential(
                                  verificationId: verificationId1!,
                                  smsCode: otpController.text);
                          signInWithPhoneCredential(phoneAuthCredential);
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: primaryColor,
                            primary: buttonTextColor,
                            fixedSize: buttonSize),
                        child: otpButtonText,
                      ),
                      spacer
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showLoading == true
          ? const Center(
              child: CustomLoader(),
            )
          : currentState == VerificationState.SHOW_FORM_STATE
              ? getPhoneForm(context)
              : getOTPForm(context),
    );
  }
}
