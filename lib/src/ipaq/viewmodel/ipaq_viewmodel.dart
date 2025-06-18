import 'package:research_package/research_package.dart';
import 'package:mdigits/src/ipaq/model/items.dart';

class IPAQViewModel {
  RPOrderedTask get task => RPOrderedTask(
        identifier: 'ipaq_task',
        steps: ipaqSteps,
      );
}
