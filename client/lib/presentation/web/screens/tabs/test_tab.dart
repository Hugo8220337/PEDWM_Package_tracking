import 'package:flutter/material.dart';

class TestTab extends StatelessWidget {
  const TestTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Positioned.fill(child: Image.asset(
          'assets/images/testTab_Background.png',
          fit: BoxFit.cover,
        )),

        // Content
        Center(
          child: SizedBox(
            height: 200,
            width: 300,
            child: Column(
              children: [
                // TextBox Input
                TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Ex: PT123456789',
                    border: OutlineInputBorder(),
                  ),
                ),

                // Spacer
                const SizedBox(height: 10),

                // Input Button
                SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      print("Button Pressed");
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
