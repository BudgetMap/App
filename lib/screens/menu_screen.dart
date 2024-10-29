import 'package:budget_map/screens/assets_screen.dart';
import 'package:budget_map/screens/suppliers_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/appbar.dart';
import '../widgets/outlined_button.dart';
import 'deals_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Map<String, Widget> options = {
    'Assets': const AssetsScreen(),
    'Suppliers': const SuppliersScreen(),
    'Deals': const DealsScreen()
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context: context, title: 'Menu'),
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
                ))));
  }
}
