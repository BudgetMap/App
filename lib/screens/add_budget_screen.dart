import 'package:budget_map/providers/budget_provider.dart';
import 'package:budget_map/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/budget.dart';
import '../widgets/appbar.dart';
import '../widgets/save_delete_builder.dart';

class AddBudgetScreen extends StatefulWidget {
  const AddBudgetScreen({super.key, this.budget});

  final Budget? budget;

  @override
  State<AddBudgetScreen> createState() => _AddBudgetScreenState();
}

class _AddBudgetScreenState extends State<AddBudgetScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController originalAmount = TextEditingController();
  TextEditingController consumedAmount = TextEditingController();
  TextEditingController number = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.budget != null) {
      name.text = widget.budget!.name;
      originalAmount.text = widget.budget!.originalAmount.toString();
      consumedAmount.text = widget.budget!.consumedAmount.toString();
      number.text = widget.budget!.consumedAmount.toString();
    }
  }

  void savebudget({
    required TextEditingController name,
    required TextEditingController originalAmount,
    required TextEditingController consumedAmount,
    required TextEditingController number,
  }) {
    Provider.of<BudgetProvider>(context, listen: false).addBudget(Budget(
        name: name.text,
        originalAmount: int.parse(originalAmount.text),
        consumedAmount: int.parse(consumedAmount.text),
        number: int.parse(number.text)));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: buildAppBar(
                context: context,
                title: widget.budget == null ? 'أضافة موازنة' : 'تعديل موازنة'),
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: Consumer<BudgetProvider>(builder:
                (BuildContext context, BudgetProvider value, Widget? child) {
              if (!value.addDone && !value.addLoading) {
                return Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                        width: MediaQuery.sizeOf(context).width - 40.0,
                        child: Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          children: [
                            buildTextField(
                                context: context,
                                controller: name,
                                hint: "اسم موازنة"),
                            buildTextField(
                                context: context,
                                controller: number,
                                hint: "رقم البند",
                                numeric: true),
                            buildTextField(
                                context: context,
                                controller: originalAmount,
                                hint: "القيمة الأصلية",
                                numeric: true),
                            buildTextField(
                                context: context,
                                controller: consumedAmount,
                                hint: "القيمة المستهلكة",
                                numeric: true),
                            buildSaveDeleteButtons(
                                data: widget.budget,
                                saveFunction: () => savebudget(
                                    name: name,
                                    originalAmount: originalAmount,
                                    consumedAmount: consumedAmount,
                                    number: number),
                                deleteFunction: () {})
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
            })));
  }
}
