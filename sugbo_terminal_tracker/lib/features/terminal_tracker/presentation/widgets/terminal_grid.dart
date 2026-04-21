import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/terminal_model.dart';
import 'terminal_card.dart';

class TerminalGrid extends StatelessWidget {
  final List<TerminalUiModel> terminals;

  const TerminalGrid({super.key, required this.terminals});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Quick terminals',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${terminals.length} hubs',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Grid of Terminals
        GridView.builder(
          padding: EdgeInsets.zero,
          // ShrinkWrap needed since inside a column/scroll view
          shrinkWrap: true,
          // Disable grid scroll to let the parent screen scroll instead
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio:
                1.8, // Adjusts height of the card relative to width
          ),
          itemCount: terminals.length,
          itemBuilder: (context, index) {
            return TerminalCard(terminal: terminals[index]);
          },
        ),
      ],
    );
  }
}
