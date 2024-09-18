import 'package:flutter/material.dart';
import 'package:pd_hours/widgets/add_user_modal.dart';
import 'package:pd_hours/widgets/empty_card.dart';

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
}
