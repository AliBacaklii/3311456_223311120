import 'package:flutter/material.dart';

class KayitEkrani extends StatefulWidget {
  @override
  State<KayitEkrani> createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani> {
  late String email, parola;
  var _formAnahtari = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kullanıcı Kayıt Ekranı"),
        centerTitle: true,
      ),
      body: Form(
        key: _formAnahtari,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                onChanged: (alinanMail) {
                  setState(() {
                    email = alinanMail;
                  });
                },
                validator: (alinanMail) {
                  return alinanMail!.contains("@")
                      ? null
                      : "Geçerli bir mail adresi giriniz.";
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email Adresi Giriniz",
                  hintText: "Lütfen geçerli bir email adresi giriniz.",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.all(12.0),),
            Container(),
            GestureDetector()
          ],
        ),
      ),
    );
  }
}
