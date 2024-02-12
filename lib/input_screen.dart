import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'information_screen.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController beforeMealController = TextEditingController();
  final TextEditingController afterMealController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  String? gender;
  bool isPregnant = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Sugar Input'),
        backgroundColor: Color.fromARGB(250, 25, 25, 112),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              child: Icon(
                Icons.opacity,
                size: 40,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 10),
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
            SizedBox(height: 20),
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
              value: gender,
              hint: Text('Select Gender'),
              items: ['Male', 'Female'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  gender = value;
                  if (gender == 'Male') {
                    isPregnant = false; // Reset pregnancy status for male
                  }
                });
              },
            ),
            if (gender == 'Female') ...[
              SizedBox(height: 20),
              SwitchListTile(
                title: Text('Are you pregnant?'),
                value: isPregnant,
                onChanged: (bool value) {
                  setState(() {
                    isPregnant = value;
                  });
                },
              ),
            ],
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => validateAndNavigate(context),
              child: Text('Show Info'),
            ),
          ],
        ),
      ),
    );
  }

  void validateAndNavigate(BuildContext context) {
    final double? beforeMealValue = double.tryParse(beforeMealController.text);
    final double? afterMealValue = double.tryParse(afterMealController.text);
    final int? age = int.tryParse(ageController.text);

    if (beforeMealValue == null ||
        afterMealValue == null ||
        age == null ||
        gender == null) {
      Get.snackbar('Invalid Data', 'Please fill all fields correctly.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Proceed with your existing navigation logic here
    // For example, navigate to InformationScreen with the new data
  }
}
