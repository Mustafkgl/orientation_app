import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanPage extends StatefulWidget {
  final Function(String) onResult;

  QRScanPage({required this.onResult});

  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  QRViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Kodu Tara'),
      ),
      body: Stack(
        children: <Widget>[
          QRView(
            key: UniqueKey(),
            onQRViewCreated: _onQRViewCreated,
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                child: Text('Kapat'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      final code = scanData.code ?? ''; // Default to empty string if null
      widget.onResult(code);
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
