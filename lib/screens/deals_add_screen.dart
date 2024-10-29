import 'package:budget_map/models/ordered_product.dart';
import 'package:budget_map/models/supplier.dart';
import 'package:budget_map/providers/deals_provider.dart';
import 'package:budget_map/widgets/save_delete_builder.dart';
import 'package:budget_map/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/asset.dart';
import '../models/deal.dart';
import '../widgets/appbar.dart';
import '../widgets/dynamic_products_list.dart';

class DealsAddScreen extends StatefulWidget {
  const DealsAddScreen({super.key, this.deal});

  final Deal? deal;

  @override
  State<DealsAddScreen> createState() => _DealsAddScreenState();
}

class _DealsAddScreenState extends State<DealsAddScreen> {
  Asset? selectedAsset;
  Supplier? selectedSupplier;
  List<OrderedProduct> mainProducts = [];
  List<OrderedProduct> sideProducts = [];
  DateTime selectedDate = DateTime.now();
  TextEditingController exchangeRate = TextEditingController();

  TextStyle primaryStyle(BuildContext context) => TextStyle(
      color: Theme.of(context).colorScheme.onSurface,
      fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
      fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<DealsProvider>(context, listen: false).getAssetsAndSuppliers();
    if (widget.deal != null) {
      // Todo
    }
  }


  // Todo: Fix dropdown bug

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context: context, title: 'Deal'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Consumer<DealsProvider>(builder:
            (BuildContext context, DealsProvider value, Widget? child) {
          if (checkReady(value)) {
            selectedSupplier = value.suppliers[0];
            selectedAsset = value.assets[0];
            return SingleChildScrollView(
                child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                        width: MediaQuery.sizeOf(context).width - 40.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Select Asset", style: primaryStyle(context)),
                            StatefulBuilder(
                              builder: (BuildContext context,
                                  void Function(void Function())
                                      setStateOfWidget) {
                                return DropdownButton<Asset>(
                                  isExpanded: true,
                                  value: selectedAsset,
                                  icon: Icon(Icons.arrow_downward,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
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
                                    setStateOfWidget(() {
                                      selectedAsset = selection;
                                    });
                                  },
                                  items: value.assets
                                      .map<DropdownMenuItem<Asset>>(
                                          (Asset asset) {
                                    return DropdownMenuItem<Asset>(
                                      value: asset,
                                      child: Text(asset.name),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text("Select Supplier",
                                style: primaryStyle(context)),
                            StatefulBuilder(builder: (BuildContext context,
                                void Function(void Function())
                                    setStateOfWidget) {
                              return DropdownButton<Supplier>(
                                isExpanded: true,
                                value: selectedSupplier,
                                icon: Icon(Icons.arrow_downward,
                                    color:
                                        Theme.of(context).colorScheme.primary),
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
                                onChanged: (Supplier? selection) {
                                  // This is called when the user selects an item.
                                  setStateOfWidget(() {
                                    selectedSupplier = selection;
                                  });
                                },
                                items: value.suppliers
                                    .map<DropdownMenuItem<Supplier>>(
                                        (Supplier supplier) {
                                  return DropdownMenuItem<Supplier>(
                                    value: supplier,
                                    child: Text(supplier.name),
                                  );
                                }).toList(),
                              );
                            }),
                            const SizedBox(
                              height: 15,
                            ),
                            Text("Select Date", style: primaryStyle(context)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("${selectedDate.toLocal()}".split(' ')[0]),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                ElevatedButton(
                                  onPressed: () => _selectDate(context),
                                  child: const Text('Select date'),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text("USD Exchange Rate",
                                style: primaryStyle(context)),
                            const SizedBox(
                              height: 2,
                            ),
                            buildTextField(
                                controller: exchangeRate,
                                hint: "USD EXchange Rate",
                                numeric: true),
                            const SizedBox(
                              height: 15,
                            ),
                            Text("Main Products", style: primaryStyle(context)),
                            DynamicProductsList(list: mainProducts),
                            const SizedBox(
                              height: 15,
                            ),
                            Text("Side Products", style: primaryStyle(context)),
                            DynamicProductsList(list: sideProducts),
                            const SizedBox(
                              height: 15,
                            ),
                            buildSaveDeleteButtons(
                                data: null,
                                saveFunction: () {
                                  Deal newDeal = Deal(
                                      supplierID: selectedSupplier!.id!,
                                      assetID: selectedAsset!.id!,
                                      date: selectedDate,
                                      conversionValueUSD:
                                          double.parse(exchangeRate.text),
                                      mainProducts: mainProducts,
                                      sideProducts: sideProducts);
                                  Provider.of<DealsProvider>(context,
                                          listen: false)
                                      .addDeal(newDeal);
                                },
                                deleteFunction: () {})
                          ],
                        ))));
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

  bool checkReady(DealsProvider value) {
    return !value.addDone &&
        !value.addLoading &&
        !value.getAssetsAndSuppliersLoading &&
        value.getAssetsAndSuppliersDone;
  }
}
