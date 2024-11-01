import 'package:budget_map/widgets/small_outlined_button.dart';
import 'package:flutter/material.dart';

Builder buildSaveDeleteButtons(
    {dynamic data,
    required void Function() saveFunction,
    required Null Function() deleteFunction}) {
  return Builder(builder: (BuildContext context) {
    if (data == null) {
      return buildSmallOutlinedButton(
        context: context,
        text: 'اضافة',
        onPress: saveFunction,
      );
    } else {
      return Row(
        children: [
          Expanded(
              child: buildSmallOutlinedButton(
            color: Theme.of(context).colorScheme.error,
            onColor: Theme.of(context).colorScheme.onError,
            context: context,
            text: 'حذف',
            onPress: () {
              // Todo
            },
          )),
          const SizedBox(width: 10),
          Expanded(
              child: buildSmallOutlinedButton(
            context: context,
            text: 'تعديل',
            onPress: () {
              // Todo
            },
          ))
        ],
      );
      // }
    }
  });
}
