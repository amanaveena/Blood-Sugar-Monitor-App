import 'package:flutter/material.dart';

class InformationScreen extends StatelessWidget {
  final int age;
  final String gender;
  final bool isPregnant;
  final double beforeMealValue;
  final double afterMealValue;

  InformationScreen({
    required this.age,
    required this.gender,
    required this.isPregnant,
    required this.beforeMealValue,
    required this.afterMealValue,
  });

  @override
  Widget build(BuildContext context) {
    String category = determineCategory();
    String comment = getComment(category);

    IconData iconData = Icons.info; // Default icon
    Color iconColor = Colors.white; // Default icon color

    // Determine icon and color based on category
    switch (category) {
      case 'Normal':
        iconData = Icons.check_circle;
        iconColor = Colors.green;
        break;
      case 'Type 1 Diabetics':
        iconData = Icons.error_outline;
        iconColor = Colors.red;
        break;
      case 'Type 2 Diabetics':
        iconData = Icons.warning;
        iconColor = Colors.yellow;
        break;
      case 'Consult Doctor':
        iconData = Icons.error;
        iconColor = Colors.orange;
        break;
      default:
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Result',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor:
            Color.fromARGB(249, 30, 30, 61), // Change the app bar color here
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 64,
              color: iconColor,
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(44),
              margin: EdgeInsets.all(66),
              decoration: BoxDecoration(
                color: Color.fromARGB(249, 30, 30, 61),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    ' $category',
                    style: TextStyle(
                        fontSize: 35, color: Color.fromARGB(255, 6, 92, 16)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color.fromARGB(249, 30, 30, 61),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  getCommentWidget(comment),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCommentWidget(String comment) {
    return comment.isEmpty
        ? SizedBox.shrink()
        : Text(
            comment,
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: Color.fromARGB(255, 246, 248, 251),
            ),
            textAlign: TextAlign.justify,
          );
  }

  String determineCategory() {
    if (isPregnant) {
      if (beforeMealValue >= 70 &&
          beforeMealValue <= 95 &&
          afterMealValue >= 95 &&
          afterMealValue <= 120) {
        return 'Normal';
      } else if (beforeMealValue > 95 &&
          beforeMealValue < 120 &&
          afterMealValue >= 120 &&
          afterMealValue < 199) {
        return 'Type 01 Diabetics';
      } else if (beforeMealValue < 70 || afterMealValue < 70) {
        return 'Low Sugar';
      } else if (beforeMealValue > 240 || afterMealValue > 240) {
        return 'High Sugar';
      } else {
        return 'Consult Doctor';
      }
    } else {
      if (age <= 17) {
        if (beforeMealValue >= 70 &&
            beforeMealValue <= 90 &&
            afterMealValue >= 90 &&
            afterMealValue <= 130) {
          return 'Normal';
        } else if (beforeMealValue >= 100 &&
            beforeMealValue >= 90 &&
            beforeMealValue <= 130 &&
            afterMealValue >= 130 &&
            afterMealValue <= 170) {
          return 'Type 1 Diabetics';
        } else if (beforeMealValue >= 130 || afterMealValue >= 170) {
          return 'High Sugar';
        } else if (beforeMealValue < 70 || afterMealValue < 100) {
          return 'low sugar';
        }
      } else if (age >= 18 && age < 65) {
        if (beforeMealValue >= 70 &&
            beforeMealValue <= 100 &&
            afterMealValue >= 100 &&
            afterMealValue <= 140) {
          return 'Normal';
        } else if (beforeMealValue >= 100 &&
            beforeMealValue <= 125 &&
            afterMealValue >= 140 &&
            afterMealValue <= 199) {
          return 'Type 1 Diabetics';
        } else if (beforeMealValue >= 126 || afterMealValue >= 200) {
          return 'Type 2 Diabetics';
        }
      } else if (age >= 65) {
        if (beforeMealValue >= 70 &&
            beforeMealValue <= 100 &&
            afterMealValue <= 140 &&
            afterMealValue >= 100) {
          return 'Normal';
        }
      }
    }

    return 'Diabetes';
  }

  String getComment(String category) {
    if (beforeMealValue < 70 || afterMealValue < 70) {
      return "Your sugar level is low. It's important to consult a doctor promptly for further evaluation and appropriate management.";
    } else if (beforeMealValue > 240 || afterMealValue > 240) {
      return "Your sugar level is high. It's crucial to consult a doctor promptly for further evaluation and personalized management to safeguard your health.";
    }

    if (age <= 17) {
      if (beforeMealValue < 70 || afterMealValue < 100) {
        return "Your one of the Sugar Level Is Low Please Check ";
      } else if (beforeMealValue > 90 || afterMealValue > 130) {
        return "your one of the Suagr level is High Please Check";
      }
    }

    if (age >= 18 && age < 65) {
      if (beforeMealValue < 70 || afterMealValue < 100) {
        return "Your one of the Sugar Level Is Low Please Check ";
      } else if (beforeMealValue > 100 || afterMealValue > 199) {
        return "your one of the Suagr level is High Please Check";
      }
    }
    if (age >= 65) {
      if (beforeMealValue < 70 || afterMealValue < 100) {
        return "Your one of the Sugar Level Is Low Please Check ";
      } else if (beforeMealValue > 100 || afterMealValue > 140) {
        return "your one of the Suagr level is High Please Check";
      }
    }

    if (isPregnant) {
      if (beforeMealValue < 70 || afterMealValue < 95) {
        return "Your one of the Sugar Level Is Low Please Check ";
      } else if (beforeMealValue > 95 || afterMealValue > 120) {
        return "your one of the Suagr level is High Please Check";
      }
    }

    if (isPregnant) {
      if (category == 'Normal') {
        return "Congratulations! Your sugar level is normal, which is excellent news for you and your baby's health. Keep up with your prenatal care routine and healthy lifestyle choices!";
      } else {
        return "Your sugar level is out of range. It's essential to consult a doctor promptly to ensure the best outcome for both you and your baby.";
      }
    }
    switch (category) {
      case 'Normal':
        if (age <= 17) {
          return "Great news! Your child's sugar level is within the normal range. Keep up the good work with their health and nutrition!";
        } else if (age >= 18 && age < 65) {
          return "Fantastic news! Your sugar level is within the normal range. Keep up the good work with your health and well-being!";
        } else if (age >= 65) {
          return "Great news! Despite your age, your sugar level is within the normal range. Keep prioritizing your health with regular check-ups and healthy habits!";
        }
        break;
      case 'Type 1 Diabetics':
        if (age <= 17) {
          return "Your child's sugar level suggests Type 1 diabetes. Please seek medical advice promptly";
        } else if (age >= 18 && age <= 65) {
          return "I'm sorry to inform you that your sugar level indicates Type 1 diabetes. Please consult with a healthcare professional promptly for personalized management and support";
        } else if (age > 65) {
          return "Considering your age, it's concerning to have a sugar level like this. Please contact a doctor immediately for urgent medical attention.";
        } else if (isPregnant) {
          return "";
        }
        break;
      case 'Type 2 Diabetics':
        if (age >= 18 && age <= 65) {
          return "I'm sorry to inform you that your sugar level indicates Type 2 diabetes. It's important to consult with a healthcare professional promptly to discuss management strategies and lifestyle adjustments for better health.";
        } else if (age >= 65) {
          return "'Considering your age, it's concerning to have a sugar level like this. Please contact a doctor immediately for urgent medical attention.'";
        }
      case 'Diabetes':
        if (age >= 65) {
          return "Considering your age, it's concerning to have a sugar level like this. Please contact a doctor immediately for urgent medical attention.";
        }
      default:
        break;
    }

    return ''; // Return an empty string as default
  }
}
