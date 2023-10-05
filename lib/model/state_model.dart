class StateModel {
  String? _nome;
  String? _sigla;

  StateModel.fromListIndex(List list, int i) {
    _nome = list[i]["nome"];
    _sigla = list[i]["sigla"];
  }

  String? get nome => this._nome;
  String? get sigla => this._sigla;
  void set nome(String? nome) {
    this._nome = nome;
  }

  void set sigla(String? sigla) {
    this._sigla = sigla;
  }
}
