import 'package:budget_map/providers/assets_provider.dart';
import 'package:budget_map/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/asset.dart';
import '../widgets/appbar.dart';
import '../widgets/small_outlined_button.dart';

class AssetsAddScreen extends StatefulWidget {
  const AssetsAddScreen({super.key, this.asset});

  final Asset? asset;

  @override
  State<AssetsAddScreen> createState() => _AssetsAddScreenState();
}

class _AssetsAddScreenState extends State<AssetsAddScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController originalAmount = TextEditingController();
  TextEditingController consumedAmount = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.asset != null) {
      name.text = widget.asset!.name;
      originalAmount.text = widget.asset!.originalAmount.toString();
      consumedAmount.text = widget.asset!.consumedAmount.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context: context, title: 'Asset'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Consumer<AssetsProvider>(builder:
            (BuildContext context, AssetsProvider value, Widget? child) {
          if (!value.addDone && !value.addLoading) {
            return Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                    width: MediaQuery.sizeOf(context).width - 40.0,
                    child: Wrap(
                      spacing: 20,
                      // to apply margin in the main axis of the wrap
                      runSpacing: 20,
                      children: [
                        buildTextField(controller: name, hint: "name"),
                        buildTextField(
                            controller: originalAmount,
                            hint: "Original Amount",
                            numeric: true),
                        buildTextField(
                            controller: consumedAmount,
                            hint: "Consumed Amount",
                            numeric: true),
                        Builder(builder: (BuildContext context) {
                          if (widget.asset == null) {
                            return buildSmallOutlinedButton(
                              context: context,
                              text: 'Save',
                              onPress: () {
                                Provider.of<AssetsProvider>(context,
                                        listen: false)
                                    .addAsset(Asset(
                                        name: name.text,
                                        originalAmount:
                                            int.parse(originalAmount.text),
                                        consumedAmount:
                                            int.parse(consumedAmount.text)));
                              },
                            );
                          } else {
                            return Row(
                              children: [
                                Expanded(
                                    child: buildSmallOutlinedButton(
                                  color: Theme.of(context).colorScheme.error,
                                  onColor:
                                      Theme.of(context).colorScheme.onError,
                                  context: context,
                                  text: 'Delete',
                                  onPress: () {
                                    // Todo
                                  },
                                )),
                                const SizedBox(width: 10),
                                Expanded(
                                    child: buildSmallOutlinedButton(
                                  context: context,
                                  text: 'Save',
                                  onPress: () {
                                    // Todo
                                  },
                                ))
                              ],
                            );
                            // }
                          }
                        })
                      ],
                    )));
          } else if (value.addDone) {
            value.addDone = false;
            Future.microtask(() {
              if (context.mounted) {
                Navigator.pop(context);
              }
            });
          }
          return const Center(child: CircularProgressIndicator());
        }));
  }
}