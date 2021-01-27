import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesa_news/ui/pages/filter/filter_presenter.dart';
import '../../../main/pages/app_pages.dart';

import '../../helpers/filter_params.dart';

class FilterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<FilterPresenter>();

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
              onPressed: () => presenter.clearFilter(),
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
          Expanded(
            child: Column(
              children: [
                Obx(
                  () => ListTile(
                    onTap: () async {
                      final filterDate = await Get.toNamed(AppPages.filterDate);
                      if (filterDate != null) {
                        presenter.filterDate = filterDate;
                      }
                    },
                    title: Text('Data'),
                    trailing: Container(
                      width: 150,
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(presenter.filterDate.description),
                          Icon(
                            Icons.keyboard_arrow_right,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Apenas favoritos'),
                  trailing: Obx(
                    () => CupertinoSwitch(
                      value: presenter.isFavorite,
                      onChanged: (value) {
                        presenter.isFavorite = value;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => AnimatedContainer(
              duration: Duration(milliseconds: 400),
              height: presenter.updated ? 60 : 0,
              width: double.infinity,
              child: RaisedButton(
                onPressed: () => Get.back(
                  result: FilterParams(
                    filterDate: presenter.filterDate,
                    isFavorite: presenter.isFavorite,
                  ),
                ),
                child: Text('Filtrar'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
