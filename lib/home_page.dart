import 'package:flutter/material.dart';
import 'package:notlar_uygulamasi/notes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/notes_app.png"),
          fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 100.0),
              child: Text("Notlar Uygulamasına Hoşgeldiniz. Bu uygulamayla SQLİTE veritabanını kullanarak notlarınızın kaydını tutabilirsiniz, kayıtlarınızda değişiklikler yapabilir, ekleme ve silme işlemleri gerçekleştirebilirsiniz",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black)),
               ),
               SizedBox(
                height: 100,
               ),
                 MaterialButton(
                  height: 50,
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NotesPage())),
                   color: Colors.yellow.shade100,
                   child: Text("BAŞLA", style: TextStyle(color: Colors.black, fontSize: 20),),
                   minWidth: 200,
                           ),
        ]),
      ),
    );
  }
}