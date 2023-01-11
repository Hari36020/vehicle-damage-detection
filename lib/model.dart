class Mymodel {
  bool? drawResult;
  String? jobId;
  Output? output;
  String? outputUrl;
  String? urlExpiry;

  Mymodel(
      {this.drawResult,
        this.jobId,
        this.output,
        this.outputUrl,
        this.urlExpiry});

  Mymodel.fromJson(Map<String, dynamic> json) {
    drawResult = json['draw_result'];
    jobId = json['job_id'];
    output =
    json['output'] != null ? new Output.fromJson(json['output']) : null;
    outputUrl = json['output_url'];
    urlExpiry = json['url_expiry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['draw_result'] = this.drawResult;
    data['job_id'] = this.jobId;
    if (this.output != null) {
      data['output'] = this.output!.toJson();
    }
    data['output_url'] = this.outputUrl;
    data['url_expiry'] = this.urlExpiry;
    return data;
  }
}

class Output {
  List<Elements>? elements;

  Output({this.elements});

  Output.fromJson(Map<String, dynamic> json) {
    if (json['elements'] != null) {
      elements = <Elements>[];
      json['elements'].forEach((v) {
        elements!.add(new Elements.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.elements != null) {
      data['elements'] = this.elements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Elements {
  List<int>? bbox;
  String? damageCategory;
  List<int>? damageColor;
  String? damageId;
  String? damageLocation;
  double? score;

  Elements(
      {this.bbox,
        this.damageCategory,
        this.damageColor,
        this.damageId,
        this.damageLocation,
        this.score});

  Elements.fromJson(Map<String, dynamic> json) {
    bbox = json['bbox'].cast<int>();
    damageCategory = json['damage_category'];
    damageColor = json['damage_color'].cast<int>();
    damageId = json['damage_id'];
    damageLocation = json['damage_location'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bbox'] = this.bbox;
    data['damage_category'] = this.damageCategory;
    data['damage_color'] = this.damageColor;
    data['damage_id'] = this.damageId;
    data['damage_location'] = this.damageLocation;
    data['score'] = this.score;
    return data;
  }
}
