import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'information_screen.dart';

void main() {
  runApp(BloodSugarMonitorApp());
}

class BloodSugarMonitorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Blood Sugar Monitor',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        hintColor: Colors.white,
        fontFamily: 'Georgia',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
        scaffoldBackgroundColor: Color.fromARGB(255, 10, 10, 35),
      ),
      home: InputScreen(),
    );
  }
}

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController beforeMealController = TextEditingController();
  final TextEditingController afterMealController = TextEditingController();

  String? selectedGender; // Change to nullable
  bool isPregnant = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Sugar Monitor',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        centerTitle: true,
        backgroundColor: Color.fromARGB(249, 30, 30, 61),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            // Use Stack to position the blood drop icon
            children: [
              Positioned(
                top: 40, // Position the icon at the top
                left: 0, // Align the icon to the left
                right: 0, // Align the icon to the right
                child: Image.asset(
                  'assets/blood_drop_icon.png', // Load the blood drop icon
                  height: 160, // Set the height of the icon
                  fit: BoxFit.fitHeight, // Ensure the icon fits its height
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 200), // Add padding for the icon
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: ageController,
                      decoration: InputDecoration(
                        labelText: 'Age',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: selectedGender, // Provide initial value
                      hint: Text('Select Gender'),
                      items: ['Male', 'Female'].map((String gender) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                          isPregnant =
                              false; // Reset pregnancy status when changing gender
                        });
                      },
                    ),
                    if (selectedGender == 'Female') ...[
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(
                            value: isPregnant,
                            onChanged: (value) {
                              setState(() {
                                isPregnant = value ?? false;
                              });
                            },
                          ),
                          Text('Are you pregnant?'),
                        ],
                      ),
                    ],
                    SizedBox(height: 20),
                    TextField(
                      controller: beforeMealController,
                      decoration: InputDecoration(
                        labelText: 'Before Meal (mg/dL)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: afterMealController,
                      decoration: InputDecoration(
                        labelText: 'After Meal (mg/dL)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () => validateAndNavigate(context),
                      child: Text('Show Info'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validateAndNavigate(BuildContext context) {
    final int? age = int.tryParse(ageController.text);
    final double? beforeMealValue = double.tryParse(beforeMealController.text);
    final double? afterMealValue = double.tryParse(afterMealController.text);

    if (age == null ||
        beforeMealValue == null ||
        afterMealValue == null ||
        selectedGender == null) {
      Get.snackbar('Invalid Data', 'Please enter valid a number.',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.to(() => InformationScreen(
            age: age,
            gender: selectedGender!,
            isPregnant: isPregnant,
            beforeMealValue: beforeMealValue,
            afterMealValue: afterMealValue,
          ));
    }
  }
}
