import 'package:flutter/material.dart';
import 'package:pd_hours/models/employee.dart';
import 'package:pd_hours/providers/employees_provider.dart';
import 'package:pd_hours/providers/squads_provider.dart';
import 'package:provider/provider.dart';

class AddUserModal extends StatefulWidget {
  const AddUserModal({super.key});

  @override
  State<AddUserModal> createState() => _AddUserModalState();
}

class _AddUserModalState extends State<AddUserModal> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _squadController = TextEditingController();

  bool _showSquadIdError = false;

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text;
      final int estimatedHours = int.parse(_hoursController.text);
      final int squadId = int.parse(_squadController.text);

      SquadsProvider squadsProvider =
          Provider.of<SquadsProvider>(context, listen: false);

      bool existSquadId = squadsProvider.existSquadId(squadId);

      if (existSquadId) {
        Employee employee = Employee(
          name: name,
          estimatedHours: estimatedHours,
          squadId: squadId,
        );

        final EmployeesProvider employeesProvider =
            Provider.of<EmployeesProvider>(context, listen: false);

        employeesProvider.addEmployee(employee);

        Navigator.of(context).pop();
      } else {
        setState(() {
          _showSquadIdError = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _hoursController.dispose();
    _squadController.dispose();
    super.dispose();
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
            "Criar Usuário",
            overflow: TextOverflow.ellipsis,
          ),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_showSquadIdError)
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
                          Text(
                            "Não existe squad com este id",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: theme.errorColor),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.01,
                          ),
                          Flexible(
                              child: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => setState(() {
                              _showSquadIdError = false;
                            }),
                          ))
                        ],
                      ),
                    ),
                  ),
                TextFormField(
                  controller: _nameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Nome do usuário',
                    hintText: "Digite o nome do usuário",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor, insira o nome do usuário';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _hoursController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Horas estimadas de trabalho',
                    hintText: "Digite as horas estimadas",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor, insira as horas estimadas';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Por favor, insira um número inteiro';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _squadController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    suffixIcon: _showSquadIdError
                        ? Icon(Icons.warning_amber, color: theme.errorColor)
                        : null,
                    labelText: 'Squad',
                    hintText: "Digite o Id da squad",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color:
                            _showSquadIdError ? theme.errorColor : Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: _showSquadIdError
                            ? theme.errorColor
                            : theme.primaryColor, // Cor da borda focada
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor, insira o Id da squad';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Por favor, insira um número inteiro';
                    }
                    return null;
                  },
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
                "Criar usuário",
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
