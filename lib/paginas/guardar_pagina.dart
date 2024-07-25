import 'package:flutter/material.dart';
import 'package:crud_flutter_goyo/db/operaciones.dart';
import 'package:crud_flutter_goyo/modelos/notas.dart';


class guardarPagina extends StatelessWidget {
  const guardarPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guardar Nota'),
        backgroundColor: Color.fromARGB(255, 195, 26, 26),
      ),
      body: const GuardarFormulario(),
    );
  }
}

class GuardarFormulario extends StatefulWidget {
  const GuardarFormulario({super.key});

  @override
  State<GuardarFormulario> createState() => _GuardarFormularioState();
}

class _GuardarFormularioState extends State<GuardarFormulario> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _tituloController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingrese un título';
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Título de la Nota',
                labelStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color.fromARGB(255, 195, 26, 26)),
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.title, color: Color.fromARGB(255, 195, 26, 26)),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descripcionController,
              maxLength: 1000,
              maxLines: 4,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingresa una descripción';
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Descripción de la nota',
                labelStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color.fromARGB(255, 195, 26, 26)),
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.description, color: Color.fromARGB(255, 193, 18, 18)),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 248, 70, 70),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Guardar Nota', style: TextStyle(fontSize: 16)),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Guardando Nota')),
                  );

                  Operaciones.insertarOperacion(Nota(
                      titulo: _tituloController.text,
                      descripcion: _descripcionController.text,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
