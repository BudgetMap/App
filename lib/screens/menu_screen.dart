import 'package:budget_map/screens/assets_screen.dart';
import 'package:budget_map/screens/suppliers_screen.dart';
import 'package:flutter/material.dart';

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
    'Deals':const DealsScreen()
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
                      height: 10.0,
                      color: Theme.of(context).colorScheme.surface,
                    );
                  },
                ))));
  }
}

OutlinedButton buildOutlinedButton(
    {required BuildContext context,
    required String text,
    required void Function()? onPress}) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.only(top: 10),
        side: BorderSide(
            width: 1.0, color: Theme.of(context).colorScheme.outlineVariant)),
    onPressed: onPress,
    child: Align(
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontFamily:
                  Theme.of(context).textTheme.headlineMedium?.fontFamily,
              fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize),
        )),
  );
}

AppBar buildAppBar({required BuildContext context, required String title}) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.surface,
    title: Text(
      title,
      style: TextStyle(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          fontFamily: Theme.of(context).textTheme.displaySmall?.fontFamily,
          fontSize: Theme.of(context).textTheme.displaySmall?.fontSize),
    ),
    toolbarHeight: 80,
  );
}
