import 'package:flutter/material.dart';
import 'package:flutter_google_sheet_test/di/provider_setup.dart';
import 'package:flutter_google_sheet_test/presentation/home/components/overlay/buy_overlay_widget.dart';
import 'package:flutter_google_sheet_test/presentation/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: getProviders(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Sheet Api Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Stack(
        children: const [
          HomeScreen(),
          BuyOverlayWidget(),
        ],
      ),
    );
  }
}
