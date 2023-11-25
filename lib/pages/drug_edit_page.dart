import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:medication_compliance_assistant/bloc/drug_edit/drug_edit_bloc.dart';
import 'package:medication_compliance_assistant/models/drug.dart';

class DrugEditPage extends StatefulWidget {
  final Drug? drug;

  const DrugEditPage({super.key, this.drug});

  @override
  State<DrugEditPage> createState() => _DrugEditPageState();
}

class _DrugEditPageState extends State<DrugEditPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _doseController;
  late final TextEditingController _costController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.drug?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.drug?.description ?? '');
    _doseController = TextEditingController(text: widget.drug?.dose ?? '');
    _costController =
        TextEditingController(text: widget.drug?.cost.toString() ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _doseController.dispose();
    _costController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DrugEditBloc(GetIt.instance.get(), widget.drug),
      child: Builder(builder: (context) {
        return BlocListener<DrugEditBloc, DrugEditState>(
          listener: (context, state) {
            if (state is DrugSaveSuccess) {
              Navigator.of(context).pop(state.drug);
            } else if (state is DrugDeleteSuccess) {
              Navigator.of(context).pop(state.drugId);
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                widget.drug != null ? 'РЕДАКТИРОВАНИЕ' : 'ДОБАВЛЕНИЕ',
                style: const TextStyle(color: Colors.deepPurple),
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
                      TextFormField(
                        maxLength: 30,
                        controller: _nameController,
                        decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                _nameController.clear();
                              },
                              child: const Icon(
                                Icons.delete_outline,
                                color: Colors.deepPurple,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 2)),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                borderSide: BorderSide(
                                    color: Colors.deepPurple, width: 2)),
                            labelText: 'Название лекарства/процедуры',
                            hintText: 'Обязательное поле'),
                        validator: _validateData,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        maxLength: 30,
                        controller: _descriptionController,
                        decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                _descriptionController.clear();
                              },
                              child: const Icon(
                                Icons.delete_outline,
                                color: Colors.deepPurple,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 2)),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                borderSide: BorderSide(
                                    color: Colors.deepPurple, width: 2)),
                            labelText: 'Описание',
                            hintText: 'Обязательное поле'),
                        validator: _validateData,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        maxLength: 30,
                        controller: _doseController,
                        decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                _doseController.clear();
                              },
                              child: const Icon(
                                Icons.delete_outline,
                                color: Colors.deepPurple,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 2)),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                borderSide: BorderSide(
                                    color: Colors.deepPurple, width: 2)),
                            labelText: 'Дозировка или рекомендация',
                            hintText: 'Обязательное поле'),
                        validator: _validateData,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: _validateDataInt,
                        keyboardType: TextInputType.number,
                        maxLength: 40,
                        controller: _costController,
                        decoration: InputDecoration(
                            helperText: 'ПРИМЕР: 5000 руб.',
                            suffixIcon: GestureDetector(
                              onTap: () {
                                _costController.clear();
                              },
                              child: const Icon(
                                Icons.delete_outline,
                                color: Colors.deepPurple,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 2)),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                borderSide: BorderSide(
                                    color: Colors.deepPurple, width: 2)),
                            labelText: 'Введите цену товара/услуги',
                            hintText: 'Обязательное поле'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (widget.drug != null)
                        TextButton(
                          child: const Text(
                            'УДАЛЕНИЕ ЛЕКАРСТВА/ПРОЦЕДУРЫ',
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 18,
                            ),
                          ),
                          onPressed: () async {
                            final confirm = await _confirmDeleteDialog(context);
                            if (confirm != null && confirm) {
                              _onDelete(context, widget.drug!.id);
                            }
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: ElevatedButton(
              onPressed: () {
                _submitForm();
                if (_nameController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty &&
                    _doseController.text.isNotEmpty &&
                    _costController.text.isNotEmpty) {
                  BlocProvider.of<DrugEditBloc>(context).add(
                    DrugSavePressed(
                        name: _nameController.text,
                        description: _descriptionController.text,
                        dose: _doseController.text,
                        cost: int.tryParse(_costController.text) ?? 0),
                  );
                }
              },
              child: Text(widget.drug != null ? 'Сохранить' : 'Добавить'),
            ),
          ),
        );
      }),
    );
  }

  String? _validateData(String? value) {
    final nameExp = RegExp(r'^[A-za-zА-яа-я0-9\s]+$');
    if (value!.isEmpty) {
      return 'Поле обязательно для ввода!';
    } else if (!nameExp.hasMatch(value)) {
      return 'Используйте только алфавит';
    } else {
      return null;
    }
  }

  String? _validateDataInt(String? value) {
    final nameExp = RegExp('[0-9]');
    if (value!.isEmpty) {
      return 'Поле обязательно для ввода!';
    } else if (!nameExp.hasMatch(value)) {
      return 'Используйте только цифры';
    } else {
      return null;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      debugPrint('Описание ${_descriptionController.text}');
      debugPrint('Название ${_nameController.text}');
    }
  }

  void _onDelete(BuildContext context, String id) {
    BlocProvider.of<DrugEditBloc>(context).add(DrugDeleteRequested(id));
  }

  Future<bool?> _confirmDeleteDialog(BuildContext context) {
    return showDialog<bool?>(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: const Text('УДАЛИТЬ ЛЕКАРСТВО?'),
        backgroundColor: Colors.white,
        actions: [
          MaterialButton(
            shape: const StadiumBorder(),
            color: Colors.red,
            onPressed: () {
              Navigator.pop(dialogContext, true);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Удалить',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
          ),
          MaterialButton(
            shape: const StadiumBorder(),
            color: Colors.green,
            onPressed: () {
              Navigator.pop(dialogContext, false);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Отмена',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
