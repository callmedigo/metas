import 'package:flutter/material.dart';
import '../models/meta.dart';

class RemoverMetaModal {
  static Future<bool?> mostrar(BuildContext context, Meta meta) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remover meta'),
        content: Text('Deseja remover a meta "${meta.nome}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Remover', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
