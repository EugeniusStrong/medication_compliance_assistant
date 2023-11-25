part of 'drug_edit_bloc.dart';

abstract class DrugEditState extends Equatable {
  const DrugEditState();
}

class DrugEditInitial extends DrugEditState {
  @override
  List<Object> get props => [];
}

class DrugSaveSuccess extends DrugEditState {
  final Drug drug;

  const DrugSaveSuccess({required this.drug});
  @override
  List<Object?> get props => [drug];
}

class DrugDeleteSuccess extends DrugEditState {
  final String drugId;

  const DrugDeleteSuccess({required this.drugId});
  @override
  List<Object?> get props => [drugId];
}
