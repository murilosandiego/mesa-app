import 'package:get/get.dart';

import '../../ui/pages/filter/filter_presenter.dart';

class FilterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilterPresenter>(() => FilterPresenter(), fenix: true);
  }
}
