import 'package:budget_map/providers/committee_provider.dart';
import 'package:budget_map/widgets/save_delete_builder.dart';
import 'package:budget_map/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  // Company? selectedSupplier;
  // List<OrderedProduct> mainProducts = [];
  // List<OrderedProduct> sideProducts = [];
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
    Provider.of<CommitteeProvider>(context, listen: false).getBudgets();
    if (widget.committee != null) {
      // Todo
    }
  }

  // Todo: Fix dropdown bug

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context: context, title: 'Committee'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Consumer<CommitteeProvider>(builder:
            (BuildContext context, CommitteeProvider value, Widget? child) {
          if (checkReady(value)) {
            // selectedSupplier = value.suppliers[0];
            selectedBudget = value.budgets[0];
            return SingleChildScrollView(
                child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                        width: MediaQuery.sizeOf(context).width - 40.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Select Budget", style: primaryStyle(context)),
                            StatefulBuilder(
                              builder: (BuildContext context,
                                  void Function(void Function())
                                      setStateOfWidget) {
                                return DropdownButton<Budget>(
                                  isExpanded: true,
                                  value: selectedBudget,
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
                                hint: "USD Exchange Rate",
                                numeric: true),
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
                            buildSaveDeleteButtons(
                                data: null,
                                saveFunction: () {
                                  Committee newCommittee = Committee(
                                      budgetID: selectedBudget!.id!,
                                      date: selectedDate,
                                      exchangeRateUSD:
                                          double.parse(exchangeRate.text),
                                      number: 0);
                                  Provider.of<CommitteeProvider>(context,
                                          listen: false)
                                      .addCommittee(newCommittee);
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

  bool checkReady(CommitteeProvider value) {
    return !value.addDone &&
        !value.addLoading &&
        !value.getBudgetsLoading &&
        value.getBudgetsDone;
  }
}