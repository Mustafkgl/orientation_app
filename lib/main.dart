import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'tasks_page.dart'; // Görevler sayfasını ekliyoruz

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atlas Üniversitesi Oryantasyon Programı',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool startOrientation = false;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atlas Üniversitesi Oryantasyon Programı'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!startOrientation)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      startOrientation = true;
                    });
                  },
                  child: Text('Oryantasyona Başla'),
                ),
              if (startOrientation) ...[
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Öğrenci numaranızı Giriniz',
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    String studentNumber = _controller.text;
                    if (await validateStudentNumber(studentNumber)) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TasksPage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Geçersiz öğrenci numarası'),
                        ),
                      );
                    }
                  },
                  child: Text('Başla'),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> validateStudentNumber(String studentNumber) async {
    final String response =
        await rootBundle.loadString('assets/ogrenciler.json');
    final List<dynamic> data = json.decode(response);
    for (var student in data) {
      if (student['ogrenci_numarasi'] == studentNumber) {
        return true;
      }
    }
    return false;
  }
}
