import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterPage extends StatelessWidget {
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
        actions: [
          SizedBox(
            width: 70,
            child: RaisedButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: Text(
                'Limpar',
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Data'),
          ),
          ListTile(
            title: Text('Apenas favoritos'),
          ),
        ],
      ),
    );
  }
}
