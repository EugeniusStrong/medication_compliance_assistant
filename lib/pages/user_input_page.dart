import 'package:flutter/material.dart';
import 'package:medication_compliance_assistant/models/patient.dart';

class UserInputPage extends StatefulWidget {
  final Patient? patient;

  const UserInputPage({super.key, required this.patient});

  @override
  State<UserInputPage> createState() => _UserInputPageState();
}

class _UserInputPageState extends State<UserInputPage> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _birthDay;
  late Gender _gender;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _middleNameController;
  late final TextEditingController _addressNameController;

  @override
  void initState() {
    super.initState();
    _firstNameController =
        TextEditingController(text: widget.patient?.firstName ?? '');
    _lastNameController =
        TextEditingController(text: widget.patient?.lastName ?? '');
    _middleNameController =
        TextEditingController(text: widget.patient?.middleName ?? '');
    _addressNameController =
        TextEditingController(text: widget.patient?.address ?? '');
    _birthDay = widget.patient?.birthDate ?? DateTime(1900);
    _gender = widget.patient?.gender ?? Gender.male;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _middleNameController.dispose();
    _addressNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ИНФОРМАЦИЯ ПАЦИЕНТА',
          style: TextStyle(color: Colors.deepPurple),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Center(
                child: Icon(
                  Icons.person,
                  color: Colors.deepPurple,
                  size: 80,
                ),
              ),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _firstNameController.clear();
                      },
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.deepPurple,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        borderSide:
                            BorderSide(color: Colors.black38, width: 2)),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        borderSide:
                            BorderSide(color: Colors.deepPurple, width: 2)),
                    labelText: 'Введите имя',
                    hintText: 'Имя пациента'),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _lastNameController.clear();
                      },
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.deepPurple,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        borderSide:
                            BorderSide(color: Colors.black38, width: 2)),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        borderSide:
                            BorderSide(color: Colors.deepPurple, width: 2)),
                    labelText: 'Введите фамилию',
                    hintText: 'Фамилия пациента'),
              ),
              const Icon(
                Icons.edit_note_outlined,
                color: Colors.deepPurple,
                size: 80,
              ),
              TextFormField(
                controller: _diagnosisNameController,
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _diagnosisNameController.clear();
                      },
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.deepPurple,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        borderSide:
                            BorderSide(color: Colors.black38, width: 2)),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        borderSide:
                            BorderSide(color: Colors.deepPurple, width: 2)),
                    labelText: 'Введите диагноз',
                    hintText: 'Диагноз пациента'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          widget.userMedicationReminder.firstName = _firstNameController.text;
          widget.userMedicationReminder.secondName = _lastNameController.text;
          widget.userMedicationReminder.diagnosis =
              _diagnosisNameController.text;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DrugInputPage(
                userMedicationReminder: widget.userMedicationReminder,
              ),
            ),
          );
        },
        child: const Text('Далее'),
      ),
    );
  }
}
