import 'package:flutter/material.dart';

import 'package:pd_hours/utils/app_images.dart';

class EmptyCard extends StatelessWidget {
  String? labelButton;
  String description;
  double? elevation;
  void Function()? onPressed;
  EmptyCard({
    Key? key,
    this.labelButton,
    required this.description,
    this.onPressed,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 490,
      height: 410,
      child: Card(
          elevation: elevation,
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
              if (labelButton != null)
                ElevatedButton(
                  onPressed: onPressed,
                  child: Text(labelButton!),
                )
            ],
          )),
    );
  }
}
