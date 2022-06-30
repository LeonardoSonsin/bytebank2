import 'package:aula_2_persistencia_de_dados/models/contato.dart';
import 'package:flutter/material.dart';

import '../database/dao/contato_dao.dart';

class FormularioContato extends StatefulWidget {
  const FormularioContato({Key? key}) : super(key: key);

  @override
  State<FormularioContato> createState() => _FormularioContatoState();
}

class _FormularioContatoState extends State<FormularioContato> {

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _numeroContaController = TextEditingController();
  final ContatoDao _dao = ContatoDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  TextField(
                    controller: _nomeController,
                    decoration: const InputDecoration(
                      labelText: 'Nome completo',
                    ),
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _numeroContaController,
                decoration: const InputDecoration(
                  labelText: 'Número da conta',
                ),
                style: const TextStyle(fontSize: 16.0),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                    onPressed: () {
                      final String nome = _nomeController.text;
                      final int? numeroConta = int.tryParse(_numeroContaController.text);
                      final Contato novoContato = Contato(0, nome, numeroConta!);
                      _dao.save(novoContato).then((id) => Navigator.pop(context));
                    },
                    child: const Text('CONFIRMAR')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
