class UserInfoModel {
  int id;
  String fName;
  String lName;
  String email;
  String image;
  String phone;
  String password;
  int orderCount;
  int memberSinceDays;
  double walletBalance;
  int loyaltyPoint;

  UserInfoModel(
      {this.id,
      this.fName,
      this.lName,
      this.email,
      this.image,
      this.phone,
      this.password,
      this.orderCount,
      this.memberSinceDays,
      this.walletBalance,
      this.loyaltyPoint});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    email = json['email'];
    image = json['image'];
    phone = json['phone'];
    password = json['password'];
    orderCount = json['order_count'];
    memberSinceDays = json['member_since_days'];
    walletBalance = json['wallet_balance']?.toDouble() ?? 0;
    loyaltyPoint = json['loyalty_point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['email'] = this.email;
    data['image'] = this.image;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['order_count'] = this.orderCount;
    data['member_since_days'] = this.memberSinceDays;
    data['wallet_balance'] = this.walletBalance;
    data['loyalty_point'] = this.loyaltyPoint;
    return data;
  }
}
