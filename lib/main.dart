import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicalrecordapp/screens/blood_donation_screen.dart';
import 'package:medicalrecordapp/screens/Check/check_EHR_screen.dart';
import 'package:medicalrecordapp/screens/Check/check_record_screen.dart';
import 'package:medicalrecordapp/screens/Doctor/doctor_dashboard_screen.dart';
import 'package:medicalrecordapp/screens/health_record_screen.dart';
import 'package:medicalrecordapp/screens/medical_history_screen.dart';
import 'package:medicalrecordapp/screens/QrScreen/qr_code_scanner_screen.dart';
import 'package:medicalrecordapp/screens/record_verification_screen.dart';
import 'package:medicalrecordapp/screens/terms_and_conditions_screen.dart';
import 'package:medicalrecordapp/screens/Authen/user_login_screen.dart';
import 'package:medicalrecordapp/screens/Users/user_profile_screen.dart';
import 'package:medicalrecordapp/screens/Authen/user_registration_screen.dart';
import 'package:medicalrecordapp/screens/user_dashboard_screen.dart';
import 'package:medicalrecordapp/screens/Users/user_search_screen.dart';
import 'package:medicalrecordapp/screens/Doctor/doctor_mode_screen.dart';
import 'package:medicalrecordapp/screens/welcome/welcome_screen.dart';
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
        primaryColor: Colors.lightBlue[900],
        appBarTheme: AppBarTheme(
          elevation: 5.0,
          color: Colors.lightBlue[500],
        ),
        colorScheme: const ColorScheme.light(
          primary: Colors.lightBlue,
        ).copyWith(secondary: Colors.lightBlue),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: (Auth().getUser() == null)
          ? WelcomeScreen.id
          : UserDashboardScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        UserLoginScreen.id: (context) => const UserLoginScreen(),
        UserRegistrationScreen.id: (context) => const UserRegistrationScreen(),
        UserDashboardScreen.id: (context) => const UserDashboardScreen(),
        UserProfileScreen.id: (context) => const UserProfileScreen(),
        BloodDonationScreen.id: (context) => const BloodDonationScreen(),
        DoctorModeScreen.id: (context) => const DoctorModeScreen(),
        UserSearchScreen.id: (context) => const UserSearchScreen(),
        HealthRecordScreen.id: (context) => const HealthRecordScreen(),
        MedicalHistoryScreen.id: (context) => const MedicalHistoryScreen(),
        TermsAndConditionsScreen.id: (context) =>
            const TermsAndConditionsScreen(),
        DoctorDashboardScreen.id: (context) => const DoctorDashboardScreen(),
        RecordVerificationScreen.id: (context) =>
            const RecordVerificationScreen(),
        QrCodeScannerScreen.id: (context) => const QrCodeScannerScreen(),
        CheckRecordScreen.id: (context) => const CheckRecordScreen(),
        CheckEHRScreen.id: (context) => const CheckEHRScreen(),
      },
    );
  }
}
