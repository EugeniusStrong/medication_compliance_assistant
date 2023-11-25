class Patient {
  final String id;
  final String firstName;
  final String lastName;
  final String? middleName;
  final DateTime birthDate;
  final Gender gender;
  final String? address;

  Patient({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
    this.middleName,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'middleName': middleName,
      'birthDate': birthDate.toIso8601String(),
      'gender': gender.name,
      'address': address,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    final rawGender = map['gender'] as String;
    final gender = Gender.values.firstWhere((e) => e.name == rawGender);
    return Patient(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      middleName: map['middleName'] as String,
      birthDate: DateTime.parse(map['birthDate']),
      gender: gender,
      address: map['address'] as String,
    );
  }

  Patient copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? middleName,
    DateTime? birthDate,
    Gender? gender,
    String? address,
  }) {
    return Patient(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      address: address ?? this.address,
    );
  }

  @override
  String toString() {
    return '$lastName $firstName ${middleName ?? ''}';
  }
}

enum Gender { male, female }
