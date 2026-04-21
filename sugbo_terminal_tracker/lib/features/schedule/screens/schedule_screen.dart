import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../models/schedule_model.dart';
import '../providers/schedule_providers.dart';
import '../widgets/schedule_card.dart';
import '../widgets/filter_chip_widget.dart';

class ScheduleScreen extends ConsumerStatefulWidget {
  const ScheduleScreen({super.key});

  @override
  ConsumerState<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen> {
  String selectedFilter = 'All';

  final List<String> filters = ['All', 'BRT', 'MyBus', 'Love Bus'];

  @override
  Widget build(BuildContext context) {
    final scheduleAsync = ref.watch(scheduleListProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Schedule',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text(
              'Tap any route to see full timetable',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: scheduleAsync.when(
          data: (allSchedules) {
            final filteredSchedules = selectedFilter == 'All'
                ? allSchedules
                : allSchedules
                    .where((s) => s.providerBadge.contains(selectedFilter))
                    .toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Filters
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: filters.map((filter) {
                      return FilterChipWidget(
                        label: filter,
                        isSelected: filter == selectedFilter,
                        onTap: () {
                          setState(() {
                            selectedFilter = filter;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),

                // List of schedules
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: filteredSchedules.length,
                    itemBuilder: (context, index) {
                      return ScheduleCard(schedule: filteredSchedules[index]);
                    },
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}
