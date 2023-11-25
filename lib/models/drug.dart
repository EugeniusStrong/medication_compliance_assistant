class Drug {
  final String id;
  final String name;
  final String description;
  final String dose;
  final int cost;

  Drug({
    required this.id,
    required this.name,
    required this.description,
    required this.dose,
    required this.cost,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'dose': dose,
      'cost': cost,
    };
  }

  factory Drug.fromMap(Map<String, dynamic> map) {
    return Drug(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      dose: map['dose'] as String,
      cost: map['cost'] as int,
    );
  }

  Drug copyWith({
    String? id,
    String? name,
    String? description,
    String? dose,
    int? cost,
  }) {
    return Drug(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      dose: dose ?? this.dose,
      cost: cost ?? this.cost,
    );
  }

  @override
  String toString() {
    return '$id $name';
  }
}
