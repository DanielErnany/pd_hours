import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pd_hours/models/squad.dart';
import 'package:pd_hours/utils/theme/app_colors.dart';
import 'package:pd_hours/widgets/add_user_modal.dart';
import 'package:pd_hours/widgets/empty_card.dart';

class SquadCard extends StatelessWidget {
  Squad squad;

  Function() backOnPressed;

  SquadCard({
    Key? key,
    required this.squad,
    required this.backOnPressed,
  }) : super(key: key);

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
    double widthFields =
        screenSize.width * 0.2 < 200 ? screenSize.width * 0.2 : 200;
    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              squad.name,
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
                          onPressed: backOnPressed,
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            SizedBox(
                              width: widthFields,
                              child: TextFormField(
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
                                  prefixIcon: const Icon(Icons.calendar_today),
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
                                onPressed: () {},
                                child: const Text("Filtrar por data"),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      EmptyCard(
                        labelButton: "Criar usuário",
                        elevation: 0,
                        description:
                            "Nenhum usuário cadastrado nesta squad. Crie um usuário para começar.",
                        onPressed: () => _showAddUserDialog(context),
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
