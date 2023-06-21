import 'package:fizansekerleme_k/pages/urunler.dart';
import "package:flutter/material.dart";
import 'package:fizansekerleme_k/pages/list_sekerler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fizansekerleme_k/utils/Seker.dart';
import '../service/db_utils.dart';
import 'app_notes.dart';


DbUtils utils = DbUtils();

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController sekerIdController = TextEditingController();
  TextEditingController sekerIsimController = TextEditingController();
  TextEditingController sekerAciklamaController = TextEditingController();
  TextEditingController sekerFiyatController = TextEditingController();

  late Future<Database> database;

  List<Seker> sekerList = [];

  _onPressedUpdate() async {
    final tatli = Seker(
      id: int.parse(sekerIdController.text),
      isim: sekerIsimController.text,
      aciklama: sekerAciklamaController.text,
      fiyat: int.parse(sekerFiyatController.text),
    );
    utils.updateSeker(tatli);
    sekerList = await utils.sekerler();
    //print(dogList);
    getData();
  }

  _onPressedAdd() async {
    final tatli = Seker(
      id: int.parse(sekerIdController.text),
      isim: sekerIsimController.text,
      aciklama: sekerAciklamaController.text,
      fiyat: int.parse(sekerFiyatController.text),
    );

    utils.insertSeker(tatli);
    sekerList = await utils.sekerler();
    getData();
  }


  _deleteSekerTable() {
    utils.deleteTable();
    sekerList = [];
    getData();
  }

  void getData() async {
    await utils.sekerler().then((result) => {
      setState(() {
        sekerList = result;
      })
    });
    print(sekerList);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Ürün İşlemleri")
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: sekerIdController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Barkod'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: sekerIsimController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'İsim'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: sekerAciklamaController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Açıklama'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: sekerFiyatController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Fiyat'
                  ),
                ),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.purple),
                  ),
                    onPressed: _onPressedAdd, child: Text("Ekle", style: TextStyle(
                  color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20,))),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.purple),
                  ),
                onLongPress:() async {
                  await utils.deleteSeker(int.parse(sekerIdController.text)).then((value) => {
                  });
                  getData();
                }, onPressed: () {  },
                child: Text("Sil", style: TextStyle(
                color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20,))),
            ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.purple),
                    ),
                    onLongPress: _onPressedUpdate, onPressed: () {  },
                    child: Text("Güncelle", style: TextStyle(
                  color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20,))),
              ),
            ],
        ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.purple),
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DosyaIslemleri(kayitislemi: KayitIslemleri(),)),
                      );
                    },
                    child: const Text("Uygulama Notları", style: TextStyle(
                      color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20,))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.purple),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListUrunler()),
                      );
                    },
                    child: Text("Ürünler", style: TextStyle(
                      color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20,),) ),
              ),
              ],
        ),
              Text(sekerList.length.toString()),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: sekerList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(sekerList[index].id.toString() +" "+ sekerList[index].isim+" "+sekerList[index].fiyat.toString()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
