import 'package:get/get.dart';

import '../../helpers/filter_params.dart';

class FilterPresenter extends GetxController {
  final _isFavorite = false.obs;
  final _filterDate = Rx<FilterDate>();
  final _updated = false.obs;

  bool get isFavorite => _isFavorite.value;
  FilterDate get filterDate => _filterDate.value;
  bool get updated => _updated.value;

  set isFavorite(bool value) {
    _isFavorite.value = value;
    _updated.value = true;
  }

  set filterDate(FilterDate value) {
    _filterDate.value = value;
    _updated.value = true;
  }

  set updated(value) => _updated.value = value;

  clearFilter() {
    _isFavorite.value = false;
    _filterDate.value = FilterDate.all;
    _updated.value = false;
  }
}
