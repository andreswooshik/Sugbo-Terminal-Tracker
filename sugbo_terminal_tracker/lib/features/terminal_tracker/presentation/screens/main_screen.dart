import 'package:flutter/material.dart';
import 'package:sugbo_terminal_tracker/features/routes/screens/routes_screen.dart';
import 'package:sugbo_terminal_tracker/features/terminals/screens/terminals_screen.dart';
import 'package:sugbo_terminal_tracker/features/schedule/screens/schedule_screen.dart';
import 'package:sugbo_terminal_tracker/features/savings/screens/savings_screen.dart';
import 'home_screen.dart';
import '../widgets/custom_bottom_nav.dart';
import '../../../../core/theme/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(showBottomNav: false),
    const RoutesScreen(),
    const TerminalsScreen(),
    const ScheduleScreen(),
    const SavingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
