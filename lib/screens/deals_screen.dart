import 'package:budget_map/providers/committee_provider.dart';
import 'package:budget_map/providers/deal_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/committee.dart';
import '../widgets/appbar.dart';
import '../widgets/committee_card.dart';
import 'add_committee_screen.dart';
import 'dart:ui' as ui;

class DealsScreen extends StatefulWidget {
  const DealsScreen({super.key,required this.committee});

  final Committee? committee;

  @override
  State<DealsScreen> createState() => _DealsScreenState();
}

class _DealsScreenState extends State<DealsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CommitteeProvider>(context, listen: false).getCommittees();
  }

  NumberFormat numFormatter = NumberFormat.decimalPatternDigits(
    locale: 'en_us',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: ui.TextDirection.rtl,
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.surfaceBright,
                onPressed: () =>
                    addCommitteeScreen(context: context, committee: null),
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.onSurface,
                )),
            appBar: buildAppBar(context: context, title: 'اللجان'),
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: Consumer<CommitteeProvider>(
              builder: (BuildContext context, CommitteeProvider value,
                  Widget? child) {
                if (value.getDone) {
                  return Center(
                      child: SizedBox(
                          width: MediaQuery.sizeOf(context).width - 20.0,
                          child: ListView.separated(
                              padding: const EdgeInsets.only(top: 10),
                              itemCount: value.data.length,
                              itemBuilder: (context, i) {
                                return buildCommitteeCard(
                                    context: context,
                                    value: value,
                                    i: i,
                                    onLongPressFunction: () {
                                      addCommitteeScreen(context: context, committee: value.data[i]);
                                    },
                                    onTapFunction: () {


                                    });
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(height: 3);
                              })));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )));
  }

  void addCommitteeScreen(
      {required BuildContext context, required Committee? committee}) {
    Provider.of<CommitteeProvider>(context, listen: false).addDone = false;
    Provider.of<CommitteeProvider>(context, listen: false).addLoading = false;
    Provider.of<CommitteeProvider>(context, listen: false).getBudgetsDone =
    false;
    Provider.of<CommitteeProvider>(context, listen: false).getBudgetsLoading =
    false;
    Navigator.of(context)
        .push(MaterialPageRoute(
        builder: (context) => AddCommitteeScreen(committee: committee)))
        .then((result) {
      if (context.mounted) {
        Provider.of<CommitteeProvider>(context, listen: false).getCommittees();
      }
    });
  }
}