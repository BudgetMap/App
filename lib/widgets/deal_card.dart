import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/deals_provider.dart';

const String dateFormat = "yyyy-MM-dd";

TextStyle standardTextStyle(context) => TextStyle(
    overflow: TextOverflow.ellipsis,
    color: Theme.of(context).colorScheme.onSurfaceVariant,
    fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
    fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize);

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${value.data[i].supplier?.name} ${value.data[i].asset?.name} ${value.data[i].id.toString()}",
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
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
                      "Date: ${DateFormat(dateFormat).format(value.data[i].date)}",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontFamily: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.fontFamily,
                          fontSize:
                              Theme.of(context).textTheme.bodyMedium?.fontSize),
                    ),
                    Text(
                      "USD Exchange rate: ${value.data[i].conversionValueUSD.toString()}",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontFamily: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.fontFamily,
                          fontSize:
                              Theme.of(context).textTheme.bodyMedium?.fontSize),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Text(
                  "Main Products",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontFamily:
                          Theme.of(context).textTheme.bodyMedium?.fontFamily,
                      fontSize:
                          Theme.of(context).textTheme.bodyMedium?.fontSize),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      value.data[i].mainProducts[index].name,
                                      style: standardTextStyle(context),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Row(children: [
                                      const Text(
                                        "\u0024",
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      Text(
                                        value.data[i].mainProducts[index].amount
                                            .toString(),
                                        style: standardTextStyle(context),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        "x",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Text(
                                        value.data[i].mainProducts[index]
                                            .priceInUSD
                                            .toString(),
                                        style: standardTextStyle(context),
                                      )
                                    ]))
                              ],
                            )),
                      );
                    },
                    itemCount: value.data[i].mainProducts.length),
                Text(
                  "Side Products",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontFamily:
                          Theme.of(context).textTheme.bodyMedium?.fontFamily,
                      fontSize:
                          Theme.of(context).textTheme.bodyMedium?.fontSize),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      value.data[i].sideProducts[index].name,
                                      style: standardTextStyle(context),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Row(children: [
                                      const Text(
                                        "\u0024",
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      Text(
                                        value.data[i].sideProducts[index].amount
                                            .toString(),
                                        style: standardTextStyle(context),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        "x",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Text(
                                        value.data[i].sideProducts[index]
                                            .priceInUSD
                                            .toString(),
                                        style: standardTextStyle(context),
                                      )
                                    ]))
                              ],
                            )),
                      );
                    },
                    itemCount: value.data[i].sideProducts.length),
              ],
            ),
          )));
}
