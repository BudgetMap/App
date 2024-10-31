import 'package:flutter/material.dart';

import '../providers/company_provider.dart';

GestureDetector buildCompanyCard(
    {required BuildContext context,
    required CompanyProvider value,
    required int i,
    required void Function() onLongPressFunction}) {
  return GestureDetector(
      onLongPress: onLongPressFunction,
      child: Card(
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      value.data[i].name,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
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
