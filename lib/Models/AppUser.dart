class AppUser{
  String name,phone,email,password,profilePic,designation,id;

  AppUser({this.id, this.name, this.phone, this.email, this.password,
    this.profilePic, this.designation});

  Map<String,dynamic> toMap(){
    return {
      "id":id,
    "name":name,
      "phone":phone,
      "email":email,
      "password":profilePic,
      "designation":designation,
      "password":password

    };
  }
}