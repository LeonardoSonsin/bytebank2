import 'package:aula_2_persistencia_de_dados/database/dao/contato_dao.dart';
import 'package:aula_2_persistencia_de_dados/models/contato.dart';
import 'package:aula_2_persistencia_de_dados/screens/formulario_contato.dart';
import 'package:flutter/material.dart';

class ListaContatos extends StatefulWidget {
  const ListaContatos({Key? key}) : super(key: key);

  @override
  State<ListaContatos> createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {
  final ContatoDao _dao = ContatoDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              AlertDialog alert = AlertDialog(
                title: const Text("Alerta!"),
                content:
                    const Text("Tem certeza que deseja apagar toda a lista?"),
                actions: [
                  TextButton(
                    child: const Text("Não"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text("Sim"),
                    onPressed: () {
                      _dao.delete();
                      setState(() {
                        Navigator.of(context).pop();
                      });
                    },
                  ),
                ],
              );
              // show the dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Contato>>(
        initialData: const [],
        future: _dao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                    Text('Loading')
                  ],
                ),
              );
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contato>? contatos = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contato contato = contatos![index];
                  return _ContatoItem(contato);
                },
                itemCount: contatos?.length,
              );
          }
          return const Text('Unknown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => const FormularioContato()))
              .then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ContatoItem extends StatefulWidget {
  const _ContatoItem(this.contato);

  final Contato contato;

  @override
  State<_ContatoItem> createState() => _ContatoItemState();
}

class _ContatoItemState extends State<_ContatoItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          widget.contato.nome,
          style: const TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          widget.contato.numeroConta.toString(),
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
