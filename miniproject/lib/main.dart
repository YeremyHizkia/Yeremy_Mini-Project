import 'package:flutter/material.dart';
import 'package:miniproject/Screen/Login/signup.dart';
import 'package:miniproject/Screen/Search/view_model/search_provider.dart';
import 'package:miniproject/Screen/Search/search_page.dart';
import 'package:miniproject/Screen/Component/bottomnav.dart';
import 'package:miniproject/Screen/Component/onboarding_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NewsViewModel>(
          create: (_) => NewsViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const OnboardingScreen(),
          '/home': (context) => const BottomnavPage(),
          '/search': (context) => const SearchScreen(),
          '/daftar': (context) => SignUpScreen(),
        },
      ),
    );
  }
}
