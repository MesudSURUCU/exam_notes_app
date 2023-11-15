import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notlar_uygulamasi/NotDetaySayfa.dart';
import 'package:notlar_uygulamasi/NotKayitSayfa.dart';
import 'package:notlar_uygulamasi/Notlar.dart';
import 'package:notlar_uygulamasi/Notlardao.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {
  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  Future<List<Notlar>> tumNotlarGoster() async {
    var notlarListesi = await Notlardao().tumNotlar();

    return notlarListesi;
  }

  Future<bool> uygulamayiKapat() async {
    await exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            uygulamayiKapat();
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Notlar Uygulaması',
                  style: TextStyle(color: Colors.black, fontSize: 20)),
              FutureBuilder<List<Notlar>>(
                  future: tumNotlarGoster(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var notlarListesi = snapshot.data;
                      double ortalama = 0.0;
                      if (!notlarListesi!.isEmpty) {
                        double toplam = 0.0;
                        for (var n in notlarListesi) {
                          toplam = toplam + (n.not1 + n.not2) / 2;
                        }
                        ortalama = toplam / notlarListesi.length;
                      }
                      return Text('Ortalama : ${ortalama.toInt()}',
                          style: TextStyle(color: Colors.black, fontSize: 16));
                    } else {
                      return Text(
                        'Ortalama : 0',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: uygulamayiKapat,
        child: FutureBuilder<List<Notlar>>(
          future: tumNotlarGoster(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var notlarListesi = snapshot.data;
              return ListView.builder(
                itemCount: notlarListesi!.length,
                itemBuilder: (context, indeks) {
                  var not = notlarListesi[indeks];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotDetaySayfa(not: not)));
                    },
                    child: Card(
                      child: SizedBox(
                        height: 50,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                not.ders_adi,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text((not.not1).toString()),
                              Text((not.not2).toString()),
                            ]),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NotKayitSayfa()));
        },
        tooltip: 'Not Ekle',
        child: const Icon(Icons.add),
      ),
    );
  }
}
