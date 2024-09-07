import 'package:flutter/material.dart';

import '../../../repository/firebase_repository.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  String? oldpassword;
  String? newpassword;
  String? email;
  String? otp;

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setOtp(String value) {
    otp = value;
    notifyListeners();
  }

  void setOldPassword(String value) {
    oldpassword = value;
    notifyListeners();
  }

  void setNewPassword(String value) {
    newpassword = value;
    notifyListeners();
  }

  Future<bool> verifyEmail() async {
    if (email == null || email!.isEmpty) {
      throw Exception('Email cannot be empty');
    }
    try {
      return await FirebaseRepository.verifyEmail(email: email!);
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<void> verifyOtp() async {}

  Future<void> resetPassword() async {}
}
