import 'package:flutter/material.dart';
import 'package:pd_hours/pages/tabs/squad_tab.dart';
import 'package:pd_hours/widgets/add_user_modal.dart';
import 'package:pd_hours/widgets/custom_appbar.dart';
import 'package:pd_hours/widgets/empty_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const CustomAppbar(),
        body: Padding(
          padding: EdgeInsets.only(left: screenSize.width * 0.08),
          child: TabBarView(
            children: [
              const SquadTab(),
              Align(
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                  child: EmptyCard(
                    labelButton: "Criar usuário",
                    description:
                        "Nenhum usuário cadastrado. Crie um usuário para começar.",
                    onPressed: () => _showAddUserDialog(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
