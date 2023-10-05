class CityModel {
  int? _id;
  String? _nome;

  CityModel.fromListIndex(List list, int i) {
    _id = list[i]['id'];
    _nome = list[i]['nome'];
  }
  int? get id => this._id;
  
  void set id(int? id) {
    this._id = id;
  }

  String? get nome => this._nome;
  void set nome(String? nome) {
    this._nome = nome;
  }
}
