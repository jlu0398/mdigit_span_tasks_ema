import 'package:flutter/material.dart';
import 'package:research_package/model.dart';

import '../view/custom_task_widget.dart';
import '../viewmodel/ipaq_viewmodel.dart';

class IPAQPage extends StatelessWidget {
  final IPAQViewModel viewModel;
  final void Function(RPTaskResult) onSubmit;

  const IPAQPage({super.key, required this.viewModel, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return CustomTaskWidget(
      task: viewModel.task,
      onSubmit: onSubmit,
    );
  }
}
