import 'package:flutter/material.dart';
import 'package:medication_compliance_assistant/models/patient.dart';
import 'package:intl/intl.dart';

class PatientInputPage extends StatefulWidget {
  final Patient? patient;

  const PatientInputPage({super.key, required this.patient});

  @override
  State<PatientInputPage> createState() => _PatientInputPageState();
}

class _PatientInputPageState extends State<PatientInputPage> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _birthDay;
  late Gender _gender;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _middleNameController;
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _firstNameController =
        TextEditingController(text: widget.patient?.firstName ?? '');
    _lastNameController =
        TextEditingController(text: widget.patient?.lastName ?? '');
    _middleNameController =
        TextEditingController(text: widget.patient?.middleName ?? '');
    _addressController =
        TextEditingController(text: widget.patient?.address ?? '');
    _birthDay = widget.patient?.birthDate ?? DateTime(1900);
    _gender = widget.patient?.gender ?? Gender.male;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _middleNameController.dispose();
    _addressController.dispose();
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
      body: SingleChildScrollView(
        child: Form(
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
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLength: 30,
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
                              BorderSide(color: Colors.black26, width: 2)),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          borderSide:
                              BorderSide(color: Colors.deepPurple, width: 2)),
                      labelText: 'Введите фамилию',
                      hintText: 'Обязательное поле'),
                  validator: _validateName,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLength: 30,
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
                              BorderSide(color: Colors.black26, width: 2)),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          borderSide:
                              BorderSide(color: Colors.deepPurple, width: 2)),
                      labelText: 'Введите имя',
                      hintText: 'Обязательное поле'),
                  validator: _validateName,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLength: 30,
                  controller: _middleNameController,
                  decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _middleNameController.clear();
                        },
                        child: const Icon(
                          Icons.delete_outline,
                          color: Colors.deepPurple,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          borderSide:
                              BorderSide(color: Colors.black26, width: 2)),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          borderSide:
                              BorderSide(color: Colors.deepPurple, width: 2)),
                      labelText: 'Введите отчество(если есть)',
                      hintText: 'Отчество пациента'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLength: 40,
                  controller: _addressController,
                  decoration: InputDecoration(
                      helperText: 'ПРИМЕР: г.Москва, ул.Пушкина, д.12, кв.5',
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
                              BorderSide(color: Colors.black26, width: 2)),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          borderSide:
                              BorderSide(color: Colors.deepPurple, width: 2)),
                      labelText: 'Введите адрес',
                      hintText: 'Адрес пациента'),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField<Gender>(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.red, width: 2),
                          borderRadius: BorderRadius.circular(40))),
                  value: _gender,
                  onChanged: (Gender? newValue) {
                    setState(() {
                      _gender = newValue!;
                    });
                  },
                  items: Gender.values.map((Gender gender) {
                    return DropdownMenuItem<Gender>(
                      value: gender,
                      child: Text(genderToString(gender)),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    height: 65,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(40)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Дата рождения:',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd').format(_birthDay),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          _submitForm();
        },
        child: const Text('Далее'),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _birthDay,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _birthDay) {
      setState(() {
        _birthDay = picked;
      });
    }
  }

  String genderToString(Gender gender) {
    if (gender == Gender.male) {
      return 'Мужчина';
    } else {
      return 'Женщина';
    }
  }

  String? _validateName(String? value) {
    final nameExp = RegExp(r'^[A-za-z]+$');
    if (value!.isEmpty) {
      return 'Поле обязательно для ввода!';
    } else if (!nameExp.hasMatch(value)) {
      return 'Используйте только алфавит';
    } else {
      return null;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print('Фамилия ${_lastNameController.text}');
      print('Имя ${_firstNameController.text}');
    }
  }
}
