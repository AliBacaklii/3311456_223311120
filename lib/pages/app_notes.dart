import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


class KayitIslemleri {
  Future<String> get dosyaYolu async {
    final konum = await getApplicationDocumentsDirectory();
    return konum.path;
  }

  Future<File> get yerelDosya async {
    final yol = await dosyaYolu;
    return File("$yol/yenidosya.txt");
  }

  Future<String> dosyaOku() async {
    try {
      final dosya = await yerelDosya;
      String icerik = await dosya.readAsString();
      return icerik;
    } catch (h) {
      return "Dosya Okunurken Hata oluştu:$h";
    }
  }

  Future<File> dosyaYaz(String gIcerik) async {
    final dosya = await yerelDosya;
    return dosya.writeAsString("$gIcerik");
  }
}

class DosyaIslemleri extends StatefulWidget {
  final KayitIslemleri kayitislemi;

  const DosyaIslemleri({Key? key, required this.kayitislemi}): super(key: key);

  @override
  State<DosyaIslemleri> createState() => _DosyaIslemleriState();
}

class _DosyaIslemleriState extends State<DosyaIslemleri> {
  final yaziControl = TextEditingController();
  String veri = "";
  Future<File> veriKaydet() async {
    setState(() {
      veri = yaziControl.text;
      print("Kaydedildi");
    });
    return widget.kayitislemi.dosyaYaz(veri);
  }

  @override
  void initState() {
    super.initState();
    widget.kayitislemi.dosyaOku().then((String deger) {
      setState(() {
        veri = deger;
      });
    });
  }

  void veriOku() {
    widget.kayitislemi.dosyaOku().then((String deger) {
      setState(() {
        veri = deger;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dosya İşlemleri"),
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: "Notunuzu Yazınız"),
              controller: yaziControl,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: TextButton(
                      onPressed: veriKaydet,
                      style: ButtonStyle(),
                      child: Text(
                        "Kaydet",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: TextButton(
                      onPressed: veriOku,
                      style: ButtonStyle(),
                      child: Text(
                        "Oku",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(child: Padding(
              padding: EdgeInsets.all(15),
              child: Text("$veri"),
            ),),
          ],
        ),
      ),
    );
  }
}
