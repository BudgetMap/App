import 'package:budget_map/screens/budgets_screen.dart';
import 'package:budget_map/screens/companies_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/appbar.dart';
import '../widgets/outlined_button.dart';
import 'committees_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Map<String, Widget> options = {
    'الموازنات': const BudgetsScreen(),
    'الشركات': const CompaniesScreen(),
    'اللجان': const CommitteesScreen(),
    // 'Images': const ImagesScreen()
  };

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: buildAppBar(context: context, title: 'القائمة الرئيسية'),
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: Center(
                child: SizedBox(
                    width: MediaQuery.sizeOf(context).width - 40.0,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        String selection = options.keys.elementAt(index);
                        return buildOutlinedButton(
                            context: context,
                            text: selection,
                            onPress: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => options[selection]!));
                            });
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          height: 5.0,
                          color: Theme.of(context).colorScheme.surface,
                        );
                      },
                    )))));
  }
}
