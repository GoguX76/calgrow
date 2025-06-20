import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool switchActivo = false;
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: null,
      body: Stack(
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
            top: -15,
            left: 125,
            child: Image.asset(
              'assets/CalGrow-Icono.png',
              width: 180,
              height: 180,
            ),
          ),

          Align(
            alignment: Alignment(0, 0.17),
            child: Container(
              width: 370,
              height: 520,
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(19),
              ),
            ),
          ),

          Positioned(
            bottom: 180,
            left: 115,
            child: SizedBox(
              width: 190,
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  print('Iniciaste Sesion!');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4b626e),
                ),
                child: const Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment(0, -0.30),
            child: Container(
              width: 350,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFF4b626e),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),

          Align(
            alignment: Alignment(0, -0.10),
            child: Container(
              width: 350,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFF4b626e),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),

          Positioned(
            top: 170,
            left: 155,
            child: Image.asset(
              'assets/CalGrow-Usuario-Icon.png',
              width: 110,
              height: 110,
            ),
          ),

          Positioned(
            top: 302,
            left: 30,
            child: Image.asset(
              'assets/CalGrow-Email-Icon.png',
              width: 50,
              height: 50,
            ),
          ),

          Positioned(
            top: 390,
            left: 30,
            child: Image.asset(
              'assets/CalGrow-Padlock-Icon.png',
              width: 50,
              height: 50,
            ),
          ),

          Positioned(
            bottom: 415,
            right: 320,
            child: Switch(
              value: switchActivo,
              onChanged: (bool switchCambio) {
                setState(() {
                  switchActivo = switchCambio;
                });
              },
              activeTrackColor: Colors.indigoAccent,
            ),
          ),

          Positioned(
            top: 303,
            left: 85,
            child: SizedBox(
              width: 270,
              height: 150,
              child: TextField(
                cursorColor: Colors.blue,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: 'Ingrese su correo',
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          Positioned(
            top: 390,
            left: 85,
            child: SizedBox(
              width: 270,
              height: 150,
              child: TextField(
                cursorColor: Colors.blue,
                obscureText: true,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: 'Ingrese su contraseña',
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
