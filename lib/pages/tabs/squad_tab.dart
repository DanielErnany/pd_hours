import 'package:flutter/material.dart';
import 'package:pd_hours/providers/squads_provider.dart';
import 'package:pd_hours/utils/theme/app_colors.dart';
import 'package:pd_hours/widgets/add_squad_modal.dart';
import 'package:pd_hours/widgets/empty_card.dart';
import 'package:provider/provider.dart';

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
        final squads = squadProvider.squads;

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
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: screenSize.width * 0.4,
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
                                  0: FixedColumnWidth(screenSize.width * 0.1),
                                  1: const FlexColumnWidth(),
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
                                          'ID',
                                          style: textTheme.subtitle1
                                              ?.copyWith(color: Colors.white),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Nome',
                                          style: textTheme.subtitle1
                                              ?.copyWith(color: Colors.white),
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  ...squads.map((squad) {
                                    return TableRow(
                                      decoration: const BoxDecoration(
                                        color: AppColors.gray1,
                                      ),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            squad.id.toString(),
                                            style: textTheme.bodyText1,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  squad.name,
                                                  style: textTheme.bodyText1,
                                                  textAlign: TextAlign.start,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Flexible(
                                                child: ElevatedButton(
                                                  onPressed: () {},
                                                  child: const Text(
                                                    "Visitar squad",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
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
