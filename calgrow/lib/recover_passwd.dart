import 'dart:ui';

import 'package:CalGrow/main.dart';
import 'package:flutter/material.dart';

class RecoverPasswd extends StatefulWidget {
  const RecoverPasswd({super.key});

  @override
  State<RecoverPasswd> createState() => _RecoverPasswdState();
}

class _RecoverPasswdState extends State<RecoverPasswd> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose(); // libera memoria al cerrar
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox.expand(
              child: Image.asset(
                'assets/CalGrow-background.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox.expand(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                child: Container(color: Colors.black.withOpacity(0.2)),
              ),
            ),

            Positioned(
              top: -MediaQuery.of(context).size.height * 0.02,
              left: screenW * 0.31,
              child: Image.asset(
                'assets/CalGrow-Icono.png',
                width: screenW * 0.4,
                height: screenW * 0.4,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.22,
              left: screenW * 0.05,
              child: Container(
                width: screenW * 0.9,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(19),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: screenW * 0.02),
                        const SizedBox(height: 10),
                        _buildInput(
                          icon: Icons.lock_outline,
                          width: 150,
                          iconSize: 120,
                          background: false,
                        ),

                        SizedBox(height: 15),
                        const Text(
                          'Ingrese su correo electrónico para continuar en la página',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 30),
                        _buildInput(
                          icon: Icons.email_outlined,
                          hint: 'Ingresa tu correo',
                          width: screenW,
                          iconSize: 40,
                          controller: emailController,
                        ),
                        const SizedBox(height: 60),
                        Padding(
                          padding: EdgeInsets.only(right: screenW * 0.02),
                          child: SizedBox(
                            width: screenW * 0.7,
                            height: screenW * 0.13,
                            child: ElevatedButton(
                              onPressed: () {
                                String email = emailController.text.trim();

                                if (email.isEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                          'El campo de texto está vacio. Ingrese un correo',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text('Aceptar'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else if (!email.contains('@') &&
                                    !email.contains('.')) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                          'El correo debe contener "@" y "."',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text('Aceptar'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('¡Éxito!'),
                                        content: const Text(
                                          'Se le han enviado las instrucciones al correo',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MyHomePage(),
                                                ),
                                              );
                                            },
                                            child: const Text('Cerrar'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4b626e),
                              ),
                              child: const Text(
                                'Recuperar contraseña',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput({
    required IconData icon,
    String? hint,
    required double width,
    bool obscure = false,
    double iconSize = 24,
    bool background = true,
    TextEditingController? controller,
  }) {
    return SizedBox(
      width: width * 0.8,
      child: TextField(
        controller: controller,
        obscureText: obscure,
        cursorColor: Colors.blue,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, size: iconSize),
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: background
              ? Colors.white.withOpacity(0.2)
              : Colors.transparent,
        ),
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          color: Colors.black,
        ),
      ),
    );
  }
}
