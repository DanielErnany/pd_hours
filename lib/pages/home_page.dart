import 'package:flutter/material.dart';
import 'package:pd_hours/pages/tabs/squad_tab.dart';
import 'package:pd_hours/pages/tabs/user_tab.dart';
import 'package:pd_hours/providers/squads_provider.dart';
import 'package:pd_hours/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final SquadsProvider squadsProvider =
        Provider.of<SquadsProvider>(context, listen: true);

    final bool isEmptySquads = squadsProvider.squads.isEmpty;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const CustomAppbar(),
        body: Padding(
          padding: EdgeInsets.only(left: screenSize.width * 0.08),
          child: TabBarView(
            children: [
              const SquadTab(),
              isEmptySquads ? const SquadTab() : const UserTab(),
            ],
          ),
        ),
      ),
    );
  }
}
