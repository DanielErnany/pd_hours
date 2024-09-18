import 'package:flutter/material.dart';
import 'package:pd_hours/models/employee.dart';
import 'package:pd_hours/utils/theme/app_colors.dart';

class EmployeesCustomTable extends StatelessWidget {
  double width;
  List<Employee> employees;
  EmployeesCustomTable({
    Key? key,
    required this.width,
    required this.employees,
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
            0: FixedColumnWidth(width * 0.4),
            1: const FlexColumnWidth(),
            2: const FlexColumnWidth(),
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
                    'Nome',
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
                    'Squad ID',
                    style: textTheme.subtitle1?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            ...employees.map((employee) {
              return TableRow(
                decoration: const BoxDecoration(
                  color: AppColors.gray1,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      employee.name,
                      style: textTheme.bodyText1,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      employee.estimatedHours.toString(),
                      style: textTheme.bodyText1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      employee.squadId.toString(),
                      style: textTheme.bodyText1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
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
