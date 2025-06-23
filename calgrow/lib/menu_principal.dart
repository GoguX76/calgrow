import 'package:CalGrow/mapaHectarea.dart';
import 'package:flutter/material.dart';
import 'dart:async';

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final anchoPantalla = size.width;

    // Tamaños relativos para adaptabilidad
    final tamanioImagen =
        anchoPantalla * 0.45; // 45% del ancho para cada imagen
    final alturaContenedor = tamanioImagen + 70;
    final anchoBoton =
        anchoPantalla * 0.85; // 85% ancho de pantalla para botones

    return Scaffold(
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
                            top: 0,
                            bottom: 0,
                            child: Image.asset(
                              'assets/CalGrow-GraficoBerries.png',
                              width: tamanioImagen,
                              height: tamanioImagen,
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
                onPressed: () {
                  // tu función aquí
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
          fontSize: 22,
          color: Colors.white,
          fontFamily: 'Poppins',
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF708070),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      ),
    );
  }
}
