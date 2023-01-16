class SocialLogInBody {
  String email;
  String token;
  String uniqueId;
  String medium;
  String phone;
  String image;
  String id;

  SocialLogInBody(
      {this.email, this.token, this.uniqueId, this.medium, this.phone,
      this.image,
      this.id});

  SocialLogInBody.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    token = json['token'];
    id = json['id'];
    uniqueId = json['unique_id'];
    medium = json['medium'];
    phone = json['phone'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['token'] = this.token;
    data['unique_id'] = this.uniqueId;
    data['medium'] = this.medium;
    data['phone'] = this.phone;
    return data;
  }
}
