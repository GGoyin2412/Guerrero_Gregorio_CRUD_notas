import 'package:flutter/material.dart';
import 'package:crud_flutter_goyo/db/operaciones.dart';
import 'package:crud_flutter_goyo/paginas/guardar_pagina.dart';
import 'package:crud_flutter_goyo/modelos/notas.dart';
import 'package:crud_flutter_goyo/paginas/editar_nota.dart';

class ListPages extends StatelessWidget {
  const ListPages({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder:(context) => guardarPagina())
            );
        }),
        appBar: AppBar(
          title: const Text('Lista de Notas', style: TextStyle(color: Colors.white),),
          backgroundColor: Color.fromARGB(255, 156, 132, 132),
        ),
        body: Container(
          child: _MiLista()
        ),
    );
  }
}

class _MiLista extends StatefulWidget{

  @override
  State<_MiLista> createState() => _MiListaState();

}

class _MiListaState extends State<_MiLista>{
  List<Nota> notas = [];
    @override
    void initState() {
      _cargarDatos();
      super.initState();
  }

  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: notas.length,
      itemBuilder: (_,i) => _crearTem(i),
    );
  }

  _cargarDatos() async{
    List<Nota> auxNotas = await Operaciones.obtenerNotas();
    setState(() {
      notas = auxNotas;
    });
  }

  _crearTem(int i){
    return Dismissible(
      key: Key(i.toString()),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: const EdgeInsets.only(left: 20),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete, color: Colors.white, size: 30,),
        ),
      ),
      onDismissed: (direction){
        Operaciones.eliminarOperacion(notas[i]);
      },
      child: ListTile(
        title: Text(notas[i].titulo),
        trailing: Icon(Icons.edit, color: Colors.black),
          onTap: () async {
            bool? result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditNoteScreen(nota: notas[i]),
              ),
            );
            if (result == true) {
              _cargarDatos(); // Actualiza la lista cuando se edita una nota
            }
          },
      )
    );
  }
}