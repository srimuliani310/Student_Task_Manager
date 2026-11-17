import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:student_task_manager/screens/jadwal.dart';
// import 'package:student_task_manager/screens/onboarding_screen.dart';

// Pastikan 'nama_project_anda' sesuai dengan bagian 'name:' di pubspec.yaml
import 'screens/onboarding_screen.dart';
// import 'screens/jadwal.dart';

// import 'screens/jadwal.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const StudentTaskManagerApp());
}

class StudentTaskManagerApp extends StatelessWidget {
  const StudentTaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Task Manager',
      theme: ThemeData(useMaterial3: true, fontFamily: 'Roboto'),
      // Mengarahkan tampilan pertama ke file onboarding_screen.dart
      home: const OnboardingScreen(),
    );
  }
}
