import 'package:budget_map/widgets/small_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/ordered_product.dart';

class DynamicProductsList extends StatefulWidget {
  final List<OrderedProduct> list;

  const DynamicProductsList({super.key, required this.list});

  @override
  State<StatefulWidget> createState() => _DynamicProductsList();
}

class _DynamicProductsList extends State<DynamicProductsList> {
  TextEditingController name = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController priceInUSD = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Theme.of(context).colorScheme.surfaceContainer,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Text(
                        widget.list[index].name,
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
                      ),
                      Text(
                        widget.list[index].amount.toString(),
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
                      ),
                      Text(
                        widget.list[index].priceInUSD.toString(),
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
                ));
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              height: 10.0,
              color: Theme.of(context).colorScheme.surface,
            );
          },
          itemCount: widget.list.length,
        ),
        Card(
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  TextField(
                    controller: name,
                    decoration: const InputDecoration(
                        filled: true, hintText: "Original Amount"),
                  ),
                  TextField(
                    controller: amount,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                        filled: true, hintText: "Original Amount"),
                  ),
                  TextField(
                    controller: priceInUSD,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                        filled: true, hintText: "Original Amount"),
                  ),
                  buildSmallOutlinedButton(
                    context: context,
                    text: 'Save',
                    onPress: () {
                      OrderedProduct newOrderedProduct = OrderedProduct(
                          name: name.text,
                          amount: int.parse(amount.text),
                          priceInUSD: int.parse(priceInUSD.text));
                      setState(() {
                        widget.list.add(newOrderedProduct);
                      });
                    },
                  )
                ],
              ),
            ))
      ],
    );
  }
}
