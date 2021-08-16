import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

//Top section of Mobile Number form
class PhoneFormDescription extends StatelessWidget {
  const PhoneFormDescription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              color: Colors.transparent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(360)),
          child: Lottie.asset('assets/anime/phone.json'),
        ),
        const SizedBox(height: 30),
        Text(
          'Mobile Number',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800]),
        ),
        const SizedBox(height: 10),
        Text(
          'We need to send OTP to authenticate your number',
          style: TextStyle(fontSize: 15, color: Colors.grey[700]),
        ),
      ],
    );
  }
}

//Top section of OTP form
class OtpFormDescription extends StatelessWidget {
  const OtpFormDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              color: Colors.transparent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(360)),
          child: Lottie.asset('assets/anime/otp.json'),
        ),
        const SizedBox(height: 30),
        Text(
          'OTP',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800]),
        ),
        const SizedBox(height: 10),
        Text(
          'Please enter the OTP sent to your mobile number',
          style: TextStyle(fontSize: 15, color: Colors.grey[700]),
        ),
      ],
    );
  }
}

//Paper plane loader
class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Lottie.asset('assets/anime/loading.json', fit: BoxFit.cover),
    );
  }
}
