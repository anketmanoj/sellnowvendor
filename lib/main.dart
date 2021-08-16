import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sell_now_vendor/providers/auth_provider.dart';
import 'package:sell_now_vendor/screens/homeScreen.dart';
import 'package:sell_now_vendor/screens/loginScreen.dart';
import 'package:sell_now_vendor/screens/registerScreen.dart';
import 'package:sell_now_vendor/screens/splashScreen.dart';
import 'package:sell_now_vendor/widgets/reset_password.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
        primaryColor: Colors.purple[900],
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        LogoinScreen.id: (context) => LogoinScreen(),
        ResetPassword.id: (context) => ResetPassword(),
      },
    );
  }
}
