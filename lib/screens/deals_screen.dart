import 'package:budget_map/providers/deals_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/deal.dart';
import '../widgets/appbar.dart';
import '../widgets/deal_card.dart';
import 'deals_add_screen.dart';

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
                            return buildDealCard(
                                context: context,
                                value: value,
                                i: i,
                                onLongPressFunction: () {
                                  //Todo
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
