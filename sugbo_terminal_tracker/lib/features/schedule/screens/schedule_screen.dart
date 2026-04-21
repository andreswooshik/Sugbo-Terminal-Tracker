import 'package:flutter/material.dart';
import '../models/schedule_model.dart';
import '../widgets/schedule_card.dart';
import '../widgets/filter_chip_widget.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  String selectedFilter = 'All';

  final List<String> filters = ['All', 'BRT', 'MyBus', 'Love Bus'];

  final List<ScheduleModel> allSchedules = [
    ScheduleModel(
      providerBadge: 'BRT',
      routeName: 'IT Park ↔ Il Corso',
      routeDetails: '9 stops · ~35 min',
      priceLabel: 'FREE - Peak only',
      frequencyLabel: 'Continuous',
      accentColor: Colors.blueAccent,
      isFree: true,
    ),
    ScheduleModel(
      providerBadge: 'MyBus R1',
      routeName: 'JMall ↔ SM City ↔ SM Seaside',
      routeDetails: '12 stops · ~45 min',
      priceLabel: '₱30',
      frequencyLabel: '30 min (wkday) · 20 min (w... ',
      accentColor: Colors.greenAccent,
      isFree: false,
    ),
    ScheduleModel(
      providerBadge: 'MyBus R2',
      routeName: 'Anjo World ↔ SM Seaside via SRP',
      routeDetails: '15 stops · ~40 min',
      priceLabel: '₱30',
      frequencyLabel: 'Every 20 min',
      accentColor: Colors.greenAccent,
      isFree: false,
    ),
    ScheduleModel(
      providerBadge: 'MyBus R3',
      routeName: 'Anjo World ↔ SM City / Parkmall',
      routeDetails: '20 stops · ~60 min',
      priceLabel: '₱50',
      frequencyLabel: 'Every 5-20 min',
      accentColor: Colors.greenAccent,
      isFree: false,
    ),
    ScheduleModel(
      providerBadge: 'MyBus R4',
      routeName: 'SM City ↔ Airport (MCIA)',
      routeDetails: '8 stops · ~35 min',
      priceLabel: '₱50',
      frequencyLabel: 'Every 30 min',
      accentColor: Colors.greenAccent,
      isFree: false,
    ),
    ScheduleModel(
      providerBadge: 'Love Bus',
      routeName: 'Anjo World / Talisay → Cebu SRP',
      routeDetails: 'SRP corridor',
      priceLabel: 'FREE - Peak only',
      frequencyLabel: '6-9 AM and 5-8 PM only',
      accentColor: Colors.pinkAccent,
      isFree: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredSchedules = selectedFilter == 'All'
        ? allSchedules
        : allSchedules
              .where((s) => s.providerBadge.contains(selectedFilter))
              .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF6B7B9E),
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
        child: Column(
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
        ),
      ),
    );
  }
}
