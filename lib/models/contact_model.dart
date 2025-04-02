class ContactModel {
  late String id;
  late String name;
  late String tel;

  ContactModel({
    this.id = "",
    required this.name,
    required this.tel,
  });

  ContactModel.fromJson(Map json) {
    id = json["id"];
    name = json["name"];
    tel = json["tel"];
  }

  Map toJson() {
    Map json = {};
    json["id"] = id;
    json["name"] = name;
    json["tel"] = tel;
    return json;
  }
}
