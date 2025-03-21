import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_easy_recaptcha_v2/flutter_easy_recaptcha_v2.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo flutter_easy_recaptcha_v2 ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Demo flutter_easy_recaptcha_v2 '),
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
  void _showRecaptchaBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 700,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    weight: 20,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SizedBox(
                height: 600,
                child: RecaptchaV2(
                  // Your API Key
                  apiKey: "Your api key",
                  onVerifiedSuccessfully: (token) async {
                    log("Recaptcha token $token");
                    // It is recommended to verify the token on your server but you can also verify it here.
                    final bool isTokenVerified = await verifyRecaptchaV2Token(
                      token: token,
                      apiSecret: "Your api secret",
                    );
                    if (isTokenVerified) {
                      log("Token verified successfully");
                      // Implement your logic here
                    } else {
                      log("Token verification failed");
                      // Implement your logic here
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Tap on the button to show the RecaptchaV2 Screen',
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        onPressed: () {
          _showRecaptchaBottomSheet(context);
        },
        child: Text(
          "Show RecaptchaV2",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}
