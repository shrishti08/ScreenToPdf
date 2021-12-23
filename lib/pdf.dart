import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart ' as pw;
import 'package:printing/printing.dart';

class ScreenToPdf extends StatelessWidget {
  ScreenToPdf({Key? key}) : super(key: key);
  final GlobalKey<State<StatefulWidget>> _printKey = GlobalKey();

  void _printScreen() async {
    Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      final doc = pw.Document();

      final image = await WidgetWraper.fromKey(
        key: _printKey,
        pixelRatio: 2.0,
      );

      doc.addPage(pw.Page(
          pageFormat: format,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Expanded(
                child: pw.Image(image),
              ),
            );
          }));

      return doc.save();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _printKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Screen to PDF'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://picsum.photos/250?image=9',
                height: 200,
                width: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text('Screen to PDF'),
                onPressed: () {
                  _printScreen();
                },
              ),
              const Text('Printing the data from the screen to PDF'),
            ],
          ),
        ),
      ),
    );
  }
}
