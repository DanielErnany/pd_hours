import 'package:flutter/material.dart';
import 'package:pd_hours/models/report.dart';
import 'package:pd_hours/providers/employees_provider.dart';
import 'package:pd_hours/providers/reports_provider.dart';
import 'package:provider/provider.dart';

class AddLaunchModal extends StatefulWidget {
  const AddLaunchModal({super.key});

  @override
  State<AddLaunchModal> createState() => _AddLaunchModalState();
}

class _AddLaunchModalState extends State<AddLaunchModal> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _spentHoursController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _showEmployeeIdError = false;

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final String description = _descriptionController.text;
      final int spentHours = int.parse(_spentHoursController.text);
      final int employeeId = int.parse(_employeeIdController.text);

      EmployeesProvider employeesProvider =
          Provider.of<EmployeesProvider>(context, listen: false);

      bool existEmployeeId = employeesProvider.existEmployeeId(employeeId);

      if (existEmployeeId) {
        Report report = Report(
          employeeId: employeeId,
          description: description,
          spentHours: spentHours,
          createdAt: DateTime.now(),
        );

        final ReportsProvider reportsProvider =
            Provider.of<ReportsProvider>(context, listen: false);

        reportsProvider.addReport(report);

        Navigator.of(context).pop();
      } else {
        setState(() {
          _showEmployeeIdError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: const Text(
            "Criar lançamento",
            overflow: TextOverflow.ellipsis,
          ),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_showEmployeeIdError)
                  ClipRect(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: theme.errorColor.withOpacity(0.2),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.01,
                        vertical: 5,
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Icon(Icons.warning_amber,
                                color: theme.errorColor),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.01,
                          ),
                          const Text(
                            "Não existe usuário com este id",
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            width: screenSize.width * 0.01,
                          ),
                          Flexible(
                              child: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => setState(() {
                              _showEmployeeIdError = false;
                            }),
                          ))
                        ],
                      ),
                    ),
                  ),
                TextFormField(
                  controller: _employeeIdController,
                  decoration: InputDecoration(
                    labelText: 'ID do usuário',
                    hintText: "Digite o ID do usuário",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor, insira o ID do usuário';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Por favor, insira um número inteiro';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _spentHoursController,
                  decoration: InputDecoration(
                    labelText: 'Horas gastas',
                    hintText: "Digite a quantidade de horas",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor, insira as horas gastas';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Por favor, insira um número inteiro';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  minLines: 5,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor, insira a descrição';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                    hintText:
                        "Exemplo de texto de descrição da tarefa executada.",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancelar",
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ElevatedButton(
              onPressed: _saveForm,
              child: const Text(
                "Criar lançamento",
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
