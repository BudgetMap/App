import 'package:budget_map/widgets/small_outlined_button.dart';
import 'package:budget_map/widgets/text_field.dart';
import 'package:flutter/material.dart';
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

  TextStyle standardTextStyle(context) => TextStyle(
      overflow: TextOverflow.ellipsis,
      color: Theme.of(context).colorScheme.onSurfaceVariant,
      fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
      fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                              widget.list[index].name,
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
                                widget.list[index].oldPrice.toString(),
                                style: standardTextStyle(context),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                "x",
                                style: TextStyle(color: Colors.red),
                              ),
                              Text(
                                widget.list[index].amount.toString(),
                                style: standardTextStyle(context),
                              )
                            ]))
                      ],
                    )),
              );
            },
            itemCount: widget.list.length),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: Theme.of(context).colorScheme.surfaceContainer,
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(children: [
                    Expanded(
                        child: buildTextField(
                            context: context,
                            controller: name,
                            hint: "Product Name"))
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    Expanded(
                        child: buildTextField(
                            context: context,
                            controller: amount,
                            hint: "Amount",
                            numeric: true)),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: buildTextField(
                            context: context,
                            controller: priceInUSD,
                            hint: "Price",
                            numeric: true)),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: buildSmallOutlinedButton(
                      context: context,
                      text: 'Add',
                      onPress: () {
                        if (name.text.isEmpty ||
                            amount.text.isEmpty ||
                            priceInUSD.text.isEmpty) {
                          return;
                        }
                        OrderedProduct newOrderedProduct = OrderedProduct(
                            name: name.text,
                            amount: int.parse(amount.text),
                            oldPrice: int.parse(priceInUSD.text),
                            newPrice: int.parse(priceInUSD.text),
                            delivered: false);
                        setState(() {
                          widget.list.add(newOrderedProduct);
                          name.clear();
                          amount.clear();
                          priceInUSD.clear();
                        });
                      },
                    ))
                  ])
                ],
              )),
        )
      ],
    );
  }
}
