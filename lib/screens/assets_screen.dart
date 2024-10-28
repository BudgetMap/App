import 'package:budget_map/providers/assets_provider.dart';
import 'package:budget_map/screens/assets_add_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/asset.dart';
import 'menu_screen.dart';

class AssetsScreen extends StatefulWidget {
  const AssetsScreen({super.key});

  @override
  State<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends State<AssetsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AssetsProvider>(context, listen: false).getAssets();
  }

  NumberFormat numFormatter = NumberFormat.decimalPatternDigits(
    locale: 'en_us',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.surfaceBright,
            onPressed: () => addAssetScreen(context: context, asset: null),
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onSurface,
            )),
        appBar: buildAppBar(context: context, title: 'Assets'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Consumer<AssetsProvider>(
          builder: (BuildContext context, AssetsProvider value, Widget? child) {
            if (value.getDone) {
              return Center(
                  child: SizedBox(
                      width: MediaQuery.sizeOf(context).width - 20.0,
                      child: ListView.separated(
                          padding: const EdgeInsets.only(top: 10),
                          itemCount: value.data.length,
                          itemBuilder: (context, i) {
                            return buildCard(context, value, i);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 3);
                          })));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  GestureDetector buildCard(BuildContext context, AssetsProvider value, int i) {
    return GestureDetector(
        onLongPress: () =>
            addAssetScreen(context: context, asset: value.data[i]),
        child: Card(
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        value.data[i].name,
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.fontFamily,
                            fontSize: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.fontSize),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "T: ${numFormatter.format(value.data[i].originalAmount)}",
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.fontFamily,
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.fontSize),
                      ),
                      Text(
                        "C: ${numFormatter.format(value.data[i].consumedAmount)}",
                        style: TextStyle(
                            color: Colors.red,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.fontFamily,
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.fontSize),
                      ),
                      Text(
                        "R: ${numFormatter.format(value.data[i].originalAmount - value.data[i].consumedAmount)}",
                        style: TextStyle(
                            color: Colors.green,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.fontFamily,
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.fontSize),
                      ),
                    ],
                  )
                ],
              ),
            )));
  }

  void addAssetScreen({required BuildContext context, required Asset? asset}) {
    Provider.of<AssetsProvider>(context, listen: false).addDone = false;
    Provider.of<AssetsProvider>(context, listen: false).addLoading = false;
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => AssetsAddScreen(asset: asset)))
        .then((result) {
      if (context.mounted) {
        Provider.of<AssetsProvider>(context, listen: false).getAssets();
      }
    });
  }
}
