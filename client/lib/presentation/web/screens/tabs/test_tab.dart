import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TestTab extends StatefulWidget {
  const TestTab({super.key});

  @override
  State<TestTab> createState() => _TestTabState();
}

class _TestTabState extends State<TestTab> {

  var _isLoading = false;

  void _onSubmit() {
    setState(() => _isLoading = true);
    Future.delayed(
      const Duration(seconds: 2),
      () => setState(() => _isLoading = false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Positioned.fill(
          child: Image.asset(
            'assets/images/testTab_Background.png',
            fit: BoxFit.cover,
          ),
        ),

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
                _SubmitButton(
                  isLoading: _isLoading,
                  onPressed: _onSubmit,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const _SubmitButton({
    required this.isLoading,
    required this.onPressed,
  });

  void _handlePress() {
    if (!isLoading) {
      onPressed();
    }

    Fluttertoast.showToast(
      timeInSecForIosWeb: 2,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
      webPosition: 'center',
      msg: 'Feito com sucesso!',
      webBgColor: 'linear-gradient(to right, #4CAF50, #81C784)',
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
        onPressed: _handlePress,
        child: isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : const Text('Submit'),
      ),
    );
  }
}
