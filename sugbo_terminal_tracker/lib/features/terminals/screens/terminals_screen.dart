import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/providers/terminal_providers.dart';
import '../models/terminal_wait_model.dart';
import '../widgets/wait_board_card.dart';
import 'terminal_detail_screen.dart';

class TerminalsScreen extends ConsumerWidget {
  const TerminalsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the stream of terminals from SQLite
    final terminalsAsyncValue = ref.watch(terminalsStreamProvider);

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
        child: terminalsAsyncValue.when(
          data: (mockTerminals) {
            if (mockTerminals.isEmpty) {
              return const Center(
                child: Text(
                  'No terminals available.',
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }

            return ListView(
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
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
          error: (error, stack) => Center(
            child: Text(
              'Error loading terminals: $error',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
