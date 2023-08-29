class UserMedicationReminder {
  final String? id;
  final String? firstName;
  final String? secondName;
  final String? diagnosis;
  final String? drugName;
  final String? drugDose;
  DateTime? drugTime;
  bool? isRemind;

  UserMedicationReminder({
    this.id,
    this.firstName,
    this.secondName,
    this.diagnosis,
    this.drugName,
    this.drugDose,
    this.drugTime,
    this.isRemind,
  });

  factory UserMedicationReminder.fromMap(Map<String, dynamic> map) {
    return UserMedicationReminder(
      id: map['id'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      diagnosis: map['diagnosis'],
      drugName: map['drugName'],
      drugDose: map['drugDose'],
      drugTime:
          map['drugTime'] != null ? DateTime.parse(map['drugTime']) : null,
      isRemind: map['isRemind'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'secondName': secondName,
      'diagnosis': diagnosis,
      'drugName': drugName,
      'drugDose': drugDose,
      'drugTime': drugTime?.toIso8601String(),
      'isRemind': isRemind,
    };
  }

  UserMedicationReminder copyWith({
    String? id,
    String? firstName,
    String? secondName,
    String? diagnosis,
    String? drugName,
    String? drugDose,
    DateTime? drugTime,
    bool? isRemind,
  }) {
    return UserMedicationReminder(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
      diagnosis: diagnosis ?? this.diagnosis,
      drugName: drugName ?? this.drugName,
      drugDose: drugDose ?? this.drugDose,
      drugTime: drugTime ?? this.drugTime,
      isRemind: isRemind ?? this.isRemind,
    );
  }
}
