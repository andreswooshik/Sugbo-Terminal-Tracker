import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/theme/app_colors.dart';
import 'features/terminal_tracker/presentation/screens/home_screen.dart';

Future<void> main() async {
  // Ensure Flutter is ready.
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(
    // Add ProviderScope for Riverpod state management with a state logger
    const ProviderScope(observers: [StateLogger()], child: MyApp()),
  );
}

/// A Riverpod observer that logs state changes.
class StateLogger extends ProviderObserver {
  const StateLogger();

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    debugPrint('''
[Provider Update] ${provider.name ?? provider.runtimeType}
  ├─ Old Value: $previousValue
  └─ New Value: $newValue
''');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sugbo Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.dark(
          primary: AppColors.accentGreen,
          surface: AppColors.background,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
