import 'package:fizansekerleme_k/pages/admin_page.dart';
import "package:flutter/material.dart";
import 'package:fizansekerleme_k/main.dart';
import 'package:fizansekerleme_k/utils/Seker.dart';
import 'package:fizansekerleme_k/service/db_utils.dart';
import 'kayitekrani.dart';


DbUtils utils = DbUtils();

class ListUrunler extends StatefulWidget {
  @override
  _ListUrunlerState createState() => _ListUrunlerState();
}

class _ListUrunlerState extends State<ListUrunler> {
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
      appBar: AppBar(title: Text("ÜRÜNLER",style: TextStyle(fontWeight: FontWeight.bold),),
      backgroundColor: Color(0xff21254A),
      ),
      body: SingleChildScrollView(
        child: Container(
        constraints: BoxConstraints.expand(
          height: 900,
    ),
          color: Color(0xff21254A),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: sekerList.length,
                  itemBuilder: (context, index) {
                    return
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                              child:
                                Image.asset("assets/images/akidenaneli.jpg"),
                                width: 100,
                                height: 150,
                              ),
                              Column(
                                children: [
                                  Container(
                                    child: Text(sekerList[index].isim,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.white),),
                                    alignment: Alignment.bottomCenter,
                                    width: 250,
                                    height: 50,
                                  ),
                                  Container(
                                    child: Expanded( child:Text(sekerList[index].aciklama,style: TextStyle(fontSize: 16,color: Colors.white),),),
                                    alignment: Alignment.center,
                                    width: 250,
                                    height: 50,
                                  ),
                                  Container(
                                    child: Text(sekerList[index].fiyat.toString()+"  TL",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold, color: Colors.red),),
                                    alignment: Alignment.topCenter,
                                    width: 250,
                                    height: 50,
                                  ),
                                ],
                              ),
                              Container(
                                child:
                                Image.asset("assets/images/sepeteekle.png"),
                                width: 40,
                                height: 150,
                              ),
                            ],

                          ),
                         Container(child: SizedBox(height: 3,), color: Colors.white,),
                        ],
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
                    child: Text("Sepete Git",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.transparent),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
