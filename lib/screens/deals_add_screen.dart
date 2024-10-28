import 'package:budget_map/models/ordered_product.dart';
import 'package:budget_map/providers/deals_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/asset.dart';
import '../models/deal.dart';
import '../widgets/appbar.dart';
import '../widgets/dynamic_products_list.dart';
import '../widgets/small_outlined_button.dart';

class DealsAddScreen extends StatefulWidget {
  const DealsAddScreen({super.key, this.deal});

  final Deal? deal;

  @override
  State<DealsAddScreen> createState() => _DealsAddScreenState();
}

class _DealsAddScreenState extends State<DealsAddScreen> {
  // TextEditingController name = TextEditingController();
  // TextEditingController originalAmount = TextEditingController();
  // TextEditingController consumedAmount = TextEditingController();
  Asset? selectedAsset;
  List<OrderedProduct> list = [];

  @override
  void initState() {
    super.initState();
    Provider.of<DealsProvider>(context, listen: false).getAssetsAndSuppliers();
    if (widget.deal != null) {
      // name.text = widget.asset!.name;
      // originalAmount.text = widget.asset!.originalAmount.toString();
      // consumedAmount.text = widget.asset!.consumedAmount.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context: context, title: 'Deal'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Consumer<DealsProvider>(builder:
            (BuildContext context, DealsProvider value, Widget? child) {
          if (!value.addDone &&
              !value.addLoading &&
              !value.getAssetsAndSuppliersLoading &&
              value.getAssetsAndSuppliersDone) {
            return Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                    width: MediaQuery.sizeOf(context).width - 40.0,
                    child: Wrap(
                      spacing: 20,
                      // to apply margin in the main axis of the wrap
                      runSpacing: 20,
                      children: [
                        SizedBox(
                            width: double.infinity,
                            child: DropdownButton<Asset>(
                              isExpanded: true,
                              value: value.assets[0],
                              icon: Icon(Icons.arrow_downward,
                                  color: Theme.of(context).colorScheme.primary),
                              elevation: 16,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer),
                              underline: Container(
                                height: 2,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              onChanged: (Asset? selection) {
                                // This is called when the user selects an item.
                                selectedAsset = selection;
                              },
                              items: value.assets
                                  .map<DropdownMenuItem<Asset>>((Asset asset) {
                                return DropdownMenuItem<Asset>(
                                  value: asset,
                                  child: Text(asset.name),
                                );
                              }).toList(),
                            )),
                        DynamicProductsList(list: list),
                        // TextField(
                        //   controller: name,
                        //   decoration: const InputDecoration(
                        //     filled: true,
                        //     hintText: "Name",
                        //   ),
                        // ),
                        // TextField(
                        //   controller: originalAmount,
                        //   keyboardType: TextInputType.number,
                        //   inputFormatters: <TextInputFormatter>[
                        //     FilteringTextInputFormatter.digitsOnly
                        //   ],
                        //   decoration: const InputDecoration(
                        //       filled: true, hintText: "Original Amount"),
                        // ),
                        // TextField(
                        //   controller: consumedAmount,
                        //   keyboardType: TextInputType.number,
                        //   inputFormatters: <TextInputFormatter>[
                        //     FilteringTextInputFormatter.digitsOnly
                        //   ],
                        //   decoration: const InputDecoration(
                        //       filled: true, hintText: "Consumed Amount"),
                        // ),
                        Builder(builder: (BuildContext context) {
                          if (widget.deal == null) {
                            return buildSmallOutlinedButton(
                              context: context,
                              text: 'Save',
                              onPress: () {
                                // Provider.of<DealsProvider>(context,
                                //         listen: false)
                                //     .addDeal(Deal(
                                //         name: name.text,
                                //         originalAmount:
                                //             int.parse(originalAmount.text),
                                //         consumedAmount:
                                //             int.parse(consumedAmount.text)));
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


