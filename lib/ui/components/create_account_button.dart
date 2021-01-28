import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesa_news/main/pages/app_pages.dart';

class CreateAccountButton extends StatelessWidget {
  final bool backgroundWhite;

  const CreateAccountButton({Key key, this.backgroundWhite = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(AppPages.sigunp),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Não tenho conta. ',
            style: TextStyle(
                color: backgroundWhite
                    ? Theme.of(context).backgroundColor
                    : Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500,
                // fontSize: 14,
                letterSpacing: -0.41),
          ),
          Text(
            'Cadastrar',
            style: TextStyle(color: Color(0XFF0075FF)),
          )
        ],
      ),
    );
  }
}
