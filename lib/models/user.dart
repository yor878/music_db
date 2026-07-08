class UserModel{

String name;
String email;
String password;

UserModel({
required this.name,
required this.email,
required this.password,
});

}

List<UserModel> users=[

UserModel(
name:"Administrador",
email:"admin@gmail.com",
password:"123456"
)

];
