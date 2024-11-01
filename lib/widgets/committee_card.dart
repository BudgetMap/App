import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../providers/committee_provider.dart';
import '../screens/photo_view_screen.dart';

const String dateFormat = "yyyy-MM-dd";

TextStyle standardTextStyle(context) => TextStyle(
    overflow: TextOverflow.ellipsis,
    color: Theme.of(context).colorScheme.onSurfaceVariant,
    fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
    fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize);

GestureDetector buildCommitteeCard(
    {required BuildContext context,
    required CommitteeProvider value,
    required int i,
    required void Function() onLongPressFunction,
    required void Function() onTapFunction}) {
  return GestureDetector(
      onLongPress: onLongPressFunction,
      onTap: onTapFunction,
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
                      "رقم اللجنة: ${value.data[i].number.toString()}",
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
                  children: [
                    Text(
                      "بند الموازنة: ${value.data[i].budget?.name.toString()}",
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
                      "التاريخ: ${DateFormat(dateFormat).format(value.data[i].date)}",
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
                      "سعر الدولار: ${value.data[i].exchangeRateUSD.toString()}",
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
                Row(
                  children: [
                    Text(
                      "الاجمالى: ${value.data[i].total.toString()}",
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
                if (value.data[i].imageURL != null)
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PhotoViewScreen(
                                  imageUrl: value.data[i].imageURL!),
                            ),
                          );
                        },
                        child: CachedNetworkImage(
                            width: MediaQuery.of(context).size.width - 100,
                            imageUrl: value.data[i].imageURL!,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) {
                              if (kDebugMode) {
                                print(error);
                              }
                              return const Icon(Icons.error);
                            },
                            httpHeaders: Supabase.instance.client.auth.headers))
                  ])
                // const SizedBox(width: 10),
                // Text(
                //   "Main Products",
                //   style: TextStyle(
                //       color: Theme.of(context).colorScheme.onSurfaceVariant,
                //       fontFamily:
                //           Theme.of(context).textTheme.bodyMedium?.fontFamily,
                //       fontSize:
                //           Theme.of(context).textTheme.bodyMedium?.fontSize),
                // ),
                // ListView.builder(
                //     shrinkWrap: true,
                //     physics: const NeverScrollableScrollPhysics(),
                //     itemBuilder: (BuildContext context, int index) {
                //       return Card(
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(15.0)),
                //         color: Theme.of(context).colorScheme.surfaceContainer,
                //         child: Padding(
                //             padding: const EdgeInsets.all(15),
                //             child: Row(
                //               children: [
                //                 Expanded(
                //                     flex: 3,
                //                     child: Text(
                //                       textAlign: TextAlign.start,
                //                       overflow: TextOverflow.ellipsis,
                //                       value.data[i].mainProducts[index].name,
                //                       style: standardTextStyle(context),
                //                     )),
                //                 Expanded(
                //                     flex: 2,
                //                     child: Row(children: [
                //                       const Text(
                //                         "\u0024",
                //                         style: TextStyle(color: Colors.green),
                //                       ),
                //                       Text(
                //                         value.data[i].mainProducts[index].amount
                //                             .toString(),
                //                         style: standardTextStyle(context),
                //                       ),
                //                       const SizedBox(width: 10),
                //                       const Text(
                //                         "x",
                //                         style: TextStyle(color: Colors.red),
                //                       ),
                //                       Text(
                //                         value.data[i].mainProducts[index]
                //                             .priceInUSD
                //                             .toString(),
                //                         style: standardTextStyle(context),
                //                       )
                //                     ]))
                //               ],
                //             )),
                //       );
                //     },
                //     itemCount: value.data[i].mainProducts.length),
                // Text(
                //   "Side Products",
                //   style: TextStyle(
                //       color: Theme.of(context).colorScheme.onSurfaceVariant,
                //       fontFamily:
                //           Theme.of(context).textTheme.bodyMedium?.fontFamily,
                //       fontSize:
                //           Theme.of(context).textTheme.bodyMedium?.fontSize),
                // ),
                // ListView.builder(
                //     shrinkWrap: true,
                //     physics: const NeverScrollableScrollPhysics(),
                //     itemBuilder: (BuildContext context, int index) {
                //       return Card(
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(15.0)),
                //         color: Theme.of(context).colorScheme.surfaceContainer,
                //         child: Padding(
                //             padding: const EdgeInsets.all(15),
                //             child: Row(
                //               children: [
                //                 Expanded(
                //                     flex: 3,
                //                     child: Text(
                //                       textAlign: TextAlign.start,
                //                       overflow: TextOverflow.ellipsis,
                //                       value.data[i].sideProducts[index].name,
                //                       style: standardTextStyle(context),
                //                     )),
                //                 Expanded(
                //                     flex: 2,
                //                     child: Row(children: [
                //                       const Text(
                //                         "\u0024",
                //                         style: TextStyle(color: Colors.green),
                //                       ),
                //                       Text(
                //                         value.data[i].sideProducts[index].amount
                //                             .toString(),
                //                         style: standardTextStyle(context),
                //                       ),
                //                       const SizedBox(width: 10),
                //                       const Text(
                //                         "x",
                //                         style: TextStyle(color: Colors.red),
                //                       ),
                //                       Text(
                //                         value.data[i].sideProducts[index]
                //                             .priceInUSD
                //                             .toString(),
                //                         style: standardTextStyle(context),
                //                       )
                //                     ]))
                //               ],
                //             )),
                //       );
                //     },
                //     itemCount: value.data[i].sideProducts.length),
              ],
            ),
          )));
}
