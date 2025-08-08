import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StatsController());
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadísticas'),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Digit Span'),
                Tab(text: 'Trail Making'),
                Tab(text: 'IPAQ'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _DigitSpanTab(controller: controller),
                  _TrailMakingTab(controller: controller),
                  _IpaqTab(controller: controller),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: controller.refreshData,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Actualizar'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------- DIGIT SPAN ----------------

class _DigitSpanTab extends StatelessWidget {
  const _DigitSpanTab({required this.controller});
  final StatsController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final s = controller.digitSpan;
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeader(title: 'Resumen'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _StatCard(title: 'Máximo directo', value: '${s.maxForward}'),
                _StatCard(title: 'Máximo inverso', value: '${s.maxBackward}'),
                _StatCard(title: 'Ensayos', value: '${s.sessions.length}'),
              ],
            ),
            const SizedBox(height: 20),
            _SectionHeader(title: 'Progreso (máx. directo)'),
            const SizedBox(height: 10),
            SizedBox(
              height: 220,
              child: LineChart(LineChartData(
                gridData: FlGridData(show: true),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (x, meta) => Text(
                          s.sessions[x.toInt()].label,
                          style: const TextStyle(fontSize: 10)),
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, reservedSize: 30),
                  ),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    dotData: FlDotData(show: true),
                    spots: [
                      for (var i = 0; i < s.sessions.length; i++)
                        FlSpot(
                            i.toDouble(), s.sessions[i].maxForward.toDouble()),
                    ],
                  ),
                ],
              )),
            ),
          ],
        ),
      );
    });
  }
}

/// ---------------- TRAIL MAKING ----------------

class _TrailMakingTab extends StatelessWidget {
  const _TrailMakingTab({required this.controller});
  final StatsController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final t = controller.trail;
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeader(title: 'Resumen'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _StatCard(title: 'Mejor tiempo (A)', value: '${t.bestA}s'),
                _StatCard(title: 'Mejor tiempo (B)', value: '${t.bestB}s'),
                _StatCard(title: 'Ensayos', value: '${t.sessions.length}'),
              ],
            ),
            const SizedBox(height: 20),
            _SectionHeader(title: 'Tiempos recientes (s)'),
            const SizedBox(height: 10),
            SizedBox(
              height: 220,
              child: BarChart(BarChartData(
                gridData: FlGridData(show: true),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (x, meta) => Text(
                          t.sessions[x.toInt()].label,
                          style: const TextStyle(fontSize: 10)),
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: true, reservedSize: 32),
                  ),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                barGroups: [
                  for (var i = 0; i < t.sessions.length; i++)
                    BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(toY: t.sessions[i].seconds.toDouble()),
                      ],
                    ),
                ],
              )),
            ),
          ],
        ),
      );
    });
  }
}

/// ---------------- IPAQ ----------------

class _IpaqTab extends StatelessWidget {
  const _IpaqTab({required this.controller});
  final StatsController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final i = controller.ipaq;
      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionHeader(title: 'Último resultado'),
          const SizedBox(height: 8),
          _StatCard(title: 'Categoría', value: i.lastCategory),
          _StatCard(title: 'MET-min/semana', value: '${i.lastMetMinutes}'),
          const SizedBox(height: 20),
          _SectionHeader(title: 'Historial (categoría)'),
          const SizedBox(height: 8),
          for (final s in i.sessions)
            ListTile(
              title: Text(s.label),
              trailing: Text(s.category),
            ),
        ],
      );
    });
  }
}

/// ---------------- UI bits ----------------

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(title,
        style:
            theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700));
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 170,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withOpacity(.2)),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.bodySmall),
          const SizedBox(height: 6),
          Text(value,
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

/// ---------------- Controller + mock models ----------------

class StatsController extends GetxController {
  final digitSpan = DigitSpanStats.mock().obs;
  final trail = TrailStats.mock().obs;
  final ipaq = IpaqStats.mock().obs;

  Future<void> refreshData() async {
    // TODO: replace with your persistence (Firestore/local DB).
    await Future.delayed(const Duration(milliseconds: 400));
    digitSpan.update((d) => d?.randomize());
    trail.update((t) => t?.randomize());
    ipaq.update((i) => i?.randomize());
  }
}

class DigitSpanStats {
  DigitSpanStats({required this.sessions});
  final List<DigitSpanSession> sessions;

  int get maxForward =>
      sessions.map((e) => e.maxForward).fold(0, (a, b) => a > b ? a : b);
  int get maxBackward =>
      sessions.map((e) => e.maxBackward).fold(0, (a, b) => a > b ? a : b);

  factory DigitSpanStats.mock() => DigitSpanStats(
          sessions: List.generate(6, (i) {
        return DigitSpanSession(
            label: 'S${i + 1}', maxForward: 5 + i, maxBackward: 4 + (i ~/ 2));
      }));

  void randomize() {
    for (final s in sessions) {
      s.maxForward =
          (s.maxForward + ([-1, 0, 1]..shuffle()).first).clamp(3, 12);
      s.maxBackward =
          (s.maxBackward + ([-1, 0, 1]..shuffle()).first).clamp(2, 10);
    }
  }
}

class DigitSpanSession {
  DigitSpanSession(
      {required this.label,
      required this.maxForward,
      required this.maxBackward});
  final String label;
  int maxForward;
  int maxBackward;
}

class TrailStats {
  TrailStats({required this.sessions});
  final List<TrailSession> sessions;

  int get bestA => sessions.isEmpty
      ? 0
      : sessions.map((e) => e.seconds).reduce((a, b) => a < b ? a : b);
  int get bestB => (bestA * 11 ~/ 10); // placeholder relation

  factory TrailStats.mock() => TrailStats(
        sessions: List.generate(
            6, (i) => TrailSession(label: 'S${i + 1}', seconds: 75 - i * 5)),
      );

  void randomize() {
    for (final s in sessions) {
      s.seconds = (s.seconds + ([-5, 0, 5]..shuffle()).first).clamp(40, 120);
    }
  }
}

class TrailSession {
  TrailSession({required this.label, required this.seconds});
  final String label;
  int seconds;
}

class IpaqStats {
  IpaqStats({required this.sessions});
  final List<IpaqSession> sessions;

  String get lastCategory => sessions.isEmpty ? '-' : sessions.last.category;
  int get lastMetMinutes => sessions.isEmpty ? 0 : sessions.last.metMinutes;

  factory IpaqStats.mock() => IpaqStats(
        sessions: [
          IpaqSession(label: 'S1', category: 'Baja', metMinutes: 480),
          IpaqSession(label: 'S2', category: 'Moderada', metMinutes: 1100),
          IpaqSession(label: 'S3', category: 'Alta', metMinutes: 2300),
        ],
      );

  void randomize() {
    const cats = ['Baja', 'Moderada', 'Alta'];
    sessions.add(IpaqSession(
      label: 'S${sessions.length + 1}',
      category: cats[(sessions.length) % 3],
      metMinutes: 400 + sessions.length * 150,
    ));
  }
}

class IpaqSession {
  IpaqSession(
      {required this.label, required this.category, required this.metMinutes});
  final String label;
  final String category;
  final int metMinutes;
}
