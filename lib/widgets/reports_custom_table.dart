import 'package:flutter/material.dart';
import 'package:pd_hours/utils/theme/app_colors.dart';

class ReportsCustomTable extends StatelessWidget {
  double width;
  List<List<dynamic>> reports;
  ReportsCustomTable({
    Key? key,
    required this.width,
    required this.reports,
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
            0: const FlexColumnWidth(),
            1: FixedColumnWidth(width * 0.4),
            2: const FlexColumnWidth(),
            3: const FlexColumnWidth(),
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
                    'Membro',
                    style: textTheme.subtitle1?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Descrição',
                    style: textTheme.subtitle1?.copyWith(color: Colors.white),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Horas',
                    style: textTheme.subtitle1?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Criado em',
                    style: textTheme.subtitle1?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            ...reports.map((report) {
              int i = -1;
              return TableRow(
                  decoration: const BoxDecoration(
                    color: AppColors.gray1,
                  ),
                  children: report.map((e) {
                    i++;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        e.toString(),
                        style: textTheme.bodyText1,
                        textAlign: i == 1 ? TextAlign.start : TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList());
            }).toList(),
          ],
        ),
      ),
    );
  }
}
