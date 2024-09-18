import 'package:flutter/foundation.dart';
import 'package:pd_hours/models/squad.dart';

class SquadProvider with ChangeNotifier {
  final List<Squad> _squads = [];

  List<Squad> get squads => [..._squads];

  void addSquad(Squad squad) {
    int maxId = _squads.isEmpty
        ? 0
        : _squads.map((squad) => squad.id).reduce((a, b) => a! > b! ? a : b)!;

    int nextId = maxId + 1;

    squad.id = nextId;

    _squads.add(squad);

    notifyListeners();
  }
}
