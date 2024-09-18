import 'package:flutter/material.dart';
import 'package:pd_hours/models/employee.dart';
import 'package:pd_hours/providers/employees_provider.dart';
import 'package:pd_hours/widgets/add_user_modal.dart';
import 'package:pd_hours/widgets/employees_custom_table.dart';
import 'package:pd_hours/widgets/empty_card.dart';

import 'package:provider/provider.dart';

class UserTab extends StatelessWidget {
  const UserTab({super.key});
  void _showAddUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddUserModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Consumer<EmployeesProvider>(
      builder: (context, employeesProvider, _) {
        final List<Employee> employees = employeesProvider.employees;

        if (employees.isEmpty) {
          return Align(
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              child: EmptyCard(
                labelButton: "Criar usuário",
                description:
                    "Nenhum usuário cadastrado. Crie um usuário para começar.",
                onPressed: () => _showAddUserDialog(context),
              ),
            ),
          );
        }

        return Align(
          alignment: Alignment.topLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lista de Usuários",
                  style: textTheme.headline1,
                ),
                SizedBox(
                  width: screenSize.width * 0.6,
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
                          EmployeesCustomTable(
                            width: screenSize.width * 0.5,
                            employees: employees,
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: ElevatedButton(
                              onPressed: () => _showAddUserDialog(context),
                              child: const Text(
                                "Criar usuário",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
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
      },
    );
  }
}
