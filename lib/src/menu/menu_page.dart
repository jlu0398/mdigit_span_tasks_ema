import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:mdigits/src/ipaq/view/ipaq_page.dart';
import 'package:mdigits/src/task_list/view/task_list_page.dart';
import 'package:mdigits/src/cognition/trail_making_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tablero',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 600;
            final crossAxisCount = isWide ? 3 : 2;
            final childAspectRatio = isWide ? 0.95 : 0.85;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                children: [
                  const Text(
                    '¿A dónde quieres ir?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: childAspectRatio,
                      children: const [
                        _MenuCard(
                          title: 'Digit Span',
                          subtitle: 'Prueba de memoria',
                          iconName: Mdi.numeric,
                          color: Colors.indigoAccent,
                          destination: _Destination.tasklist,
                        ),
                        _MenuCard(
                          title: 'Trail Making',
                          subtitle: 'Prueba cognitiva',
                          iconName: Mdi.map_marker_path,
                          color: Colors.orange,
                          destination: _Destination.trailmaking,
                        ),
                        _MenuCard(
                          title: 'IPAQ',
                          subtitle: 'Actividad Física',
                          iconName: Mdi.run,
                          color: Colors.green,
                          destination: _Destination.ipaq,
                        ),
                        _MenuCard(
                          title: 'Stats',
                          subtitle: 'Ver estadísticas',
                          iconName: Mdi.chart_line,
                          color: Colors.teal,
                          destination: _Destination.stats,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Selecciona una opción para continuar',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color:
                          theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

enum _Destination { ipaq, tasklist, stats, trailmaking }

class _MenuCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconName;
  final Color color;
  final _Destination destination;

  const _MenuCard({
    required this.title,
    required this.subtitle,
    required this.iconName,
    required this.color,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () async {
        switch (destination) {
          case _Destination.ipaq:
            await Get.to(() => IPAQPage());
            break;
          case _Destination.tasklist:
            await Get.to(() => const TaskListPage());
            break;
          case _Destination.stats:
            Get.snackbar('Stats', 'Aquí irán las estadísticas',
                snackPosition: SnackPosition.BOTTOM);
            break;
          case _Destination.trailmaking:
            await Get.to(() => const TrailMakingPage());
            break;
        }
      },
      child: Ink(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.25), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          // tighter padding to avoid overflow on smaller phones
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(color: color.withOpacity(0.35), width: 2),
                ),
                child: Center(
                  child: Iconify(
                    iconName,
                    size: 40,
                    color: color,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Flexible(
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
