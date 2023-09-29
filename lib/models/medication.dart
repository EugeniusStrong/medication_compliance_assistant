import 'package:medication_compliance_assistant/models/drug.dart';
import 'package:medication_compliance_assistant/models/patient.dart';

class Medication {
  final String id;
  final String diagnosis;
  final Patient patient;
  final List<Drug> medicalSupplies;
  final String? therapy;
  final String? recommendations;

  Medication({
    required this.id,
    required this.diagnosis,
    required this.patient,
    this.medicalSupplies = const [],
    this.therapy,
    this.recommendations,
  });

  Medication copyWith({
    String? id,
    String? diagnosis,
    Patient? patient,
    List<Drug>? medicalSupplies,
    String? therapy,
    String? recommendations,
  }) {
    return Medication(
      id: id ?? this.id,
      diagnosis: diagnosis ?? this.diagnosis,
      patient: patient ?? this.patient,
      medicalSupplies: medicalSupplies ?? this.medicalSupplies,
      therapy: therapy ?? this.therapy,
      recommendations: recommendations ?? this.recommendations,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'diagnosis': diagnosis,
      'patientId': patient.id,
      'therapy': therapy,
      'recommendations': recommendations,
    };
  }
}
