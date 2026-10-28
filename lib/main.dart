import 'package:flutter/material.dart';
import 'screens/a_list_screen.dart';

const karrotOrange = Color(0xFFFF6F0F);
void main() => runApp(const KarrotV2App());
class KarrotV2App extends StatelessWidget {
  const KarrotV2App({super.key});
  @override Widget build(BuildContext context) => MaterialApp(
    title: 'Karrot-v2', debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3:true, colorScheme: ColorScheme.fromSeed(seedColor:karrotOrange), scaffoldBackgroundColor: const Color(0xFFF8F8F8), appBarTheme: const AppBarTheme(backgroundColor:Color(0xFFF8F8F8), foregroundColor:Color(0xFF222222), elevation:0)),
    home: const ListScreen(),
  );
}
