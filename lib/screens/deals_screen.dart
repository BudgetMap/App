import 'package:budget_map/providers/deals_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/deal.dart';
import 'deals_add_screen.dart';
import 'menu_screen.dart';

class DealsScreen extends StatefulWidget {
  const DealsScreen({super.key});

  @override
  State<DealsScreen> createState() => _DealsScreenState();
}

class _DealsScreenState extends State<DealsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<DealsProvider>(context, listen: false).getDeals();
  }

  NumberFormat numFormatter = NumberFormat.decimalPatternDigits(
    locale: 'en_us',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.surfaceBright,
            onPressed: () => addDealScreen(context: context, deal: null),
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onSurface,
            )),
        appBar: buildAppBar(context: context, title: 'Deals'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Consumer<DealsProvider>(
          builder: (BuildContext context, DealsProvider value, Widget? child) {
            if (value.getDone) {
              return Center(
                  child: SizedBox(
                      width: MediaQuery.sizeOf(context).width - 20.0,
                      child: ListView.separated(
                          padding: const EdgeInsets.only(top: 10),
                          itemCount: value.data.length,
                          itemBuilder: (context, i) {
                            return buildCard(context, value, i);
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

  GestureDetector buildCard(BuildContext context, DealsProvider value, int i) {
    return GestureDetector(
        onLongPress: () => addDealScreen(context: context, deal: value.data[i]),
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
                        value.data[i].id.toString(),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "T:",
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.fontFamily,
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.fontSize),
                      ),
                      Text(
                        "C:",
                        style: TextStyle(
                            color: Colors.red,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.fontFamily,
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.fontSize),
                      ),
                      Text(
                        "R:",
                        style: TextStyle(
                            color: Colors.green,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.fontFamily,
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.fontSize),
                      ),
                    ],
                  )
                ],
              ),
            )));
  }

  void addDealScreen({required BuildContext context, required Deal? deal}) {
    Provider.of<DealsProvider>(context, listen: false).addDone = false;
    Provider.of<DealsProvider>(context, listen: false).addLoading = false;
    Provider.of<DealsProvider>(context, listen: false)
        .getAssetsAndSuppliersDone = false;
    Provider.of<DealsProvider>(context, listen: false)
        .getAssetsAndSuppliersLoading = false;
    Navigator.of(context)
        .push(
            MaterialPageRoute(builder: (context) => DealsAddScreen(deal: deal)))
        .then((result) {
      if (context.mounted) {
        Provider.of<DealsProvider>(context, listen: false).getDeals();
      }
    });
  }
}
