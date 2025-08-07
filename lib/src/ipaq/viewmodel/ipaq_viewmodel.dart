import 'package:mdigits/src/ipaq/model/items.dart';
import 'package:research_package/research_package.dart';

class IPAQViewModel {
  final RPOrderedTask task;

  IPAQViewModel()
      : task = RPOrderedTask(
          identifier: 'ipaq_task',
          steps: ipaqSteps,
        );
}
