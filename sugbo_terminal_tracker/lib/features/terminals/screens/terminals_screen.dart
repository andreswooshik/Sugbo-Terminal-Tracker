import 'package:flutter/material.dart';
import '../models/terminal_wait_model.dart';
import '../widgets/wait_board_card.dart';
import 'terminal_detail_screen.dart';

class TerminalsScreen extends StatelessWidget {
  const TerminalsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<TerminalWaitModel> mockTerminals = [
      TerminalWaitModel(
        name: 'IT Park',
        description: 'BRT anchor',
        waitTime: '~3 min',
        routeCount: '3 routes',
        updatedTime: '2 min ago',
        isFree: true,
        accentColor: Colors.blue,
      ),
      TerminalWaitModel(
        name: 'SM Seaside',
        description: 'BRT + MyBus',
        waitTime: '~7 min',
        routeCount: '4 routes',
        updatedTime: '2 min ago',
        isFree: true,
        accentColor: Colors.greenAccent,
      ),
      TerminalWaitModel(
        name: 'SM City',
        description: 'MyBus main hub',
        waitTime: '~5 min',
        routeCount: '5 routes',
        updatedTime: '2 min ago',
        isFree: false,
        accentColor: Colors.greenAccent,
      ),
      TerminalWaitModel(
        name: 'Il Corso',
        description: 'BRT terminus',
        waitTime: '~12 min',
        routeCount: '1 route',
        updatedTime: '2 min ago',
        isFree: true,
        accentColor: Colors.blue,
      ),
      TerminalWaitModel(
        name: 'SM JMall',
        description: 'Mandaue - MyBus',
        waitTime: '~8 min',
        routeCount: '2 routes',
        updatedTime: '2 min ago',
        isFree: false,
        accentColor: Colors.greenAccent,
      ),
      TerminalWaitModel(
        name: 'Anjo World',
        description: 'Love Bus + MyBus',
        waitTime: '~15 min',
        routeCount: '3 routes',
        updatedTime: '2 min ago',
        isFree: true,
        accentColor: Colors.pinkAccent,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(
        0xFF6B7B9E,
      ), // The light blueish background matches the image
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Terminals',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text(
              'Live queue · tap to report your wait',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: [
            // The green notification banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(
                  0xFF566583,
                ), // Slightly darker blue/grey blending into BG
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Icon(
                      Icons.circle,
                      color: Colors.greenAccent,
                      size: 8,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 12,
                          height: 1.4,
                        ),
                        children: [
                          TextSpan(
                            text:
                                'Love Bus FREE now on BRT · IT Park ↔ Il Corso ',
                          ),
                          TextSpan(
                            text: ' (until 9:00 AM)',
                            style: TextStyle(color: Color(0xFF8DE8B2)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // The list of terminals WaitBoard
            ...mockTerminals
                .map(
                  (terminal) => WaitBoardCard(
                    terminal: terminal,
                    onTap: () {
                      // Pass terminal details directly to the detail screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TerminalDetailScreen(terminal: terminal),
                        ),
                      );
                    },
                  ),
                )
                .toList(),

            const SizedBox(height: 24), // Padding at bottom
          ],
        ),
      ),
    );
  }
}
