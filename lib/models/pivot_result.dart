class PivotResult {
  String? quarter;
  int? dengue;
  int? rabies;
  int? tuberculosis;

  PivotResult({this.quarter, this.dengue, this.rabies, this.tuberculosis});

  PivotResult.fromJson(Map<String, dynamic> json) {
    quarter = json['QUARTER'];
    dengue = json['Dengue'];
    rabies = json['Rabies'];
    tuberculosis = json['Tuberculosis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['QUARTER'] = quarter;
    data['Dengue'] = dengue;
    data['Rabies'] = rabies;
    data['Tuberculosis'] = tuberculosis;
    return data;
  }

  static List<PivotResult> fromList(List<dynamic> data) {
    var list = <PivotResult>[];
    if (data.isEmpty) return list;

    for (var item in data) {
      list.add(PivotResult.fromJson(item));
    }

    return list;
  }
}
