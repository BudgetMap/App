import 'package:budget_map/models/ordered_product.dart';
import 'package:budget_map/providers/deals_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/asset.dart';
import '../models/deal.dart';
import '../widgets/appbar.dart';

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
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .surface,
        body: Consumer<DealsProvider>(builder:
            (BuildContext context, DealsProvider value, Widget? child) {
          if (!value.addDone &&
              !value.addLoading &&
              !value.getAssetsAndSuppliersLoading &&
              value.getAssetsAndSuppliersDone) {
            print(value.assets.toString());
            return Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                    width: MediaQuery
                        .sizeOf(context)
                        .width - 40.0,
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
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .primary),
                              elevation: 16,
                              style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .onPrimaryContainer),
                              underline: Container(
                                height: 2,
                                color: Theme
                                    .of(context)
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
                                      color: Theme
                                          .of(context)
                                          .colorScheme
                                          .error,
                                      onColor:
                                      Theme
                                          .of(context)
                                          .colorScheme
                                          .onError,
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

OutlinedButton buildSmallOutlinedButton({required BuildContext context,
  required String text,
  required void Function()? onPress,
  Color? color,
  Color? onColor}) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
        backgroundColor: onColor ?? Theme
            .of(context)
            .colorScheme
            .surface,
        side: BorderSide(
            width: 1.0, color: Theme
            .of(context)
            .colorScheme
            .outlineVariant)),
    onPressed: onPress,
    child: Align(
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              color: color ?? Theme
                  .of(context)
                  .colorScheme
                  .primary,
              fontFamily: Theme
                  .of(context)
                  .textTheme
                  .bodyLarge
                  ?.fontFamily,
              fontSize: Theme
                  .of(context)
                  .textTheme
                  .bodyLarge
                  ?.fontSize),
        )),
  );
}

class DynamicProductsList extends StatefulWidget {
  final List<OrderedProduct> list;

  const DynamicProductsList({super.key, required this.list});

  @override
  State<StatefulWidget> createState() => _DynamicProductsList();
}

class _DynamicProductsList extends State<DynamicProductsList> {
  TextEditingController name = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController priceInUSD = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Theme
                    .of(context)
                    .colorScheme
                    .surfaceContainer,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Text(
                        widget.list[index].name,
                        style: TextStyle(
                            color:
                            Theme
                                .of(context)
                                .colorScheme
                                .onSurfaceVariant,
                            fontFamily: Theme
                                .of(context)
                                .textTheme
                                .headlineSmall
                                ?.fontFamily,
                            fontSize: Theme
                                .of(context)
                                .textTheme
                                .headlineSmall
                                ?.fontSize),
                      ),
                      Text(
                        widget.list[index].amount.toString(),
                        style: TextStyle(
                            color:
                            Theme
                                .of(context)
                                .colorScheme
                                .onSurfaceVariant,
                            fontFamily: Theme
                                .of(context)
                                .textTheme
                                .headlineSmall
                                ?.fontFamily,
                            fontSize: Theme
                                .of(context)
                                .textTheme
                                .headlineSmall
                                ?.fontSize),
                      ),
                      Text(
                        widget.list[index].priceInUSD.toString(),
                        style: TextStyle(
                            color:
                            Theme
                                .of(context)
                                .colorScheme
                                .onSurfaceVariant,
                            fontFamily: Theme
                                .of(context)
                                .textTheme
                                .headlineSmall
                                ?.fontFamily,
                            fontSize: Theme
                                .of(context)
                                .textTheme
                                .headlineSmall
                                ?.fontSize),
                      )
                    ],
                  ),
                ));
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              height: 10.0,
              color: Theme
                  .of(context)
                  .colorScheme
                  .surface,
            );
          },
          itemCount: widget.list.length,
        ),
        Card(
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Theme
                .of(context)
                .colorScheme
                .surfaceContainer,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  TextField(
                    controller: name,
                    decoration: const InputDecoration(
                        filled: true, hintText: "Original Amount"),
                  ),
                  TextField(
                    controller: amount,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                        filled: true, hintText: "Original Amount"),
                  ),
                  TextField(
                    controller: priceInUSD,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                        filled: true, hintText: "Original Amount"),
                  ),
                  buildSmallOutlinedButton(
                    context: context,
                    text: 'Save',
                    onPress: () {
                      OrderedProduct newOrderedProduct = OrderedProduct(
                          name: name.text,
                          amount: int.parse(amount.text),
                          priceInUSD: int.parse(priceInUSD.text));
                      setState(() {
                        widget.list.add(newOrderedProduct);
                      });
                    },
                  )
                ],
              ),
            ))
      ],
    );
  }
}
