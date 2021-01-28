import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/form_signup.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          'Cadastrar',
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 24),
        children: [
          FormSignup(),
        ],
      ),
    );
  }
}
