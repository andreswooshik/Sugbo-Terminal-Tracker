import 'package:flutter/material.dart';
import '../models/schedule_model.dart';

class TimetableScreen extends StatelessWidget {
  final ScheduleModel schedule;

  const TimetableScreen({Key? key, required this.schedule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF6B7B9E), // Same as Schedule Tab
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            schedule.providerBadge,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'WEEKDAYS'),
              Tab(text: 'WEEKENDS'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTimetableList(isWeekday: true),
            _buildTimetableList(isWeekday: false),
          ],
        ),
      ),
    );
  }

  Widget _buildTimetableList({required bool isWeekday}) {
    // Data extracted from your images
    final List<String> timesToSeaside = isWeekday
        ? [
            '7:40 AM',
            '8:00 AM',
            '8:30 AM',
            '9:00 AM',
            '9:30 AM',
            '10:00 AM',
            '11:00 AM',
            '12:00 PM',
            '1:30 PM',
            '3:00 PM',
            '5:00 PM',
            '7:00 PM',
            '9:00 PM',
          ]
        : [
            '7:40 AM',
            '8:00 AM',
            '8:20 AM',
            '8:40 AM',
            '9:00 AM',
            '10:00 AM',
            '12:00 PM',
            '2:00 PM',
            '4:00 PM',
            '6:00 PM',
            '8:00 PM',
            '9:20 PM',
          ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionHeader('J Mall → SM City → SM Seaside'),
        const SizedBox(height: 10),
        _buildTimeGrid(timesToSeaside),
        const SizedBox(height: 24),
        _buildSectionHeader('SM Seaside → Parkmall → J Mall'),
        const SizedBox(height: 10),
        _buildTimeGrid([
          '8:40 AM',
          '9:40 AM',
          '10:40 AM',
          '12:00 PM',
          '1:40 PM',
          '3:00 PM',
          '4:40 PM',
          '6:00 PM',
          '8:00 PM',
          '10:00 PM',
        ]),
        const SizedBox(height: 30),
        const Center(
          child: Text(
            "Every 20-30 mins depending on traffic",
            style: TextStyle(
              color: Colors.white60,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildTimeGrid(List<String> times) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: times.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 2.5,
      ),
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFF1E222D),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            times[index],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
    );
  }
}
