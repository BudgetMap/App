import 'package:budget_map/providers/budget_provider.dart';
import 'package:budget_map/screens/add_budget_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/budget.dart';
import '../widgets/appbar.dart';
import '../widgets/budget_card.dart';

class BudgetsScreen extends StatefulWidget {
  const BudgetsScreen({super.key});

  @override
  State<BudgetsScreen> createState() => _BudgetsScreenState();
}

class _BudgetsScreenState extends State<BudgetsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<BudgetProvider>(context, listen: false).getBudgets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.surfaceBright,
            onPressed: () => addBudgetScreen(context: context, budget: null),
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onSurface,
            )),
        appBar: buildAppBar(context: context, title: 'Budgets'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Consumer<BudgetProvider>(
          builder: (BuildContext context, BudgetProvider value, Widget? child) {
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
                            return buildBudgetCard(
                                context: context,
                                value: value,
                                i: i,
                                onLongPressFunction: () {
                                  addBudgetScreen(
                                      context: context, budget: value.data[i]);
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

  void addBudgetScreen({required BuildContext context, required Budget? budget}) {
    Provider.of<BudgetProvider>(context, listen: false).addDone = false;
    Provider.of<BudgetProvider>(context, listen: false).addLoading = false;
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => AddBudgetScreen(budget: budget)))
        .then((result) {
      if (context.mounted) {
        Provider.of<BudgetProvider>(context, listen: false).getBudgets();
      }
    });
  }
}
