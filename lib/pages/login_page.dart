//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_ui/service/auth_service.dart';
import 'package:fizansekerleme_k/utils/customColors.dart';
import 'package:fizansekerleme_k/utils/customTextStyle.dart';
import 'package:fizansekerleme_k/widget/custom_text_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email, password;
  final formkey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;
//  final authService = AuthService();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    String topImage = "assets/topimage.png";
    return Scaffold(
      body: appBody(height, topImage),
    );
  }

  SingleChildScrollView appBody(double height, String topImage) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topImageContainer(height, topImage),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    titleText(),
                    customSizedBox(),
                    emailTextField(),
                    customSizedBox(),
                    passwordTextField(),
                    customSizedBox(),
                    forgotPasswordButton(),
                    customSizedBox(),
                    signInButton(),
                    customSizedBox(),
                    CustomTextButton(
                      onPressed: () => Navigator.pushNamed(context, "/signup"),
                      buttonText: "Hesap Olustur",
                    ),
                    CustomTextButton(
                        onPressed: () async {
                          final result = null;
                          if (result != null) {
                            Navigator.pushReplacementNamed(
                                context, "/homePage");
                          } else {
                            print("Hata ile karsilasildi");
                          }
                        },
                        buttonText: "Misafir Girisi")
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Text titleText() {
    return Text(
      "Merhaba, \nHosgeldin",
      style: CustomTextStyle.titleTextStyle,
    );
  }

  TextFormField emailTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri Eksiksiz Doldurunuz";
        } else {}
      },
      onSaved: (value) {
        email = value!;
      },
      style: TextStyle(color: Colors.white),
      decoration: customInputDecoration("Email"),
    );
  }

  TextFormField passwordTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri Eksiksiz Doldurunuz";
        } else {}
      },
      onSaved: (value) {
        password = value!;
      },
      obscureText: true,
      style: TextStyle(color: Colors.white),
      decoration: customInputDecoration("Sifre"),
    );
  }

  Center forgotPasswordButton() {
    return Center(
      child: TextButton(
        onPressed: () async {
          if (formkey.currentState!.validate()) {
            formkey.currentState!.save();
            try {
              final userResult = await firebaseAuth.sendPasswordResetEmail(email: email);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Şifreniz Gönderildi."),
                ),
              );
            } on FirebaseException
            catch(e) {if (e.code=="user-not-found") {
            ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Mail Adresi Bulunumadı."),
            ),
            );
            }
            else {}}
          } else {}
        },
        child: customText(
          "Sifremi Unuttum",
          CustomColors.textButtonColor,
        ),
      ),
    );
  }

  Center signInButton() {
    return Center(
      child: TextButton(
        onPressed: () async {
          if (formkey.currentState!.validate()){
            formkey.currentState!.save();
            try { final userResult= await firebaseAuth.signInWithEmailAndPassword(
                email: email, password: password);
              print("$email");
              if (email=="admin@fs.com") {
                Navigator.pushNamed(context, "/adminpage");
              }
              else {Navigator.pushNamed(context, "/listurunler");}
            print(userResult.user!.email);
          } on FirebaseException
            catch(e){if (e.code=="user-not-found") {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Mail Adresi Bulunumadı."),
                ),
              );
            }
            else if (e.code=="user-not-found") {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Mail Adresi Bulunumadı."),
                ),
              );
            }
            else {}} }else {}
        },
        child: Container(
          height: 50,
          width: 150,
          margin: EdgeInsets.symmetric(horizontal: 60),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color(0xff31274F)),
          child: Center(
            child: customText("Giris Yap", CustomColors.loginButtonTextColor),
          ),
        ),
      ),
    );
  }



  Center signUpButton() {
    return Center(
      child: TextButton(
        onPressed: () => Navigator.pushNamed(context, "/signUp"),
        child: customText(
          "Hesap Olustur",
          CustomColors.textButtonColor,
        ),
      ),
    );
  }

  Container topImageContainer(double height, String topImage) {
    return Container(
      height: height * .25,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(topImage),
        ),
      ),
    );
  }

  Widget customSizedBox() => SizedBox(
    height: 20,
  );

  Widget customText(String text, Color color) => Text(
    text,
    style: TextStyle(color: color),
  );

  InputDecoration customInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
    );
  }
}