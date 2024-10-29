import 'package:budget_map/providers/suppliers_provider.dart';
import 'package:budget_map/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/supplier.dart';
import '../widgets/appbar.dart';
import '../widgets/save_delete_builder.dart';

class SuppliersAddScreen extends StatefulWidget {
  const SuppliersAddScreen({super.key, this.supplier});

  final Supplier? supplier;

  @override
  State<SuppliersAddScreen> createState() => _SuppliersAddScreenState();
}

class _SuppliersAddScreenState extends State<SuppliersAddScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController info = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.supplier != null) {
      // name.text = widget.asset!.name;
      // originalAmount.text = widget.asset!.originalAmount.toString();
    }
  }

  void saveSupplier({
    required TextEditingController name,
    required TextEditingController info,
  }) {
    Provider.of<SuppliersProvider>(context, listen: false)
        .addSupplier(Supplier(name: name.text, info: info.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context: context, title: 'Supplier'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Consumer<SuppliersProvider>(builder:
            (BuildContext context, SuppliersProvider value, Widget? child) {
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
                        TextField(
                          minLines: 4,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: info,
                            decoration: const InputDecoration(
                              filled: true,
                              hintText: "info",
                            )),
                        buildSaveDeleteButtons(
                            data: widget.supplier,
                            saveFunction: () =>
                                saveSupplier(name: name, info: info),
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
        }));
  }
}
