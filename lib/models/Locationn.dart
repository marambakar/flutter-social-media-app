class Locationn {
  int _id;
  double _axis;
  double _yais;

  int get id => _id;
  double get axis => _axis;

  double get yais => _yais;

  Locationn({
    double axis,
    double yais,
  }) {
    _axis = axis;
    _yais = yais;
  }

  Locationn.fromJson(dynamic json) {
    _id = json["id"];
    _axis = json["axis"];
    _yais = json["yais"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["axis"] = _axis;
    map["yais"] = _yais;

    return map;
  }
}
