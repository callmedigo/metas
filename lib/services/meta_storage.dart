import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/meta.dart';

class MetaStorage {
  static const _key = 'metas';

  static Future<List<Meta>> carregarMetas() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((e) => Meta.fromMap(e)).toList();
    } else {
      return [
        Meta(nome: 'Flexões', metaDiaria: 10, acumulado: 10),
        Meta(nome: 'Abdominais', metaDiaria: 10, acumulado: 10),
        Meta(nome: 'Prancha (min)', metaDiaria: 2, acumulado: 2),
      ];
    }
  }

  static Future<void> salvarMetas(List<Meta> metas) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = metas.map((meta) => meta.toMap()).toList();
    await prefs.setString(_key, json.encode(jsonList));
  }
}
