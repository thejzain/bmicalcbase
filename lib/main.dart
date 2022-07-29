import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(
          //primarySwatch: Colors.teal,
          ),
      home: RootPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RootPage extends StatefulWidget {
  RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  bool ismale = false;
  bool isfemale = false;
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  double? bmi;
  String message = 'Enter';

  void calculate() {
    final double? height = double.tryParse(heightController.value.text);
    final double? weight = double.tryParse(weightController.value.text);

    if (height == null || height <= 0 || weight == null || weight <= 0) {
      setState(() {
        message = "Your height and weigh must be positive numbers";
      });
      return;
    }

    setState(() {
      bmi = weight / (height * height);
    });

    setState(() {
      bmi = weight / (height * height);
      if (bmi! < 18.5) {
        message = "You are underweight";
      } else if (bmi! < 25) {
        message = 'You body is fine';
      } else if (bmi! < 30) {
        message = 'You are overweight';
      } else {
        message = 'You are obese';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI CALC"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                  onTap: () {
                    ismale = !ismale;
                    setState(() {});
                  },
                  child: ismale
                      ? Container(
                          color: Colors.amber,
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Male"),
                          ),
                        )
                      : Container(
                          color: Colors.pink,
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Male"),
                          ),
                        )),
              InkWell(
                onTap: () {
                  isfemale = !isfemale;
                  setState(() {});
                },
                child: isfemale
                    ? Container(
                        color: Colors.amber,
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text("Female"),
                        ),
                      )
                    : Container(
                        color: Colors.pink,
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text("Female"),
                        ),
                      ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              controller: heightController,
              decoration: const InputDecoration(
                label: Text("Height in m"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              controller: weightController,
              decoration: const InputDecoration(
                label: Text("Weight in Kg"),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: calculate,
            child: const Text("Submit"),
          ),
          Text(
            bmi == null ? 'No results' : bmi!.toStringAsFixed(2),
            style: const TextStyle(fontSize: 30),
          ),
          Text(
            message,
            style: const TextStyle(fontSize: 25),
          ),
        ],
      ),
    );
  }
}
