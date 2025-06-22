import 'dart:ui';

import 'package:CalGrow/main.dart';
import 'package:CalGrow/datosUsuario.dart';
import 'package:flutter/material.dart';

class Registrar extends StatefulWidget {
  const Registrar({super.key});

  @override
  State<Registrar> createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwdController = TextEditingController();
  final TextEditingController repasswdController = TextEditingController();
  bool verPasswd = false;
  bool verRePasswd = false;

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    passwdController.dispose();
    repasswdController.dispose(); // libera memoria al cerrar
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
                        const SizedBox(height: 10),
                        _buildInput(
                          icon: Icons.person_add,
                          width: 180,
                          background: false,
                          iconSize: 120,
                        ),
                        const SizedBox(height: 14),
                        _buildInput(
                          icon: Icons.email_outlined,
                          hint: 'Ingrese su correo',
                          width: screenW,
                          controller: emailController,
                        ),
                        const SizedBox(height: 14),
                        _buildInput(
                          icon: Icons.call,
                          width: screenW,
                          hint: 'Ingrese su número de teléfono',
                          controller: phoneController,
                        ),
                        const SizedBox(height: 16),
                        _buildInput(
                          icon: Icons.lock_outline,
                          hint: 'Ingrese su contraseña',
                          width: screenW,
                          obscure: !verPasswd,
                          controller: passwdController,
                          suffixIcon: IconButton(
                            icon: Icon(
                              verPasswd
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                verPasswd = !verPasswd;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildInput(
                          icon: Icons.lock_outline,
                          hint: 'Vuelva a ingresar su contraseña',
                          width: screenW,
                          obscure: !verRePasswd,
                          controller: repasswdController,
                          suffixIcon: IconButton(
                            icon: Icon(
                              verRePasswd
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                verRePasswd = !verRePasswd;
                              });
                            },
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
                                String email = emailController.text.trim();
                                String phone = phoneController.text.trim();
                                String passwd = passwdController.text.trim();
                                String repasswd = repasswdController.text
                                    .trim();

                                if (email.isEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                          'El campo de correo está vacío',
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
                                } else if (!email.contains('@')) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                          'El correo debe contener "@"',
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
                                } else if (!email.contains('.')) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                          'El correo debe contener "."',
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
                                } else if (phone.isEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                          'El campo del número celular está vacío',
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
                                } else if (phone.length < 11 ||
                                    phone.length > 11) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                          'El número no es valido (Recuerde poner el prefijo de su país)',
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
                                          'El campo de la contraseña está vacío.',
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
                                } else if (passwd.length < 4 ||
                                    passwd.length > 14) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                          'La contraseña es inválida',
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
                                } else if (repasswd.isEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                          'Vuelva a ingresar la contraseña',
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
                                } else if (repasswd != passwd) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                          'Las contraseñas no coinciden',
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
                                  usuariosRegistrados.add(
                                    Usuario(
                                      emailUsu: email,
                                      phoneUsu: phone,
                                      passwdUsu: passwd,
                                    ),
                                  );
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('¡Éxito!'),
                                        content: const Text(
                                          '¡Ha creado su cuenta correctamente!\nInicie Sesión para entrar',
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
                                            child: const Text('Aceptar'),
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
                                'Registrarse',
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
    String? hint,
    required double width,
    bool obscure = false,
    double iconSize = 24,
    bool background = true,
    TextEditingController? controller,
    Widget? suffixIcon,
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
          suffixIcon: suffixIcon,
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
