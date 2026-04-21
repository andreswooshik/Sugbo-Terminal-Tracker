import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_colors.dart';
import 'features/terminal_tracker/presentation/screens/main_screen.dart';

Future<void> main() async {
  // Ensure Flutter is ready.
  WidgetsFlutterBinding.ensureInitialized();

  // Setup error boundaries
  FlutterError.onError = (FlutterErrorDetails details) {
    // Log the error nicely or send to Crashlytics
    if (kDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production, send to tracking service quietly
      // e.g., Crashlytics.instance.recordFlutterFatalError(details);
    }
  };

  runApp(
    // Add ProviderScope for Riverpod state management, logging only in debug mode
    ProviderScope(
      observers: kDebugMode ? const [StateLogger()] : const [],
      child: const MyApp(),
    ),
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
  +- Old Value: $previousValue
  +- New Value: $newValue
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
      builder: (context, child) {
        // Global Error Widget builder for build phase errors
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'An unexpected error occurred.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (kDebugMode)
                      Text(
                        errorDetails.exceptionAsString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                  ],
                ),
              ),
            ),
          );
        };
        return child ?? const SizedBox.shrink();
      },
      home: const MainScreen(),
    );
  }
}
