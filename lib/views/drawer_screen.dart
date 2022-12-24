import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Change your Language'.tr(),
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MaterialButton(
              color: Colors.deepOrange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
              onPressed: () {},
              child: Text('English'.tr()),
            ),
            MaterialButton(
              color: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
              onPressed: () {},
              child: Text('Arabic'.tr()),
            ),
          ],
        )
      ],
    );
  }
}
