import 'package:flutter/material.dart';
import 'package:sugbo_terminal_tracker/features/routes/screens/routes_screen.dart';
import 'package:sugbo_terminal_tracker/features/terminal_tracker/presentation/screens/home_screen.dart';
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
    // Placeholder screens for the rest of the tabs
    const Center(
      child: Text(
        'Terminals Placeholder',
        style: TextStyle(color: Colors.white),
      ),
    ),
    const Center(
      child: Text(
        'Schedule Placeholder',
        style: TextStyle(color: Colors.white),
      ),
    ),
    const Center(
      child: Text('Savings Placeholder', style: TextStyle(color: Colors.white)),
    ),
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
