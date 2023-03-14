class UserModel {
  bool isLogin = false ;

  String id;
  String name;
  String email;
  String pass;
  UserModel(this.id,this.name,this.email,this.pass,{this.isLogin = false});
}
