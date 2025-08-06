class Meta {
  String nome;
  int metaDiaria;
  int acumulado;
  int feitoHoje;
  
  Meta({
    required this.nome,
    required this.metaDiaria,
    this.acumulado = 0,
    this.feitoHoje = 0,
  });

  int get totalDoDia => metaDiaria + acumulado;

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'metaDiaria': metaDiaria,
      'acumulado': acumulado,
      'feitoHoje': feitoHoje,
    };
  }

  static Meta fromMap(Map<String, dynamic> map) {
    return Meta(
      nome: map['nome'],
      metaDiaria: map['metaDiaria'],
      acumulado: map['acumulado'],
      feitoHoje: map['feitoHoje'] ?? 0,
    );
  }
}
