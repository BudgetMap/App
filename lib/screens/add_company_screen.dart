import 'package:budget_map/providers/company_provider.dart';
import 'package:budget_map/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/company.dart';
import '../widgets/appbar.dart';
import '../widgets/save_delete_builder.dart';

class AddCompanyScreen extends StatefulWidget {
  const AddCompanyScreen({super.key, this.company});

  final Company? company;

  @override
  State<AddCompanyScreen> createState() => _AddCompanyScreenState();
}

class _AddCompanyScreenState extends State<AddCompanyScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController info = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.company != null) {
      // name.text = widget.asset!.name;
      // originalAmount.text = widget.asset!.originalAmount.toString();
    }
  }

  void savecompany({
    required TextEditingController name,
    required TextEditingController info,
  }) {
    Provider.of<CompanyProvider>(context, listen: false)
        .addCompany(Company(name: name.text, info: info.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context: context, title: 'company'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Consumer<CompanyProvider>(builder:
            (BuildContext context, CompanyProvider value, Widget? child) {
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
                            data: widget.company,
                            saveFunction: () =>
                                savecompany(name: name, info: info),
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
