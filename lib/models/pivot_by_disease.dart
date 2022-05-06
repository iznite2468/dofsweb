class PivotByDisease {
  int? i2017;
  int? i2018;
  int? i2019;
  int? i2020;
  int? i2021;
  int? i2022;
  int? weeks;

  PivotByDisease(
      {this.i2017,
      this.i2018,
      this.i2019,
      this.i2020,
      this.i2021,
      this.i2022,
      this.weeks});

  PivotByDisease.fromJson(Map<String, dynamic> json) {
    i2017 = json['2017'];
    i2018 = json['2018'];
    i2019 = json['2019'];
    i2020 = json['2020'];
    i2021 = json['2021'];
    i2022 = json['2022'];
    weeks = json['WEEKS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['2017'] = i2017;
    data['2018'] = i2018;
    data['2019'] = i2019;
    data['2020'] = i2020;
    data['2021'] = i2021;
    data['2022'] = i2022;
    data['WEEKS'] = weeks;
    return data;
  }

  static List<PivotByDisease> fromList(List<dynamic> data) {
    var list = <PivotByDisease>[];
    if (data.isEmpty) return list;

    for (var item in data) {
      list.add(PivotByDisease.fromJson(item));
    }

    return list;
  }
}
