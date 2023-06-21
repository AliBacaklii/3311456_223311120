import 'package:fizansekerleme_k/pages/admin_page.dart';
import "package:flutter/material.dart";
import 'package:fizansekerleme_k/main.dart';
import 'package:fizansekerleme_k/utils/Seker.dart';
import 'package:fizansekerleme_k/service/db_utils.dart';
import 'kayitekrani.dart';


DbUtils utils = DbUtils();

class ListSekerler extends StatefulWidget {
  @override
  _ListSekerlerState createState() => _ListSekerlerState();
}

class _ListSekerlerState extends State<ListSekerler> {
  List<Seker> sekerList = [];

  void getData() async {
    await utils.sekerler().then((result) => {
      setState(() {
        sekerList = result;
      })
    });
    print(sekerList);
  }

  void showAlert(String alertTitle, String alertContent) {
    AlertDialog alertDialog;
    alertDialog =
        AlertDialog(title: Text(alertTitle), content: Text(alertContent));
    showDialog(context: context, builder: (_) => alertDialog);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(sekerList.length.toString() + " Sekerler listed")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: sekerList.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.lightBlueAccent,
                    elevation: 2.0,
                    child: ListTile(
                      leading: CircleAvatar(
                     //   backgroundImage: AssetImage("assets/urunler/akidenaneli.jpg"),
                        child: Text("A"),
                      ),
                      title: Text(sekerList[index].isim+" "+ sekerList[index].aciklama.toString()),
                      subtitle: Text(sekerList[index].fiyat.toString()),
                      onTap: (){print("tıklandı.");},

                    ),

                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminPage()),
                    );
                  },
                  child: Text("Return Homepage")),
            ),
          ],
        ),
      ),
    );
  }
}
