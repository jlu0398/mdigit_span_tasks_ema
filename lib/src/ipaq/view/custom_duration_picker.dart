import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDurationPicker extends StatefulWidget {
  final Duration initialDuration;
  final ValueChanged<Duration> onDurationChanged;
  final int maxHours;
  final int maxMinutes;

  const CustomDurationPicker({
    Key? key,
    required this.initialDuration,
    required this.onDurationChanged,
    this.maxHours = 99,
    this.maxMinutes = 59,
  }) : super(key: key);

  @override
  State<CustomDurationPicker> createState() => _CustomDurationPickerState();
}

class _CustomDurationPickerState extends State<CustomDurationPicker> {
  int selectedHours = 0;
  int selectedMinutes = 0;

  @override
  void initState() {
    super.initState();
    selectedHours = widget.initialDuration.inHours;
    selectedMinutes = widget.initialDuration.inMinutes % 60;
  }

  void _updateDuration() {
    final duration = Duration(hours: selectedHours, minutes: selectedMinutes);
    widget.onDurationChanged(duration);
  }

  void _feedback() {
    SystemSound.play(SystemSoundType.click);
    HapticFeedback.heavyImpact();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPicker(
            label: 'Horas',
            value: selectedHours,
            max: widget.maxHours,
            onChanged: (index) {
              setState(() => selectedHours = index);
              _updateDuration();
              _feedback();
            },
          ),
          const Text(":", style: TextStyle(fontSize: 35)),
          _buildPicker(
            label: 'Minutos',
            value: selectedMinutes,
            max: widget.maxMinutes,
            onChanged: (index) {
              setState(() => selectedMinutes = index);
              _updateDuration();
              _feedback();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPicker({
    required String label,
    required int value,
    required int max,
    required ValueChanged<int> onChanged,
  }) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 35,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          Expanded(
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(initialItem: value),
              itemExtent: 45,
              useMagnifier: true,
              magnification: 1.3,
              squeeze: 0.9,
              onSelectedItemChanged: onChanged,
              children: List.generate(
                max + 1,
                (index) => Center(
                  child: Text(
                    index.toString().padLeft(2, '0'),
                    style: const TextStyle(fontSize: 35),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
