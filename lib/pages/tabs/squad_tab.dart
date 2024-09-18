import 'package:flutter/material.dart';
import 'package:pd_hours/widgets/squads_custom_table.dart';
import 'package:provider/provider.dart';

import 'package:pd_hours/models/squad.dart';
import 'package:pd_hours/providers/squads_provider.dart';
import 'package:pd_hours/widgets/add_squad_modal.dart';
import 'package:pd_hours/widgets/empty_card.dart';

class SquadTab extends StatefulWidget {
  const SquadTab({super.key});

  @override
  State<SquadTab> createState() => _SquadTabState();
}

class _SquadTabState extends State<SquadTab> {
  void _showAddSquadDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddSquadModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Consumer<SquadsProvider>(
      builder: (context, squadProvider, _) {
        final List<Squad> squads = squadProvider.squads;

        if (squads.isEmpty) {
          return Align(
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              child: EmptyCard(
                labelButton: "Criar squad",
                description:
                    "Nenhuma squad cadastrada. Crie uma squad para começar.",
                onPressed: () => _showAddSquadDialog(context),
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
                  "Lista de Squads",
                  style: textTheme.headline1,
                ),
                SizedBox(
                  width: screenSize.width * 0.5,
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
                          SquadCustomTable(
                            width: screenSize.width * 0.4,
                            squads: squads,
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: ElevatedButton(
                              onPressed: () => _showAddSquadDialog(context),
                              child: const Text(
                                "Criar squad",
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
