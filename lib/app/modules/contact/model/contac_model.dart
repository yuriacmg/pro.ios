// ignore_for_file: sort_constructors_first, prefer_collection_literals, avoid_dynamic_calls, lines_longer_than_80_chars, inference_failure_on_untyped_parameter

class ContactDataModel {
  bool? isExpanded;
  String? title;
  List<Data>? data;

  ContactDataModel({this.isExpanded, this.title, this.data});

  ContactDataModel.fromJson(Map<String, dynamic> json) {
    isExpanded = json['isExpanded'].toString().toLowerCase() == 'true';
    title = json['title'].toString();
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['isExpanded'] = isExpanded;
    data['title'] = title;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? icon;
  String? title;
  String? description;
  String? url;

  Data({this.icon, this.title, this.description, this.url});

  Data.fromJson(Map<String, dynamic> json) {
    icon = json['icon'].toString();
    title = json['title'].toString();
    description = json['description'].toString();
    url = json['url'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['icon'] = icon;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    return data;
  }
}
