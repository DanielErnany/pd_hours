import 'package:flutter/material.dart';
import 'package:pd_hours/models/squad.dart';
import 'package:pd_hours/providers/squads_provider.dart';
import 'package:provider/provider.dart';

class AddSquadModal extends StatefulWidget {
  const AddSquadModal({super.key});

  @override
  State<AddSquadModal> createState() => _AddSquadModalState();
}

class _AddSquadModalState extends State<AddSquadModal> {
  final _nameKey = GlobalKey<FormFieldState<String>>();

  void _saveForm() {
    if (!_nameKey.currentState!.validate()) return;

    Squad squad = Squad(name: _nameKey.currentState!.value!);
    final squadProvider = Provider.of<SquadsProvider>(context, listen: false);

    squadProvider.addSquad(squad);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: const Text(
            "Criar Squad",
            overflow: TextOverflow.ellipsis,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                key: _nameKey,
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim().isEmpty) {
                    return 'Por favor, insira o nome do squad';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'Nome da Squad',
                  hintText: "Digite o nome da squad",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
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
              onPressed: () {
                _saveForm();
              },
              child: const Text(
                "Criar squad",
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
