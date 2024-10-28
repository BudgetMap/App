import 'package:budget_map/providers/suppliers_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/supplier.dart';
import 'menu_screen.dart';

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
              return Center(
                  child: SizedBox(
                      width: MediaQuery.sizeOf(context).width - 20.0,
                      child: ListView.separated(
                          padding: const EdgeInsets.only(top: 10),
                          itemCount: value.data.length,
                          itemBuilder: (context, i) {
                            return buildSupplierCard(context, value, i);
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

  GestureDetector buildSupplierCard(
      BuildContext context, SuppliersProvider value, int i) {
    return GestureDetector(
        onLongPress: () =>
            addSupplierScreen(context: context, supplier: value.data[i]),
        child: Card(
          margin: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Theme.of(context).colorScheme.surfaceContainer,
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        value.data[i].name,
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.fontFamily,
                            fontSize: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.fontSize),
                      )
                    ],
                  ),
                  Text(
                    value.data[i].info,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontFamily:
                            Theme.of(context).textTheme.bodySmall?.fontFamily,
                        fontSize:
                            Theme.of(context).textTheme.bodySmall?.fontSize),
                  ),
                ],
              )),
        ));
  }

  void addSupplierScreen(
      {required BuildContext context, required Supplier? supplier}) {
    // Provider.of<SuppliersProvider>(context, listen: false).addDone = false;
    // Provider.of<SuppliersProvider>(context, listen: false).addLoading = false;
    // Navigator.of(context)
    //     .push(MaterialPageRoute(
    //         builder: (context) => SuppliersAddScreen(supplier: supplier)))
    //     .then((result) {
    //   if (context.mounted) {
    //     Provider.of<SuppliersProvider>(context, listen: false).getSuppliers();
    //   }
    // });
  }
}
