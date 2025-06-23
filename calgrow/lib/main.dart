import 'menu_principal.dart';
import 'register.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'recover_passwd.dart';
import 'package:CalGrow/datosUsuario.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool switchActivo = false;
  final TextEditingController emailIngresado = TextEditingController();
  final TextEditingController passwdIngresado = TextEditingController();

  @override
  void dispose() {
    emailIngresado.dispose();
    passwdIngresado.dispose();
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
            // Fondo y desenfoque fijo
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
            // Logo fijo
            Positioned(
              top: -MediaQuery.of(context).size.height * 0.02,
              left: screenW * 0.31,
              child: Image.asset(
                'assets/CalGrow-Icono.png',
                width: screenW * 0.4,
                height: screenW * 0.4,
              ),
            ),
            // Tarjeta blanca con scroll para inputs
            Positioned(
              top: MediaQuery.of(context).size.height * 0.22,
              left: screenW * 0.05,
              child: Container(
                width: screenW * 0.9,
                height: MediaQuery.of(context).size.height * 0.65,
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
                        SizedBox(
                          height: screenW * 0.02,
                        ), // espacio para el icono interno
                        Image.asset(
                          'assets/CalGrow-Usuario-Icon.png',
                          width: screenW * 0.30,
                          height: screenW * 0.30,
                        ),
                        const SizedBox(height: 20),
                        _buildInput(
                          icon: Icons.email_outlined,
                          hint: 'Ingrese su correo',
                          width: screenW,
                          controller: emailIngresado,
                        ),
                        const SizedBox(height: 16),
                        _buildInput(
                          icon: Icons.lock_outline,
                          hint: 'Ingrese su contraseña',
                          width: screenW,
                          obscure: true,
                          controller: passwdIngresado,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Switch(
                              value: switchActivo,
                              onChanged: (val) =>
                                  setState(() => switchActivo = val),
                              activeTrackColor: Colors.indigoAccent,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Recordar contraseña',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RecoverPasswd(),
                                ),
                              );
                            },
                            child: const Text(
                              '¿Olvidó su contraseña?',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenW * 0.02),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Registrar(),
                                ),
                              );
                            },
                            child: const Text(
                              '¿No tiene una cuenta?',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: screenW * 0.12),
                        Padding(
                          padding: EdgeInsets.only(right: screenW * 0.02),
                          child: SizedBox(
                            width: screenW * 0.5,
                            height: screenW * 0.13,
                            child: ElevatedButton(
                              onPressed: () {
                                String email = emailIngresado.text.trim();
                                String passwd = passwdIngresado.text.trim();

                                Usuario? usuarioEncontrado = usuariosRegistrados
                                    .cast<Usuario?>()
                                    .firstWhere(
                                      (u) =>
                                          u!.emailUsu == email &&
                                          u.passwdUsu == passwd,
                                      orElse: () => null,
                                    );

                                if (email.isEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                          'Debe ingresar un correo',
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
                                } else if (passwd.isEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                          'Debe ingresar una contraseña',
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
                                } else if (usuarioEncontrado == null) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                          'Correo y/o contraseña incorrectos',
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MenuPrincipal(),
                                    ),
                                  );
                                  emailIngresado.clear();
                                  passwdIngresado.clear();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4b626e),
                              ),
                              child: const Text(
                                'Iniciar Sesión',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
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
    required String hint,
    required double width,
    bool obscure = false,
    TextEditingController? controller,
  }) {
    return SizedBox(
      width: width * 0.8,
      child: TextField(
        controller: controller,
        obscureText: obscure,
        cursorColor: Colors.blue,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
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
