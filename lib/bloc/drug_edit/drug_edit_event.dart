part of 'drug_edit_bloc.dart';

abstract class DrugEditEvent extends Equatable {
  const DrugEditEvent();
}

class DrugSavePressed extends DrugEditEvent {
  final String name;
  final String description;
  final String dose;
  final int cost;

  const DrugSavePressed({
    required this.name,
    required this.description,
    required this.dose,
    required this.cost,
  });

  @override
  List<Object?> get props => [
        name,
        description,
        dose,
        cost,
      ];
}

class DrugDeleteRequested extends DrugEditEvent {
  final String id;

  const DrugDeleteRequested(this.id);

  @override
  List<Object?> get props => [id];
}
