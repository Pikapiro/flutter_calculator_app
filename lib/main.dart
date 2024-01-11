import 'dart:math';
import 'package:flutter/material.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  bool isFirstNumberTapped = false;
  bool isOperationTapped = false;
  bool isFirstOperatorActive = false;
  bool isSecondOperatorActive = false;
  bool isNegative = false;
  bool isCalculeteDone = false;
  bool isNumberFloat = false;

  double calcution = 0;
  int _selectedIndex = 0;
  double firstOperand = 0;
  double secondOperand = 0;

  String screenString = "";
  String lastOperation = "";

  Color colorEqual=Colors.orange;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Basic Calculator',
      style: optionStyle,
    ),
    Text(
      'Index 1: Scientific Calculator',
      style: optionStyle,
    ),
    Text(
      'Index 2: Unit Convertor',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEdgeDragWidth: 0,
      drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Calculator'),
              ),
              ListTile(
                title: const Text('Basic Calculator'),
                selected: _selectedIndex == 0,
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(0);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Scientific Calculator'),
                selected: _selectedIndex == 1,
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(1);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Unit Converter'),
                selected: _selectedIndex == 2,
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(2);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          )),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Calculator"),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.orange,
                width: double.infinity,
                child: Text(screenString == "" ? "0" : screenString,
                    textAlign: TextAlign.right, style: const TextStyle(fontSize: 60)),
              )),

          Container(
            color: Colors.grey,
            child: SizedBox(
              height: 465,
              child: Row(
                children: [
                  Expanded(
                      flex: 4,
                      child: GridView.count(
                        crossAxisCount: 4,
                        crossAxisSpacing: 20,
                        children: [
                          InkWell(
                              onTap: () {
                                setState(() {
                                  if (isFirstNumberTapped == true) {
                                    isOperationTapped = true;
                                  }
                                  print(firstOperand);
                                  firstOperand = double.parse(screenString);
                                  print(firstOperand);
                                  lastOperation = "square";
                                  screenString = doCalculation(firstOperand,
                                      secondOperand, lastOperation)
                                      .toString();
                                });
                              },
                              child: Container(
                                  child: const Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 15.0),
                                        child: Text(
                                          "x²",
                                          style: TextStyle(fontSize: 50),
                                        ),
                                      )))),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isFirstNumberTapped = false;
                                isOperationTapped = false;
                                calcution = 0;
                                lastOperation = "";
                                firstOperand = 0;
                                secondOperand = 0;
                                screenString = "";
                                isNegative = false;
                                isFirstOperatorActive = false;
                                isSecondOperatorActive = false;
                                isCalculeteDone = false;
                              });
                            },
                            child: Container(
                              child: const Center(
                                  child: Text(
                                    "CE",
                                    style: TextStyle(fontSize: 40),
                                  )),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (isFirstNumberTapped == true) {
                                  isOperationTapped = true;
                                }
                                firstOperand = double.parse(screenString);
                                lastOperation = "root";
                                try {
                                  screenString = doCalculation(firstOperand,
                                      secondOperand, lastOperation)
                                      .toString();
                                } catch (e) {
                                  screenString = "Number Cant Be Negative!";
                                }
                              });
                            },
                            child: Container(
                                child: const Center(
                                    child: Text("√",
                                        style: TextStyle(fontSize: 40)))),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                screenString = screenString.substring(
                                    0, screenString.length - 1);
                                if( !ensureFloatNumber(screenString)) {
                                  isNumberFloat=false;
                                }
                              });
                            },
                            child: Container(
                                child: const Center(
                                    child: Icon(Icons.arrow_back_sharp))),
                          ),
                          InkWell(onTap:(){
                            buttonNumberAction("7");
                          },child: buttons(sign:"7")),

                          InkWell(
                              onTap: () {
                                buttonNumberAction("8");
                              },
                              child: buttons(sign:"8")),
                          InkWell(
                              onTap: () {
                                buttonNumberAction("9");
                              },
                              child: buttons(sign:"9")),
                          InkWell(
                              onTap: () {
                                buttonArithmetical("+");
                              },
                              child: buttons(sign:"+")),

                          InkWell(
                              onTap: () {
                                buttonNumberAction("4");
                              },
                              child: buttons(sign:"4")),
                          InkWell(
                              onTap: () {
                                buttonNumberAction("5");
                              },
                              child: buttons(sign:"5")),
                          InkWell(
                              onTap: () {
                                buttonNumberAction("6");
                              },
                              child: buttons(sign:"6")),
                          InkWell(
                              onTap: () {
                                buttonArithmetical("-");
                              },
                              child: buttons(sign:"-")),
                          InkWell(
                              onTap: () {
                                buttonNumberAction("1");
                              },
                              child: buttons(sign:"1")),
                          InkWell(
                              onTap: () {
                                buttonNumberAction("2");
                              },
                              child: buttons(sign:"2")),
                          InkWell(
                              onTap: () {
                                buttonNumberAction("3");
                              },
                              child: buttons(sign:"3")),
                          InkWell(
                              onTap: () {
                                buttonArithmetical("/");
                              },
                              child: buttons(sign:"/")),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  isNegative = !isNegative;

                                  if (isNegative) {
                                    screenString = "-$screenString";
                                  } else {
                                    screenString =
                                        screenString.replaceFirst("-", "");
                                  }
                                });
                              },
                              child: buttons(sign:"+-")),
                          InkWell(
                              onTap: () {
                                buttonNumberAction("0");
                              },
                              child: buttons(sign:"0")),
                          Container(
                            child: InkWell(
                              onTap: (){
                                setState(() {

                                  if(isNumberFloat==false){
                                    screenString="$screenString,";
                                    isNumberFloat=true;
                                  }

                                });

                              },
                              child: const Center(
                                  child:
                                  Text(",", style: TextStyle(fontSize: 40))),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                buttonArithmetical("*");
                              },
                              child: buttons(sign:"*")),

                        ],
                      ))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0, bottom: 0),
            child: GestureDetector(
              onTap: () {
                secondOperand = double.parse(screenString);
                setState(() {
                  try {
                    calcution = doCalculation(
                        firstOperand, secondOperand, lastOperation);
                    screenString = calcution.toString();
                    print(screenString);
                    if(screenString.substring(screenString.length-2) ==".0"){
                      screenString=calcution.toInt().toString();
                      print("input:$screenString");
                      screenString=int.parse(screenString).toString();
                    }

                  } catch (e) {
                    setState(() {
                      screenString = "Divide by 0 Error";
                    });
                  } finally {
                    firstOperand = calcution;
                    secondOperand = 0;
                    isCalculeteDone = true;
                  }
                });

              },
              onLongPress:() {
                setState(() {
                  colorEqual=Colors.grey;
                });
              },
              onLongPressEnd:(details){
                setState(() {
                  colorEqual=Colors.orange;
                });
              },
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: double.infinity,
                  color: colorEqual,
                  child: const Text(
                    "=",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  bool ensureFloatNumber(String screenString){
    return screenString.contains(",");
  }

  void buttonArithmetical(String operation) {
    setState(() {
      if (isFirstNumberTapped == true) isOperationTapped = true;
      firstOperand = double.parse(screenString);
      lastOperation = operation;
      isFirstOperatorActive = false;
      print("firstOperand $firstOperand");
    });
  }

  void buttonNumberAction(String number) {
    setState(() {
      if (isCalculeteDone) {
        print("dOne");
        screenString = "";
        isCalculeteDone = false;
      }
      if (!isFirstNumberTapped) {
        print("-");
        isFirstNumberTapped = true;
        isFirstOperatorActive = true;
        screenString = "$screenString$number";
      } else if (isFirstOperatorActive) {
        print("*");
        screenString = "$screenString$number";
      } else {
        if (!isSecondOperatorActive) {
          print("++");
          screenString = "";
          screenString = "$screenString$number";

          isSecondOperatorActive = true;
        } else {
          print("+-");
          screenString = "$screenString$number";
        }
      }
    });
  }
}

class buttons extends StatefulWidget {

  String sign;
  buttons({
    super.key,
    required this.sign
  });

  @override
  State<buttons> createState() => _buttonsState();
}

class _buttonsState extends State<buttons> {
  Color color=Colors.grey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: (){
        setState(() {
          color=Colors.orange;
        });

      },
      onLongPressEnd: (details){
        setState(() {
          color=Colors.grey;
        });
      },
      child: AnimatedContainer(
        color: color,
        duration: const Duration(milliseconds: 500),
        child: Center(
            child: Text(widget.sign,
                style: const TextStyle(fontSize: 40))),
      ),
    );
  }
}

double doCalculation(double firstOperand, double secondOperand, String Operator) {
  print(firstOperand);
  print(secondOperand);
  print(Operator);
  if (Operator == "+") {
    return firstOperand + secondOperand;
  } else if (Operator == "-")
    return firstOperand - secondOperand;
  else if (Operator == "/") {
    if (secondOperand == 0) {
      throw Exception("Divide by 0 Error");
    }
    return (firstOperand / secondOperand);
  } else if (Operator == "*")
    return (firstOperand * secondOperand);
  else if (Operator == "root") {
    if (firstOperand < 0) {
      throw Exception("Number Cant Be Negative!");
    } else {
      return sqrt(firstOperand);
    }
  } else
    return (firstOperand * firstOperand);
}