class Sonnet {
  String title;
  List<String> lines;
  Sonnet({this.title, this.lines});
  Sonnet.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    lines = json['lines'].cast<String>();
  }
  Map<String, dynamic> toJson() {
    final data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['lines'] = this.lines;
    return data;
  }
}