import 'package:get/get.dart';
import 'package:mdigits/src/core/navigator_service/navigator_service.dart';
import 'package:research_package/research_package.dart';
import 'package:mdigits/src/ipaq/model/items.dart';

class IPAQViewModel {
  RPOrderedTask get task => RPOrderedTask(
        identifier: 'ipaq_task',
        steps: ipaqSteps,
      );

  Future<void> closeIpaqPage() async {
    final NavigatorService navigatorService = Get.find();
    final String nextScreen = await navigatorService.determineNextScreen();
    Get.offAndToNamed(nextScreen);
  }
}
