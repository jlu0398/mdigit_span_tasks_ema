import 'package:flutter/material.dart';
import '../viewmodel/ipaq_viewmodel.dart';
import '../view/custom_task_widget.dart';

class IPAQPage extends StatelessWidget {
  final IPAQViewModel viewModel = IPAQViewModel();

  IPAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTaskWidget(
      task: viewModel.task,
      onSubmit: (result) {
        viewModel.saveData(result);
        viewModel.closeIpaqPage();
      },
    );
  }
}
