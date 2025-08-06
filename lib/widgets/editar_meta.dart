import 'package:flutter/material.dart';
import '../models/meta.dart';

class EditarMetaModal extends StatefulWidget {
  final Meta meta;
  final Function(Meta) onMetaEditada;

  const EditarMetaModal({Key? key, required this.meta, required this.onMetaEditada}) : super(key: key);

  @override
  _EditarMetaModalState createState() => _EditarMetaModalState();
}

class _EditarMetaModalState extends State<EditarMetaModal> {
  late TextEditingController _nomeController;
  late TextEditingController _metaController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.meta.nome);
    _metaController = TextEditingController(text: widget.meta.metaDiaria.toString());
  }

  void _salvar() {
    final nome = _nomeController.text.trim();
    final diaria = int.tryParse(_metaController.text);
    if (nome.isEmpty || diaria == null || diaria < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Informe um nome e meta válida (>=1)')),
      );
      return;
    }

    final metaEditada = widget.meta;
    metaEditada.nome = nome;
    metaEditada.metaDiaria = diaria;
    widget.onMetaEditada(metaEditada);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar meta'),
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
          child: Text('Salvar'),
        ),
      ],
    );
  }
}
