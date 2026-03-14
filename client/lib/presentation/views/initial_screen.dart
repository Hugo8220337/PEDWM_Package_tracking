import 'package:client/config/dependency_injection.dart';
import 'package:client/presentation/viewmodels/initial_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // O ecrã principal apenas configura o Provider e o Scaffold.
    return ChangeNotifierProvider<InitialPageViewmodel>(
      create: (context) => DI.instance<InitialPageViewmodel>(), // Ask the DI for a new instance of the ViewModel
      child: const Scaffold(
        body: _InitialScreenBody(),
      ),
    );
  }
}

class _InitialScreenBody extends StatefulWidget {
  const _InitialScreenBody();

  @override
  State<_InitialScreenBody> createState() => _InitialScreenBodyState();
}

class _InitialScreenBodyState extends State<_InitialScreenBody> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose(); // Preventing memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // With the context.Wath  don't have to wrap all the code with a Consumer, makeing the code less uglier
    final viewmodel = context.watch<InitialPageViewmodel>();

    return Stack(
      children: [
        // Background Image
        Positioned.fill(
          child: Image.asset(
            'assets/images/initial_screen_background.png',
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
                  controller: _textController,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Ex: PT123456789',
                    border: OutlineInputBorder(),
                  ),
                ),
                
                const SizedBox(height: 10),

                // Input Button
                _SubmitButton(
                  isLoading: viewmodel.isLoading,
                  onPressed: (code) => viewmodel.submitTrackingCode(code),
                  getTrackingCode: () => _textController.text,
                  onSuccess: () {
                    Fluttertoast.showToast(
                      timeInSecForIosWeb: 2,
                      gravity: ToastGravity.CENTER,
                      toastLength: Toast.LENGTH_LONG,
                      msg: 'Feito com sucesso!',
                      webBgColor: 'linear-gradient(to right, #4CAF50, #81C784)',
                      textColor: Colors.white,
                    );
                  },
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
  final Future<void> Function(String) onPressed;
  final VoidCallback onSuccess;
  final String Function() getTrackingCode;

  const _SubmitButton({
    required this.isLoading,
    required this.onPressed,
    required this.onSuccess,
    required this.getTrackingCode,
  });

  void _handlePress() {
    if (!isLoading) { // Prevent dumbass users to spam the button while it's loading
      final trackingCode = getTrackingCode();
      onPressed(trackingCode).then((_) => onSuccess());
    }
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
