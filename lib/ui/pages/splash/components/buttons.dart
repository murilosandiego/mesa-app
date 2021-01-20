import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesa_news/ui/components/app_button.dart';
import 'package:mesa_news/ui/components/create_account_button.dart';
import 'package:mesa_news/ui/pages/login/login_page.dart';

class Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppButton(
            text: 'Entrar com facebook',
            textColor: Color(0XFF0075FF),
            color: Colors.white,
            onPressed: () {},
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppButton(
            text: 'Entrar com e-mail',
            textColor: Colors.white,
            outLine: true,
            borderColor: Colors.white,
            onPressed: () => Get.to(LoginPage()),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 32),
          child: CreateAccountButton(),
        ),
      ],
    );
  }
}