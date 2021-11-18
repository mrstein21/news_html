import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:news_app/ui/detail_news/detail_news_controller.dart';

class DetailNewsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DetailNewsController());
    // TODO: implement dependencies
  }

}