import 'package:CalGrow/main.dart';
import 'package:CalGrow/mapaHectarea.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'dart:io';

class MenuPrincipal extends StatefulWidget {
  const MenuPrincipal({super.key});

  @override
  State<MenuPrincipal> createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {
  int minutos = 1;
  late Timer _timer;
  final List<String> imagenes = [
    'assets/CalGrow-Grafico1.png',
    'assets/CalGrow-Grafico2.png',
  ];
  int indiceImagen = 0;

  @override
  void initState() {
    super.initState();
    _iniciarContador();
  }

  void _iniciarContador() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        minutos = (minutos % 15) + 1;
        if (minutos == 1) {
          indiceImagen = (indiceImagen + 1) % imagenes.length;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _mostrarPanelLateral(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Menu",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.centerRight,
          child: Material(
            color: const Color(0xFF708070),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: double.infinity,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Menú',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'Ver Alertas',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Alertas'),
                              content: const Text('No hay alertas disponibles'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Aceptar'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.white),
                      title: const Text(
                        'Cerrar Sesión',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyHomePage(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(anim),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final anchoPantalla = size.width;

    // Tamaños relativos para adaptabilidad
    final tamanioImagen =
        anchoPantalla * 0.38; // 45% del ancho para cada imagen
    final alturaContenedor = tamanioImagen + 130;
    final anchoBoton = anchoPantalla * 0.80;
    final tamanioBerries = tamanioImagen * 1.15;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color(0xFFE0D7D4),
        body: SafeArea(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                child: Container(
                  width: double.infinity,
                  height: alturaContenedor,
                  color: const Color(0xFFBCC290),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.menu, color: Colors.white),
                            onPressed: () {
                              _mostrarPanelLateral(context);
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: tamanioImagen,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              bottom: 0,
                              child: Image.asset(
                                imagenes[indiceImagen],
                                width: tamanioImagen,
                                height: tamanioImagen,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: -10,
                              child: Image.asset(
                                'assets/CalGrow-GraficoBerries.png',
                                width: tamanioBerries,
                                height: tamanioBerries,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Actualizado hace: $minutos minuto${minutos > 1 ? 's' : ''}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 110),

              SizedBox(
                width: anchoBoton,
                child: _buildBotonConIcono(
                  texto: 'Ver Mapa',
                  icono: Icons.map,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MapaHectarea(),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 50),

              SizedBox(
                width: anchoBoton,
                child: _buildBotonConIcono(
                  texto: 'Descargar Informe',
                  icono: Icons.description,
                  onPressed: () async {
                    await generarYGuardarPDF();
                  },
                ),
              ),

              const Spacer(),

              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/CalGrow-Icono.png',
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBotonConIcono({
    required String texto,
    required IconData icono,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icono, size: 40, color: Colors.white),
      label: Text(
        texto,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontFamily: 'Poppins',
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF708070),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
      ),
    );
  }
}

Future<void> generarYGuardarPDF() async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text(
            'Informe generado con CalGrow. Archivo de prueba, sin información real',
            style: pw.TextStyle(fontSize: 24),
          ),
        ); // Center
      },
    ),
  );

  try {
    final output = await getApplicationDocumentsDirectory();
    final file = File('${output.path}/informe_calgrow.pdf');

    await file.writeAsBytes(await pdf.save());

    await OpenFile.open(file.path);
  } catch (e) {
    print('Error al guardar el PDF: $e');
  }
}
