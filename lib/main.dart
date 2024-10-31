import 'package:budget_map/providers/Images_provider.dart';
import 'package:budget_map/providers/budget_provider.dart';
import 'package:budget_map/providers/committee_provider.dart';
import 'package:budget_map/providers/company_provider.dart';
import 'package:budget_map/screens/menu_screen.dart';
import 'package:budget_map/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // flutter build apk --release  --dart-define=SUPABASE_URL="..."
  // --dart-define=SUPABASE_ANNON_KEY="..."
  // await Supabase.initialize(
  //   url: const String.fromEnvironment("SUPABASE_URL"),
  //   anonKey: const String.fromEnvironment("SUPABASE_ANNON_KEY"),
  // );
  await dotenv.load(fileName: "assets/.env");
  await Supabase.initialize(
    url: dotenv.env['URL']!,
    anonKey: dotenv.env['ANON_KEY']!,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // String titleFontFamily = 'IBM Plex Sans Arabic';
    // String bodyFontFamily = "Lateef";
    String titleFontFamily = 'Roboto';
    String bodyFontFamily = "Open Sans";
    TextTheme textTheme =
        createTextTheme(context, bodyFontFamily, titleFontFamily);
    MaterialTheme theme = MaterialTheme(textTheme);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BudgetProvider()),
        ChangeNotifierProvider(create: (context) => CompanyProvider()),
        ChangeNotifierProvider(create: (context) => CommitteeProvider()),
        ChangeNotifierProvider(create: (context) => ImagesProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme.light(),
          darkTheme: theme.dark(),
          themeMode: ThemeMode.system,
          title: 'Budget Map',
          home: const MenuScreen(),
          ),
    );
  }
}
