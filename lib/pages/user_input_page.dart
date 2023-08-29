import 'package:flutter/material.dart';

class UserInputPage extends StatefulWidget {
  const UserInputPage({super.key});

  @override
  State<UserInputPage> createState() => _UserInputPageState();
}

class _UserInputPageState extends State<UserInputPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _secondNameController = TextEditingController();
  final _diagnosisNameController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _secondNameController.dispose();
    _diagnosisNameController.dispose();
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
                controller: _secondNameController,
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _secondNameController.clear();
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
        onPressed: () {},
        child: Text('Далее'),
      ),
    );
  }
}
