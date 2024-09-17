import 'package:flutter/material.dart';
import 'package:pd_hours/widgets/custom_appbar.dart';
import 'package:pd_hours/widgets/empty_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              Align(
                alignment: Alignment.centerLeft,
                child: EmptyCard(
                  labelButton: "Criar squad",
                  description:
                      "Nenhuma squad cadastrada. Crie uma squad para começar.",
                  onPressed: () {},
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: EmptyCard(
                  labelButton: "Criar usuário",
                  description:
                      "Nenhum usuário cadastrado. Crie um usuário para começar.",
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
