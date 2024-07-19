import 'package:flutter/material.dart';
import 'qr_scan_page.dart';

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  List<bool> taskCompleted = List.generate(6, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Oryantasyon Görevleri'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Görev ${index + 1}'),
              subtitle: Text(_getTaskDescription(index)),
              trailing: taskCompleted[index]
                  ? Icon(Icons.check, color: Colors.green)
                  : IconButton(
                      icon: Icon(Icons.qr_code_scanner),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QRScanPage(
                              onResult: (code) {
                                // QR kod tarandıktan sonra işaretle
                                setState(() {
                                  taskCompleted[index] = true;
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
            );
          },
        ),
      ),
    );
  }

  String _getTaskDescription(int index) {
    switch (index) {
      case 0:
        return 'Giriş kattaki hamburgerciden hamburgerini al.';
      case 1:
        return 'Kütüphaneye git ve ilk kitabını al.';
      case 2:
        return 'Otoparka gidip aracını park et.';
      case 3:
        return 'Öğrenci işlerine uğrayıp kayıt işlemini tamamla.';
      case 4:
        return 'Spor salonunda ilk egzersizini yap.';
      case 5:
        return 'Kantin çalışanıyla tanışıp bir kahve al.';
      default:
        return '';
    }
  }
}
