class UserModel {
  String? fname;
  String? lname;
  String? email;
  String? phone_no;

  UserModel({
    this.fname,
    this.lname,
    this.email,
    this.phone_no,
  });

  UserModel.fromMap(Map<String, dynamic> map) {
    fname = map['fname'];
    lname = map['lname'];
    email = map['email'];
    phone_no = map['phone_no'];
  }

  Map<String, dynamic> toMap() {
    return {
      'fname':fname,
      'lname':lname,
      'email':email,
      'phone_no':phone_no
    };
  }
}
