class Barangay {
  int? barangayId;
  String? barangayName;
  int? population;

  Barangay({this.barangayId, this.barangayName, this.population});

  Barangay.fromJson(Map<String, dynamic> json) {
    barangayId = json['barangay_id'];
    barangayName = json['barangay_name'];
    population = json['population'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['barangay_id'] = barangayId;
    data['barangay_name'] = barangayName;
    data['population'] = population;
    return data;
  }

  static List<Barangay> fromList(List<dynamic> data) {
    var list = <Barangay>[];
    if (data.isEmpty) return list;

    for (var item in data) {
      list.add(Barangay.fromJson(item));
    }

    return list;
  }
}
