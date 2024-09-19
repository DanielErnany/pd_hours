import 'package:flutter/material.dart';

import 'package:pd_hours/models/squad.dart';
import 'package:pd_hours/utils/theme/app_colors.dart';

class SquadCustomTable extends StatelessWidget {
  double width;
  List<Squad> squads;

  Function(Squad squad) onSquadButtonPressed;

  SquadCustomTable({
    Key? key,
    required this.width,
    required this.squads,
    required this.onSquadButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: width,
        ),
        child: Table(
          border: TableBorder(
            horizontalInside: BorderSide(
              color: Colors.grey.withOpacity(0.2),
              width: 1,
            ),
            verticalInside: BorderSide.none,
            top: BorderSide.none,
            bottom: BorderSide.none,
            left: BorderSide.none,
            right: BorderSide.none,
          ),
          columnWidths: {
            0: FixedColumnWidth(width * 0.1),
            1: const FlexColumnWidth(),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'ID',
                    style: textTheme.subtitle1?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Nome',
                    style: textTheme.subtitle1?.copyWith(color: Colors.white),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            ...squads.map((squad) {
              return TableRow(
                decoration: const BoxDecoration(
                  color: AppColors.gray1,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 10,
                    ),
                    child: Text(
                      squad.id.toString(),
                      style: textTheme.bodyText1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            squad.name,
                            style: textTheme.bodyText1,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: ElevatedButton(
                            onPressed: (() => onSquadButtonPressed(squad)),
                            child: const Text(
                              "Visitar squad",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
