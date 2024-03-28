class CommonModel {
  late String id;
  late String name;
  late String date;


  CommonModel({
    this.id = "",
    this.name = "",
    this.date = ""


  });

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
      id:json['id'].toString(),
      name:json['name'].toString(),
      date:json['date'].toString(),
    );
  }
}