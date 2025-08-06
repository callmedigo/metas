import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/meta.dart';
import '../services/meta_storage.dart';
import '../widgets/adicionar_meta.dart';
import '../widgets/editar_meta.dart';
import '../widgets/remover_meta.dart';

class MetasPage extends StatefulWidget {
  const MetasPage({super.key});
  @override
  State<MetasPage> createState() => _MetasPageState();
}

class _MetasPageState extends State<MetasPage> {
  List<Meta> metas = [];

  @override
  void initState() {
    super.initState();
    carregarMetas();
  }


  Future<void> carregarMetas() async {
    metas = await MetaStorage.carregarMetas();
    if (metas.isEmpty) {
      metas = [
        Meta(nome: 'Flexões', metaDiaria: 10, acumulado: 10),
        Meta(nome: 'Abdominais', metaDiaria: 10, acumulado: 10),
        Meta(nome: 'Prancha (min)', metaDiaria: 2, acumulado: 2),
      ];
    }

    final prefs = await SharedPreferences.getInstance();
    final hojeStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final ultimaDataStr = prefs.getString('ultima_data_reset') ?? '';

    if (ultimaDataStr != hojeStr) {
      _resetDiario();
      await prefs.setString('ultima_data_reset', hojeStr);
    }

    setState(() {});
  }

  void _resetDiario() {
    setState(() {
      for (var meta in metas) {
        int pendente = meta.metaDiaria - meta.feitoHoje;
        if (pendente > 0) {
          meta.acumulado += pendente;
        }
        meta.feitoHoje = 0;
      }
    });
    _salvarMetas();
  }

  Future<void> _salvarMetas() async {
    await MetaStorage.salvarMetas(metas);
  }

  void registrarFeito(Meta meta) async {
    final controller = TextEditingController(text: '');
    final feito = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Registrar "${meta.nome}"'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Quantos você fez hoje?',
            labelText: 'Quantidade realizada',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, int.tryParse(controller.text) ?? 0),
            child: Text('Salvar'),
          ),
        ],
      ),
    );

    if (feito != null && feito > 0) {
      setState(() {
        meta.feitoHoje += feito;
        meta.acumulado -= feito;
        if (meta.acumulado < 0) meta.acumulado = 0;
      });
      await _salvarMetas();
    }
  }

  void abrirModalCustomizacao() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(builder: (context, setModalState) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                children: [
                  Text(
                    'Personalizar Metas',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Expanded(
                    child: metas.isEmpty
                        ? Center(child: Text('Nenhuma meta definida'))
                        : ListView.builder(
                            itemCount: metas.length,
                            itemBuilder: (context, index) {
                              final meta = metas[index];
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 6),
                                child: ListTile(
                                  title: Text(meta.nome),
                                  subtitle: Text('Meta diária: ${meta.metaDiaria}'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit, color: Colors.blue),
                                        onPressed: () {
                                          _abrirModalEditar(meta, setModalState);
                                        },
                                        tooltip: 'Editar',
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete, color: Colors.red),
                                        onPressed: () async {
                                          await _removerMeta(meta, setModalState);
                                        },
                                        tooltip: 'Remover',
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _abrirModalAdicionar(setModalState);
                    },
                    icon: Icon(Icons.add),
                    label: Text('Adicionar nova meta'),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  void _abrirModalAdicionar(void Function(void Function()) setModalState) {
    showDialog(
      context: context,
      builder: (context) => AdicionarMetaModal(
        onMetaAdicionada: (metaNova) {
          setState(() {
            metas.add(metaNova);
          });
          _salvarMetas();
          setModalState(() {}); // Atualiza o BottomSheet
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Nova meta adicionada!')),
          );
        },
      ),
    );
  }

  void _abrirModalEditar(Meta meta, void Function(void Function()) setModalState) {
    showDialog(
      context: context,
      builder: (context) => EditarMetaModal(
        meta: meta,
        onMetaEditada: (metaEditada) {
          setState(() {});
          _salvarMetas();
          setModalState(() {}); // Atualiza o BottomSheet
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Meta editada com sucesso!')),
          );
        },
      ),
    );
  }

  Future<void> _removerMeta(Meta meta, void Function(void Function()) setModalState) async {
    final confirmou = await RemoverMetaModal.mostrar(context, meta);
    if (confirmou == true) {
      setState(() {
        metas.remove(meta);
      });
      await _salvarMetas();
      setModalState(() {}); // Atualiza o BottomSheet
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Meta removida com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [
          IconButton(
            icon: Icon(Icons.bar_chart),
            onPressed: () {
              // Relatório será implementado depois
            },
          ),
        ],
      ),
      body: metas.isEmpty
          ? Center(child: Text('Nenhuma meta definida.'))
          : ListView.builder(
              itemCount: metas.length,
              itemBuilder: (context, index) {
                final meta = metas[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(meta.nome, style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Meta: ${meta.metaDiaria}', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 6),
                        Text('Precisa fazer hoje: ${meta.acumulado}'),
                        Text('Feito hoje: ${meta.feitoHoje}'),
                        SizedBox(height: 6),
                      ],
                    ),
                    trailing: ElevatedButton.icon(
                      onPressed: () => registrarFeito(meta),
                      icon: Icon(Icons.check),
                      label: Text('Registrar feito'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: abrirModalCustomizacao,
        child: Icon(Icons.settings),
        tooltip: 'Customizar Metas',
      ),
    );
  }
}