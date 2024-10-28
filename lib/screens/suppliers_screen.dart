import 'package:budget_map/providers/suppliers_provider.dart';
import 'package:budget_map/screens/suppliers_add_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/supplier.dart';
import '../widgets/appbar.dart';
import '../widgets/supplier_card.dart';

class SuppliersScreen extends StatefulWidget {
  const SuppliersScreen({super.key});

  @override
  State<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<SuppliersProvider>(context, listen: false).getSuppliers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.surfaceBright,
            onPressed: () =>
                {addSupplierScreen(context: context, supplier: null)},
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onSurface,
            )),
        appBar: buildAppBar(context: context, title: 'Suppliers'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Consumer<SuppliersProvider>(
          builder:
              (BuildContext context, SuppliersProvider value, Widget? child) {
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
                            return buildSupplierCard(
                                context: context,
                                value: value,
                                i: i,
                                onLongPressFunction: () {
                                  addSupplierScreen(
                                      context: context,
                                      supplier: value.data[i]);
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

  void addSupplierScreen(
      {required BuildContext context, required Supplier? supplier}) {
    Provider.of<SuppliersProvider>(context, listen: false).addDone = false;
    Provider.of<SuppliersProvider>(context, listen: false).addLoading = false;
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => SuppliersAddScreen(supplier: supplier)))
        .then((result) {
      if (context.mounted) {
        Provider.of<SuppliersProvider>(context, listen: false).getSuppliers();
      }
    });
  }
}
