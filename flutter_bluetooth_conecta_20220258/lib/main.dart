import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EL escaneador',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,

      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<ScanResult> Dispositivos = [];

  @override
  void initState() {


    super.initState();
    Pascanear();

  }

  Future<void> Pascanear() async {

    FlutterBluePlus.scanResults.listen((List<ScanResult> results) {
      setState(() {
        Dispositivos = results;
      });
    });
    FlutterBluePlus.startScan();
  }

  Future<void> Paconectar(BluetoothDevice device) async {
   
    await device.connect();
    
  }

  Future<void> Padesconectardisque(BluetoothDevice device) async {
   

    await device.disconnect();
    
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      appBar: AppBar(
        title: const Text('Mi Bluetooth'),
        backgroundColor: Colors.amber,

      ),
      body: ListView.builder(
        itemCount: Dispositivos.length,
        itemBuilder: (context, index) {

          return ListTile(
            title: Text(Dispositivos[index].device.name ?? 'No se ve'),
            subtitle: Text(Dispositivos[index].device.id.toString()),
            trailing: Dispositivos[index].device.isConnected
                ? ElevatedButton(
                    onPressed: () {
                      Padesconectardisque(Dispositivos[index].device);
                    },
                    child: const Text('Desconetar'),
                  )
                : ElevatedButton(
                    onPressed: () {
                      Paconectar(Dispositivos[index].device);
                    },
                    child: const Text('Conectar'),
                  ),


          );
        },
      ),
    );
  }
}
