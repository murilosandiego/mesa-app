import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/filter_params.dart';

class FilterDatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 38,
        leading: Padding(
          padding: const EdgeInsets.all(0),
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios),
            color: Theme.of(context).highlightColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Filtro',
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Último ano'),
            onTap: () => Get.back(result: FilterDate.lastYear),
          ),
          ListTile(
            title: Text('Último mês'),
            onTap: () => Get.back(result: FilterDate.lastMonth),
          ),
          ListTile(
            title: Text('Essa semana'),
            onTap: () => Get.back(result: FilterDate.thisWeek),
          ),
          ListTile(
            title: Text('Últimas 24 horas'),
            onTap: () => Get.back(result: FilterDate.lastTwentyFourHours),
          ),
          ListTile(
            title: Text('Todas'),
            onTap: () => Get.back(result: FilterDate.all),
          ),
        ],
      ),
    );
  }
}
