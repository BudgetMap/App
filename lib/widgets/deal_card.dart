import 'package:flutter/material.dart';

import '../providers/deals_provider.dart';

GestureDetector buildDealCard(
    {required BuildContext context,
    required DealsProvider value,
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
              children: [
                Row(
                  children: [
                    Text(
                      value.data[i].id.toString(),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "T:",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontFamily:
                              Theme.of(context).textTheme.bodySmall?.fontFamily,
                          fontSize:
                              Theme.of(context).textTheme.bodySmall?.fontSize),
                    ),
                    Text(
                      "C:",
                      style: TextStyle(
                          color: Colors.red,
                          fontFamily:
                              Theme.of(context).textTheme.bodySmall?.fontFamily,
                          fontSize:
                              Theme.of(context).textTheme.bodySmall?.fontSize),
                    ),
                    Text(
                      "R:",
                      style: TextStyle(
                          color: Colors.green,
                          fontFamily:
                              Theme.of(context).textTheme.bodySmall?.fontFamily,
                          fontSize:
                              Theme.of(context).textTheme.bodySmall?.fontSize),
                    ),
                  ],
                )
              ],
            ),
          )));
}
