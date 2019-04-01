class Sonnet {
  String title;
  List<String> lines;
  Sonnet({this.lines});
  Sonnet.fromJson(Map<String, dynamic> json) {
    lines = json['lines'].cast<String>();
  }
  Map<String, dynamic> toJson() {
    final data = new Map<String, dynamic>();
    data['lines'] = this.lines;
    return data;
  }
}
