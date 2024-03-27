import 'package:flutter/material.dart';
import 'package:google_map_01/pages/map_page.dart';
import 'package:google_map_01/providers/location_provider.dart';
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
        ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Google Map 01',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.deepPurple),
          home: const MapViewPage(),
        );
      },
    );
  }
}
