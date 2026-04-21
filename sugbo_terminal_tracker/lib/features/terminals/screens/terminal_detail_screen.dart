import 'package:flutter/material.dart';
import '../models/terminal_wait_model.dart';
import '../widgets/terminal_queue_card.dart';
import '../widgets/free_ride_banner.dart';
import '../widgets/departing_route_card.dart';
import '../widgets/next_departure_tile.dart';

class TerminalDetailScreen extends StatelessWidget {
  final TerminalWaitModel terminal;

  const TerminalDetailScreen({Key? key, required this.terminal})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6B7B9E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.lightBlueAccent),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              terminal.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              terminal.description,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              TerminalQueueCard(
                waitTime: terminal.waitTime,
                updatedStatus:
                    'Updated ${terminal.updatedTime} · 5 reports in last 10 min',
              ),
              const SizedBox(height: 16),

              if (terminal.isFree) const FreeRideBanner(),
              if (terminal.isFree) const SizedBox(height: 24),

              const Text(
                'Routes departing from IT Park',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 12),
              const DepartingRouteCard(
                route: 'IT Park → Il Corso',
                frequency: 'Continuous',
                provider: 'BRT',
                isFree: true,
                accentColor: Colors.blueAccent,
              ),
              const DepartingRouteCard(
                route: 'IT Park → SM Seaside',
                frequency: 'Continuous',
                provider: 'BRT',
                isFree: true,
                accentColor: Colors.blueAccent,
              ),
              const DepartingRouteCard(
                route: 'IT Park → Fuente Osmeña',
                frequency: 'Continuous',
                provider: 'BRT',
                isFree: true,
                accentColor: Colors.blueAccent,
              ),

              const SizedBox(height: 24),
              const Text(
                'Next departures',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 12),

              const NextDepartureTile(
                destination: 'Il Corso',
                provider: 'BRT',
                estimate: '~4 min',
                accentColor: Colors.blueAccent,
              ),
              const NextDepartureTile(
                destination: 'SM Seaside',
                provider: 'BRT',
                estimate: '~4 min',
                accentColor: Colors.blueAccent,
              ),
              const NextDepartureTile(
                destination: 'Fuente',
                provider: 'BRT',
                estimate: '~6 min',
                accentColor: Colors.blueAccent,
              ),
              const NextDepartureTile(
                destination: 'Il Corso',
                provider: 'BRT',
                estimate: '~9 min',
                accentColor: Colors.blueAccent,
              ),

              const SizedBox(height: 24),
              const Text(
                'Terminal info',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 12),
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E222D),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'Location: Cebu IT Park, Lahug - BRT dedicated station.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFF191D26), // Very dark bottom bar
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 140, // Specific width matching mockup
                height: 48,
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.lightBlueAccent,
                    size: 18,
                  ),
                  label: const Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent.withOpacity(0.15),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: BorderSide(
                        color: Colors.lightBlueAccent.withOpacity(0.3),
                      ),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
