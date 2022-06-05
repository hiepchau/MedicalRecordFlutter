import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicalrecordapp/screens/blood_donation_screen.dart';
import 'package:medicalrecordapp/screens/check_record_screen.dart';
import 'package:medicalrecordapp/screens/doctor_dashboard_screen.dart';
import 'package:medicalrecordapp/screens/health_record_screen.dart';
import 'package:medicalrecordapp/screens/medical_history_screen.dart';
import 'package:medicalrecordapp/screens/qr_code_scanner_screen.dart';
import 'package:medicalrecordapp/screens/record_verification_screen.dart';
import 'package:medicalrecordapp/screens/terms_and_conditions_screen.dart';
import 'package:medicalrecordapp/screens/user_login_screen.dart';
import 'package:medicalrecordapp/screens/user_profile_screen.dart';
import 'package:medicalrecordapp/screens/user_registration_screen.dart';
import 'package:medicalrecordapp/screens/user_dashboard_screen.dart';
import 'package:medicalrecordapp/screens/user_search_screen.dart';
import 'package:medicalrecordapp/screens/doctor_mode_screen.dart';
import 'package:medicalrecordapp/screens/welcome_screen.dart';
import 'package:medicalrecordapp/services/authenticate.dart';

Future<void> main() async {
  // Initalize widgets and firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Transparent notification bar
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  // Run the app
  runApp(const MedicalRecord());
}

class MedicalRecord extends StatelessWidget {
  const MedicalRecord({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        appBarTheme: AppBarTheme(
          elevation: 5.0,
          color: Colors.green[500],
        ), colorScheme: const ColorScheme.light(
          primary: Colors.green,
        ).copyWith(secondary: Colors.green),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: (Auth().getUser() == null)
          ? WelcomeScreen.id
          : UserDashboardScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        UserLoginScreen.id: (context) => UserLoginScreen(),
        UserRegistrationScreen.id: (context) => UserRegistrationScreen(),
        UserDashboardScreen.id: (context) => UserDashboardScreen(),
        UserProfileScreen.id: (context) => UserProfileScreen(),
        BloodDonationScreen.id: (context) => BloodDonationScreen(),
        DoctorModeScreen.id: (context) => DoctorModeScreen(),
        UserSearchScreen.id: (context) => UserSearchScreen(),
        HealthRecordScreen.id: (context) => HealthRecordScreen(),
        MedicalHistoryScreen.id: (context) => MedicalHistoryScreen(),
        TermsAndConditionsScreen.id: (context) => TermsAndConditionsScreen(),
        DoctorDashboardScreen.id: (context) => DoctorDashboardScreen(),
        RecordVerificationScreen.id: (context) => RecordVerificationScreen(),
        QrCodeScannerScreen.id: (context) => QrCodeScannerScreen(),
        CheckRecordScreen.id: (context) => CheckRecordScreen(),
      },
    );
  }
}
