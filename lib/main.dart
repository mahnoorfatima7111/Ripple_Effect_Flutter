import 'package:flutter/material.dart';
import 'package:flutter_my_animations/drop_down_menu.dart';
// import 'package:flutter_my_animations/interactive_ripples.dart';
// import 'package:flutter_my_animations/repeated_ripples.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dropdown Menu Animations',
      // title: 'The Ripple Effects',
      theme: ThemeData(useMaterial3: true),
      home: const MyHomePage(title: 'Dropdown Menu'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 161, 109, 251),
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        // flexibleSpace: Container(
        //   decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [Colors.purple, Colors.blue],
        //       begin: Alignment.topLeft,
        //       end: Alignment.bottomRight,
        //     ),
        //   ),
        // ),
      ),
      // body: Center(child: RepeatedRipples()),
      body: Center(child: DropDownMenu()),
      // body: Center(child: RipplesAnywhere()),
    );
  }
}


/**
 * // child: Expanded(
        //   child:
        //       // RepeatedRipples(),
        // ),

 * 
 */


//***
// // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

// */

 // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      // ),


      // backgroundColor: Colors.black,
      // backgroundColor: Color.fromARGB(52, 51, 51, 100),


       // const Padding(
      //   padding: EdgeInsets.all(16.0),
      // Text(
      //   'Repeated Ripple Effect',
      //   style: TextStyle(
      //     fontSize: 24,
      //     fontWeight: FontWeight.bold,
      //     color: Colors.white,
      //   ),
      // ),
      // ),