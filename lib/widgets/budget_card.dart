import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/budget_provider.dart';

NumberFormat numFormatter = NumberFormat.decimalPatternDigits(
  locale: 'ar_eg',
  decimalDigits: 0,
);

GestureDetector buildBudgetCard(
    {required BuildContext context,
    required BudgetProvider value,
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
                Row(
                  children: [
                    Text(
                      "رقم البند: ${numFormatter.format(value.data[i].number)}",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontFamily: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.fontFamily,
                          fontSize:
                              Theme.of(context).textTheme.bodyMedium?.fontSize),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ج: ${numFormatter.format(value.data[i].originalAmount)}",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontFamily:
                              Theme.of(context).textTheme.bodySmall?.fontFamily,
                          fontSize:
                              Theme.of(context).textTheme.bodySmall?.fontSize),
                    ),
                    Text(
                      "م: ${numFormatter.format(value.data[i].consumedAmount)}",
                      style: TextStyle(
                          color: Colors.red,
                          fontFamily:
                              Theme.of(context).textTheme.bodySmall?.fontFamily,
                          fontSize:
                              Theme.of(context).textTheme.bodySmall?.fontSize),
                    ),
                    Text(
                      "ب: ${numFormatter.format(value.data[i].originalAmount - value.data[i].consumedAmount)}",
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
