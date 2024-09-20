import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pd_hours/models/employee.dart';
import 'package:pd_hours/models/report.dart';

import 'package:pd_hours/models/squad.dart';
import 'package:pd_hours/providers/employees_provider.dart';
import 'package:pd_hours/providers/reports_provider.dart';
import 'package:pd_hours/utils/theme/app_colors.dart';
import 'package:pd_hours/widgets/add_user_modal.dart';
import 'package:pd_hours/widgets/empty_card.dart';
import 'package:pd_hours/widgets/reports_custom_table.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';

class SquadCard extends StatefulWidget {
  Squad squad;

  Function() backOnPressed;

  SquadCard({
    Key? key,
    required this.squad,
    required this.backOnPressed,
  }) : super(key: key);

  @override
  State<SquadCard> createState() => _SquadCardState();
}

class _SquadCardState extends State<SquadCard> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _initialDateController = TextEditingController();
  final TextEditingController _finalDateController = TextEditingController();

  bool _isNotValidInterval = true;

  DateTime? _initialDate;
  DateTime? _finalDate;

  void _filterReports() {
    setState(() {
      _isNotValidInterval = !_formKey.currentState!.validate();
    });
    if (!_isNotValidInterval) {
      _initialDate =
          DateFormat("dd/MM/yyyy").parse(_initialDateController.text);
      _finalDate = DateFormat("dd/MM/yyyy").parse(_finalDateController.text);
    }
  }

  void _showAddUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddUserModal();
      },
    );
  }

  double calculateAverageHoursPerDay(
      int totalHours, DateTime initialDate, DateTime finalDate) {
    int totalDays = finalDate.difference(initialDate).inDays;

    if (totalDays == 0) {
      return totalHours.toDouble();
    }

    double averageHoursPerDay = totalHours / totalDays;

    return averageHoursPerDay;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    double widthFields =
        screenSize.width * 0.2 < 200 ? screenSize.width * 0.2 : 200;

    List<Employee> employeesFromSquad = Provider.of<EmployeesProvider>(context)
        .employeesFromSquad(widget.squad.id!);

    List<Report> reportsFromSquad = [];
    int totalHours = 0;

    if (employeesFromSquad.isNotEmpty) {
      ReportsProvider reportsProvider = Provider.of<ReportsProvider>(context);

      List<int> employeesIds = employeesFromSquad.map((e) => e.id!).toList();

      if (!_isNotValidInterval) {
        reportsFromSquad = reportsProvider.reportsFromEmployees(
          employeesIds: employeesIds,
          initialDate: _initialDate!,
          finalDate: _finalDate!,
        );

        for (var element in reportsFromSquad) {
          totalHours += element.spentHours;
        }
      }
    }
    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.squad.name,
              style: textTheme.headline1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              width: screenSize.width * 0.82,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.02,
                    vertical: screenSize.height * 0.05,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: widget.backOnPressed,
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      Text(
                        "Horas por membro",
                        style: textTheme.headline4
                            ?.copyWith(color: AppColors.black),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 20),
                        child: Form(
                          key: _formKey,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              SizedBox(
                                width: widthFields,
                                child: TextFormField(
                                  controller: _initialDateController,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.trim().isEmpty) {
                                      return 'Por favor, insira a data de inicio';
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    DataInputFormatter(),
                                  ],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'Inicio',
                                    hintText: "16/09/2024",
                                    prefixIcon:
                                        const Icon(Icons.calendar_today),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: screenSize.width * 0.05 < 10
                                    ? screenSize.width * 0.05
                                    : 10,
                              ),
                              SizedBox(
                                width: widthFields,
                                child: TextFormField(
                                  controller: _finalDateController,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.trim().isEmpty) {
                                      return 'Por favor, insira a data de fim';
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    DataInputFormatter(),
                                  ],
                                  decoration: InputDecoration(
                                    labelText: 'Fim',
                                    hintText: "20/09/2024",
                                    prefixIcon:
                                        const Icon(Icons.calendar_today), //
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: screenSize.width * 0.05 < 10
                                    ? screenSize.width * 0.05
                                    : 10,
                              ),
                              SizedBox(
                                width: widthFields,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: employeesFromSquad
                                              .isEmpty
                                          ? theme.primaryColor.withOpacity(0.5)
                                          : theme.primaryColor),
                                  onPressed: employeesFromSquad.isEmpty
                                      ? () {}
                                      : _filterReports,
                                  child: const Text("Filtrar por data"),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                      (employeesFromSquad.isEmpty)
                          ? EmptyCard(
                              labelButton: "Criar usuário",
                              elevation: 0,
                              description:
                                  "Nenhum usuário cadastrado nesta squad. Crie um usuário para começar.",
                              onPressed: () => _showAddUserDialog(context),
                            )
                          : (_isNotValidInterval)
                              ? EmptyCard(
                                  elevation: 0,
                                  description:
                                      "Nenhum intervalo de data selecionado. Selecione um intervalo para começar.",
                                )
                              : const SizedBox(),
                      (reportsFromSquad.isNotEmpty)
                          ? Column(
                              children: [
                                ReportsCustomTable(
                                  width: screenSize.width * 0.5,
                                  reports: reportsFromSquad
                                      .map((report) => [
                                            employeesFromSquad
                                                .where((element) =>
                                                    element.id ==
                                                    report.employeeId)
                                                .map((e) => e.name.toString())
                                                .first,
                                            report.description,
                                            report.spentHours,
                                            DateFormat('dd/MM/yyyy')
                                                .format(report.createdAt)
                                          ])
                                      .toList(),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "Horas totais da squad",
                                  style: textTheme.headline4
                                      ?.copyWith(color: AppColors.black),
                                ),
                                Text(
                                  "$totalHours Horas",
                                  style: textTheme.headline3?.copyWith(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "Média de horas por dia",
                                  style: textTheme.headline4
                                      ?.copyWith(color: AppColors.black),
                                ),
                                Text(
                                  "${calculateAverageHoursPerDay(totalHours, _initialDate!, _finalDate!)} Horas/Dia",
                                  style: textTheme.headline3?.copyWith(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            )
                          : EmptyCard(
                              elevation: 0,
                              description: "Nenhum lançamento cadastrado.",
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
