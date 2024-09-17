import 'package:flutter/material.dart';

import 'package:pd_hours/utils/app_images.dart';

class EmptyCard extends StatelessWidget {
  String labelButton;
  String description;
  void Function()? onPressed;
  EmptyCard({
    Key? key,
    required this.labelButton,
    required this.description,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 490,
      height: 410,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                AppImages.empty_emoji,
              ),
              Text(
                description,
              ),
              ElevatedButton(
                onPressed: onPressed,
                child: Text(labelButton),
              )
            ],
          )),
    );
  }
}
