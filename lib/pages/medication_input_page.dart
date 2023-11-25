import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:medication_compliance_assistant/bloc/medication/medication_bloc.dart';
import 'package:medication_compliance_assistant/models/drug.dart';
import 'package:medication_compliance_assistant/models/medication.dart';
import 'package:medication_compliance_assistant/models/patient.dart';
import 'package:medication_compliance_assistant/pages/drug_edit_page.dart';

class MedicationInputPage extends StatefulWidget {
  final Patient patient;
  final Medication? medication;

  const MedicationInputPage({
    Key? key,
    required this.patient,
    this.medication,
  }) : super(key: key);

  @override
  State<MedicationInputPage> createState() => _MedicationInputPageState();
}

class _MedicationInputPageState extends State<MedicationInputPage> {
  String? _diagnosisText;
  late TextEditingController _diagnosisController;

  var _selectedDrugs = <Drug>[];

  @override
  void initState() {
    super.initState();
    _diagnosisText = widget.medication?.diagnosis;
    _selectedDrugs = widget.medication?.medicalSupplies ?? [];
    _diagnosisController = TextEditingController();
    _diagnosisController.text = _diagnosisText ?? '';
  }

  @override
  void dispose() {
    _diagnosisController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double itemSize = 80;
    final patient = widget.patient;
    return BlocProvider(
      create: (context) => MedicationBloc(
        drugsProvider: GetIt.instance.get(),
        medicationProvider: GetIt.instance.get(),
        input: widget.medication,
      )..add(DrugPageShown()),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.green),
                    child: IconButton(
                      onPressed: () {
                        BlocProvider.of<MedicationBloc>(context).add(
                          MedicationSavePressed(
                            diagnosis: _diagnosisText ?? '',
                            patient: widget.patient,
                            medicalSupplies: _selectedDrugs,
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.done,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            centerTitle: true,
            title: Text(
              '$patient',
            ),
          ),
          body: BlocConsumer<MedicationBloc, MedicationState>(
            listener: (context, state) {
              if (state is MedicationSaveSuccess) {
                Navigator.pop(context, state.medication);
              }
            },
            builder: (context, state) {
              if (state is MedicationDrugLoadSuccess) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            'ПЛАН ЛЕЧЕНИЯ',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              width: 2.0,
                              color: Colors.green,
                            ),
                          ),
                          child: Center(
                            child: TextButton(
                              child: _diagnosisText != null
                                  ? Text(
                                      _diagnosisText!,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        color: Colors.black,
                                      ),
                                    )
                                  : const Text(
                                      'Введите диагноз',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey,
                                      ),
                                    ),
                              onPressed: () {
                                _inputDiagnosis(context);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (_selectedDrugs.isNotEmpty)
                          SizedBox(
                            key: ValueKey(_selectedDrugs),
                            height: itemSize * _selectedDrugs.length,
                            child: ListView.builder(
                              itemCount: _selectedDrugs.length,
                              itemBuilder: (context, index) {
                                final drugs = _selectedDrugs[index];
                                return GestureDetector(
                                  onTap: () {
                                    _navigateToDrug(context, drugs);
                                  },
                                  child: ListTile(
                                    title: Text(drugs.name),
                                    subtitle: Text(drugs.description),
                                    leading: Container(
                                      padding: const EdgeInsets.all(5),
                                      width: 100,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Center(
                                        child: Text(
                                          _selectedDrugs[index].dose.toString(),
                                          style: const TextStyle(fontSize: 16),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    trailing: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: IconButton(
                                        icon: const Icon(Icons.clear),
                                        onPressed: () {
                                          setState(() {
                                            _selectedDrugs.remove(drugs);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.green[100],
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Выберите лекарство/процедуру',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black38,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  _showDrugDialog(context, state.drugList);
                                },
                              ),
                              IconButton(
                                iconSize: 64,
                                color: Colors.green[100],
                                onPressed: () {
                                  _navigateToDrug(context);
                                },
                                icon: const Icon(Icons.add_circle_rounded),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        );
      }),
    );
  }

  void _inputDiagnosis(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.white,
        child: SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  maxLength: 40,
                  controller: _diagnosisController,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _diagnosisController.clear();
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      borderSide: BorderSide(color: Colors.black26, width: 2),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2),
                    ),
                    labelText: 'Введите диагноз пациента)',
                    hintText: 'Диагноз пациента',
                  ),
                ),
                MaterialButton(
                  shape: const StadiumBorder(),
                  color: Colors.green,
                  onPressed: () {
                    setState(() {
                      _diagnosisText = _diagnosisController.text;
                    });
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Добавить',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDrugDialog(BuildContext context, List<Drug> drugList) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: ListView.builder(
          itemCount: drugList.length,
          itemBuilder: (context, index) {
            final drug = drugList[index];
            return GestureDetector(
              child: ListTile(
                title: Text(drug.name),
                subtitle: Text(drug.description),
              ),
              onTap: () {
                setState(
                  () {
                    if (!_selectedDrugs.contains(drug)) {
                      _selectedDrugs.add(drug);
                    }
                    Navigator.pop(context);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _navigateToDrug(BuildContext context, [Drug? drug]) async {
    final res = await Navigator.push<Object?>(
      context,
      MaterialPageRoute(
        builder: (context) => DrugEditPage(
          drug: drug,
        ),
      ),
    );
    if (res != null) {
      final bloc = BlocProvider.of<MedicationBloc>(context);
      if (res is Drug) {
        print(res);
        final bool isChanged = drug != null;
        if (isChanged) {
          final index = _selectedDrugs.indexWhere((el) => el.id == res.id);
          _selectedDrugs[index] = res;
        } else {
          _selectedDrugs.add(res);
        }
        print(_selectedDrugs);

        bloc.add(
          isChanged ? DrugChangePressed(res) : DrugAddPressed(drug: res),
        );
      } else if (res is String) {
        _selectedDrugs.removeWhere((el) => res == el.id);
        bloc.add(DrugRefresh());
      }
    }
  }
}
