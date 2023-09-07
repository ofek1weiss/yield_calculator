import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yield Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Yield Calculator'),
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
  int price = 0;
  int rend = 0;
  int tsua = 0;
  TextEditingController priceController = TextEditingController();
  TextEditingController rendController = TextEditingController();
  TextEditingController tsuaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    priceController.text = price.toString();
    rendController.text = rend.toString();
    tsuaController.text = tsua.toString();
  }

  void calculatePrice() {
    setState(() {
      price = (rend * 12 * 100) ~/ tsua;
      priceController.text = price.toString();
    });
  }

  void caclulateRend() {
    setState(() {
      rend = (tsua * price) ~/ 100 ~/ 12;
      rendController.text = rend.toString();
    });
  }

  void caclulateTsua() {
    setState(() {
      tsua = (rend * 12 * 100) ~/ price;
      tsuaController.text = tsua.toString();
    });
  }

  Widget getInputButton(BuildContext context, String text, TextEditingController controller, Function(String) onChanged, Function() calculate) {
    return Column(
      children: [
        Row(children: [
          SizedBox(
            width: 60, 
            child: Text("$text: ", textScaleFactor: 1.2,)
          ),
          Flexible(
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: controller,
              onChanged: onChanged,
            )
          ),
        ],),
        TextButton(onPressed: calculate, child: const Text("Calculate"))
      ],
    );
  }

  Widget getButtons(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        getInputButton(context, "Price", priceController, (String value) {
          setState(() {
            price = int.parse(value);
            priceController.text = price.toString();
          });
        }, calculatePrice),
        const Divider(),
        getInputButton(context, "Rent", rendController, (String value) {
          setState(() {
            rend = int.parse(value);
            rendController.text = rend.toString();
          });
        }, caclulateRend),
        const Divider(),
        getInputButton(context, "Yield", tsuaController, (String value) {
          setState(() {
            tsua = int.parse(value);
            tsuaController.text = tsua.toString();
          });
        }, caclulateTsua),
        const Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(16),
        child: getButtons(context),
      ),
    );
  }
}
