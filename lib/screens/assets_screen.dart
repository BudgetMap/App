import 'package:budget_map/providers/assets_provider.dart';
import 'package:budget_map/screens/assets_add_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/asset.dart';
import '../widgets/appbar.dart';
import '../widgets/asset_card.dart';

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
              return Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                      width: MediaQuery.sizeOf(context).width - 20.0,
                      child: ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 10),
                          itemCount: value.data.length,
                          itemBuilder: (context, i) {
                            return buildAssetCard(
                                context: context,
                                value: value,
                                i: i,
                                onLongPressFunction: () {
                                  addAssetScreen(
                                      context: context, asset: value.data[i]);
                                });
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
