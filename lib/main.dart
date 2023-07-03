import 'package:flutter/material.dart';

void main() {
  runApp(Catatan());
}

class Catatan extends StatelessWidget {
  const Catatan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Agenda Kegiatan Sederhana',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DaftarAgenda(),
    );
  }
}

class DaftarAgenda extends StatefulWidget {
  const DaftarAgenda({super.key});

  @override
  State<DaftarAgenda> createState() => _DaftarAgendaState();
}

class _DaftarAgendaState extends State<DaftarAgenda> {
  List<String> agendas = [];

  void tambahAgenda(String agenda) {
    setState(() {
      agendas.add(agenda);
    });
  }

  void doneAgenda(int index) {
    setState(() {
      agendas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agenda')),
      body: ListView.builder(
          itemCount: agendas.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(agendas[index]),
              trailing: IconButton(
                icon: Icon(Icons.check),
                onPressed: () => doneAgenda(index),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final agenda = await showDialog(
              context: context,
              builder: (BuildContext context) {
                String newAgenda = '';
                return AlertDialog(
                    title: Text('Agenda Baru'),
                    content: TextField(
                      onChanged: (value) {
                        newAgenda = value;
                      },
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(newAgenda);
                          },
                          child: Text('Tambah'))
                    ]);
              });

          if (agenda != null) {
            tambahAgenda(agenda);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
