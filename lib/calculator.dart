import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = "";
  String result = "0";
  List<String> buttonList = [
    "AC",
    "(",
    ")",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "0",
    ".",
    "C",
    "=",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 6,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0.0, 32.0, 32.0, 8.0),
            width: double.infinity,
            child: Text(
              userInput,
              style: const TextStyle(fontSize: 18.0),
              textAlign: TextAlign.right,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 32.0, 0.0),
            width: double.infinity,
            child: Text(
              result,
              style:
                  const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
          const Divider(
            height: 32.0,
            color: Colors.white,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: buttonList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0),
                itemBuilder: ((context, index) {
                  return MyButton(
                    buttonList[index].toString(),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget MyButton(String input) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          handleButton(input);
        });
      },
      style: ElevatedButton.styleFrom(backgroundColor: getColor(input)),
      child: Text(
        input,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 24.0,
            color: Colors.white,
            textBaseline: TextBaseline.alphabetic),
      ),
    );
  }

  Color? getColor(String input) {
    if (input == "AC") {
      return Colors.red[700];
    } else if (input == "(" ||
        input == ")" ||
        input == "/" ||
        input == "*" ||
        input == "-" ||
        input == "+") {
      return Colors.red[300];
    } else if (input == "=") {
      return Colors.amber[900];
    } else {
      return Colors.black54;
    }
  }

  void handleButton(String input) {
    if (input == "AC") {
      userInput = "";
      result = "0";
    } else if (input == "C") {
      if (userInput.isNotEmpty == true) {
        userInput = userInput.substring(0, userInput.length - 1);
      }
    } else if (input == "=") {
      userInput = calculate();
      result = calculate();
    } else {
      userInput = userInput + input;
    }
  }

  String calculate() {
    try {
      Expression exp = Parser().parse(userInput);
      var eval = exp.evaluate(EvaluationType.REAL, ContextModel());
      eval = eval.toString();
      if (eval.endsWith(".0")) {
        return eval.replaceAll(".0", "");
      } else {
        return eval;
      }
    } catch (e) {
      return "Error";
    }
  }
}
