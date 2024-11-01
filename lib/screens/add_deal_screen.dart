import 'dart:io';

import 'package:budget_map/providers/committee_provider.dart';
import 'package:budget_map/screens/photo_view_screen.dart';
import 'package:budget_map/widgets/save_delete_builder.dart';
import 'package:budget_map/widgets/text_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/budget.dart';
import '../models/committee.dart';
import '../widgets/appbar.dart';

class AddCommitteeScreen extends StatefulWidget {
  const AddCommitteeScreen({super.key, this.committee});

  final Committee? committee;

  @override
  State<AddCommitteeScreen> createState() => _AddCommitteeScreenState();
}

class _AddCommitteeScreenState extends State<AddCommitteeScreen> {
  Budget? selectedBudget;
  File? selectedImage;

  // Company? selectedSupplier;
  // List<OrderedProduct> mainProducts = [];
  // List<OrderedProduct> sideProducts = [];
  DateTime selectedDate = DateTime.now();
  TextEditingController exchangeRate = TextEditingController();
  TextEditingController number = TextEditingController();

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
    Provider.of<CommitteeProvider>(context, listen: false).getBudgets();
    if (widget.committee != null) {
      number.text = widget.committee!.number.toString();
      selectedDate = widget.committee!.date;
      selectedBudget = widget.committee!.budget;
      exchangeRate.text = widget.committee!.exchangeRateUSD.toString();
    }
  }

  // Todo: Fix dropdown bug
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: buildAppBar(
                context: context,
                title: widget.committee == null ? 'أضافة لجنة' : 'تعديل لجنة'),
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: Consumer<CommitteeProvider>(builder:
                (BuildContext context, CommitteeProvider value, Widget? child) {
              if (checkReady(value)) {
                // selectedSupplier = value.suppliers[0];
                if (widget.committee == null) {
                  selectedBudget = value.budgets[0];
                } else {
                  selectedBudget = widget.committee?.budget;
                }
                return SingleChildScrollView(
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                            width: MediaQuery.sizeOf(context).width - 40.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("رقم اللجنة",
                                    style: primaryStyle(context)),
                                const SizedBox(
                                  height: 2,
                                ),
                                buildTextField(
                                    context: context,
                                    controller: number,
                                    hint: "رقم اللجنة",
                                    numeric: true),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text("اختر الموازنة",
                                    style: primaryStyle(context)),
                                const SizedBox(
                                  height: 15,
                                ),
                                StatefulBuilder(
                                  builder: (BuildContext context,
                                      void Function(void Function())
                                      setStateOfWidget) {
                                    return DropdownButtonFormField<Budget>(
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        filled: true,
                                        fillColor: Theme.of(context)
                                            .colorScheme
                                            .surfaceContainerHigh,
                                      ),
                                      dropdownColor: Theme.of(context)
                                          .colorScheme
                                          .surfaceContainerHigh,
                                      isExpanded: true,
                                      value: selectedBudget,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer),
                                      onChanged: (Budget? selection) {
                                        // This is called when the user selects an item.
                                        setStateOfWidget(() {
                                          selectedBudget = selection;
                                        });
                                      },
                                      items: value.budgets
                                          .map<DropdownMenuItem<Budget>>(
                                              (Budget budget) {
                                            return DropdownMenuItem<Budget>(
                                              value: budget,
                                              child: Text(budget.name),
                                            );
                                          }).toList(),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                // Text("Select Supplier",
                                //     style: primaryStyle(context)),
                                // StatefulBuilder(builder: (BuildContext context,
                                //     void Function(void Function())
                                //         setStateOfWidget) {
                                //   return DropdownButton<Company>(
                                //     isExpanded: true,
                                //     value: selectedSupplier,
                                //     icon: Icon(Icons.arrow_downward,
                                //         color:
                                //             Theme.of(context).colorScheme.primary),
                                //     elevation: 16,
                                //     style: TextStyle(
                                //         color: Theme.of(context)
                                //             .colorScheme
                                //             .onPrimaryContainer),
                                //     underline: Container(
                                //       height: 2,
                                //       color: Theme.of(context)
                                //           .colorScheme
                                //           .primaryContainer,
                                //     ),
                                //     onChanged: (Company? selection) {
                                //       // This is called when the user selects an item.
                                //       setStateOfWidget(() {
                                //         selectedSupplier = selection;
                                //       });
                                //     },
                                //     items: value.suppliers
                                //         .map<DropdownMenuItem<Company>>(
                                //             (Company supplier) {
                                //       return DropdownMenuItem<Company>(
                                //         value: supplier,
                                //         child: Text(supplier.name),
                                //       );
                                //     }).toList(),
                                //   );
                                // }),

                                Text("سعر الدولار",
                                    style: primaryStyle(context)),
                                const SizedBox(
                                  height: 2,
                                ),
                                buildTextField(
                                    context: context,
                                    controller: exchangeRate,
                                    hint: "سعر الدولار",
                                    numeric: true),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text("اختر التاريخ",
                                    style: primaryStyle(context)),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("${selectedDate.toLocal()}"
                                        .split(' ')[0]),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    ElevatedButton(
                                      onPressed: () => _selectDate(context),
                                      child: const Text('اختر التاريخ'),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                // Text("Main Products", style: primaryStyle(context)),
                                // DynamicProductsList(list: mainProducts),
                                // const SizedBox(
                                //   height: 15,
                                // ),
                                // Text("Side Products", style: primaryStyle(context)),
                                // DynamicProductsList(list: sideProducts),
                                // const SizedBox(
                                //   height: 15,
                                // ),
                                Text("اختر صورة", style: primaryStyle(context)),
                                StatefulBuilder(builder: (BuildContext context,
                                    void Function(void Function())
                                    internalSetState) {
                                  return Center(
                                      child: Column(children: [
                                        selectedImage != null
                                            ? Image.file(
                                            fit: BoxFit.contain, selectedImage!)
                                            : widget.committee?.imageURL != null
                                            ? GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PhotoViewScreen(
                                                          imageUrl: widget
                                                              .committee!
                                                              .imageURL!),
                                                ),
                                              );
                                            },
                                            child: CachedNetworkImage(
                                                width:
                                                MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                    100,
                                                imageUrl: widget
                                                    .committee!.imageURL!,
                                                placeholder: (context,
                                                    url) =>
                                                const CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) {
                                                  if (kDebugMode) {
                                                    print(error);
                                                  }
                                                  return const Icon(
                                                      Icons.error);
                                                },
                                                httpHeaders: Supabase
                                                    .instance
                                                    .client
                                                    .auth
                                                    .headers))
                                            : const Text('لم يتم اختيار صورة'),
                                        ElevatedButton(
                                            onPressed: () async {
                                              final pickedFile = await ImagePicker()
                                                  .pickImage(
                                                  source: ImageSource.gallery);
                                              if (pickedFile != null) {
                                                internalSetState(() {
                                                  selectedImage =
                                                      File(pickedFile.path);
                                                });
                                              }
                                            },
                                            child: const Icon(Icons.add)),
                                      ]));
                                }),
                                const SizedBox(
                                  height: 15,
                                ),
                                buildSaveDeleteButtons(
                                    data: null,
                                    saveFunction: () {
                                      Committee newCommittee = Committee(
                                          budgetID: selectedBudget!.id!,
                                          date: selectedDate,
                                          exchangeRateUSD:
                                          double.parse(exchangeRate.text),
                                          number: int.parse(number.text));
                                      Provider.of<CommitteeProvider>(context,
                                          listen: false)
                                          .addCommittee(
                                          newCommittee, selectedImage);
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
            })));
  }

  bool checkReady(CommitteeProvider value) {
    return !value.addDone &&
        !value.addLoading &&
        !value.getBudgetsLoading &&
        value.getBudgetsDone;
  }
}
