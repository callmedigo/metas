import 'package:flutter/material.dart';
import '../models/meta.dart';

class AdicionarMetaModal extends StatefulWidget {
  final Function(Meta) onMetaAdicionada;

  const AdicionarMetaModal({Key? key, required this.onMetaAdicionada}) : super(key: key);

  @override
  _AdicionarMetaModalState createState() => _AdicionarMetaModalState();
}

class _AdicionarMetaModalState extends State<AdicionarMetaModal> {
  final _nomeController = TextEditingController();
  final _metaController = TextEditingController();

  void _salvar() {
    final nome = _nomeController.text.trim();
    final diaria = int.tryParse(_metaController.text);
    if (nome.isEmpty || diaria == null || diaria < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Informe um nome e meta válida (>=1)')),
      );
      return;
    }

    final novaMeta = Meta(nome: nome, metaDiaria: diaria, acumulado: diaria);
    widget.onMetaAdicionada(novaMeta);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Adicionar nova meta'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nomeController,
            decoration: InputDecoration(labelText: 'Nome do exercício'),
          ),
          TextField(
            controller: _metaController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Meta diária'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: _salvar,
          child: Text('Adicionar'),
        ),
      ],
    );
  }
}
