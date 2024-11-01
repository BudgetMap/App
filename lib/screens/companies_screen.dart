import 'package:budget_map/providers/company_provider.dart';
import 'package:budget_map/screens/add_company_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/company.dart';
import '../widgets/appbar.dart';
import '../widgets/company_card.dart';

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({super.key});

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CompanyProvider>(context, listen: false).getCompanies();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,child:Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.surfaceBright,
            onPressed: () =>
                {addCompanyScreen(context: context, company: null)},
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onSurface,
            )),
        appBar: buildAppBar(context: context, title: 'الشركات'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Consumer<CompanyProvider>(
          builder:
              (BuildContext context, CompanyProvider value, Widget? child) {
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
                            return buildCompanyCard(
                                context: context,
                                value: value,
                                i: i,
                                onLongPressFunction: () {
                                  addCompanyScreen(
                                      context: context,
                                      company: value.data[i]);
                                });
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 3);
                          })));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        )));
  }

  void addCompanyScreen(
      {required BuildContext context, required Company? company}) {
    Provider.of<CompanyProvider>(context, listen: false).addDone = false;
    Provider.of<CompanyProvider>(context, listen: false).addLoading = false;
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => AddCompanyScreen(company: company)))
        .then((result) {
      if (context.mounted) {
        Provider.of<CompanyProvider>(context, listen: false).getCompanies();
      }
    });
  }
}
