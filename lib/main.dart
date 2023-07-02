import 'package:flutter/material.dart';

void main() {
  runApp(Catatan());
}

class Catatan extends StatelessWidget {
  const Catatan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Catatan Sederhana',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: DaftarCatatan(),
    );
  }
}

class DaftarCatatan extends StatefulWidget {
  const DaftarCatatan({super.key});

  @override
  State<DaftarCatatan> createState() => _DaftarCatatanState();
}

class _DaftarCatatanState extends State<DaftarCatatan> {
  List<String> catatans = [];

  void tambahCatatan(String catatan) {
    setState(() {
      catatans.add(catatan);
    });
  }

  void doneCatatan(int index) {
    setState(() {
      catatans.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Catatan')),
      body: ListView.builder(
          itemCount: catatans.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(catatans[index]),
                trailing: IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () => doneCatatan(index),
                ));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final catatan = await showDialog(
              context: context,
              builder: (BuildContext context) {
                String newCatatan = '';
                return AlertDialog(
                    title: Text('Catatan Baru'),
                    content: TextField(
                      onChanged: (value) {
                        newCatatan = value;
                      },
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(newCatatan);
                          },
                          child: Text('Tambah'))
                    ]);
              });

          if (catatan != null) {
            tambahCatatan(catatan);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
