class records {
  late String name;
  late String email;
  String? atoken;
  String? idtoken;
  String? picurl;
  late String uid;

  records(
      {required this.name,required
      this.email,
      this.atoken,
      this.idtoken,
      this.picurl,required
      this.uid});

  records.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['Email'];
    atoken = json['atoken'];
    idtoken = json['idtoken'];
    picurl = json['picurl'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['Email'] = this.email;
    data['atoken'] = this.atoken;
    data['idtoken'] = this.idtoken;
    data['picurl'] = this.picurl;
    data['uid'] = this.uid;
    return data;
  }
}