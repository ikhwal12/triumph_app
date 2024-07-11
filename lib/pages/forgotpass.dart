// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triumph2/provider/theme.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPass();
}

class _ForgotPass extends State<ForgotPass> {
  String _email = '';
  bool _isButtonEnabled = false;
  final TextEditingController _emailController = TextEditingController();
  String? _emailErrorText;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _validateEmail(String email) {
    if (email.isEmpty) {
      setState(() {
        _emailErrorText = 'Email cannot be empty';
        _isButtonEnabled =
            false; // Tidak ada email yang valid, tombol dinonaktifkan
      });
    } else if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
        .hasMatch(email)) {
      setState(() {
        _emailErrorText = 'Enter a valid email';
        _isButtonEnabled =
            false; // Format email tidak valid, tombol dinonaktifkan
      });
    } else {
      setState(() {
        _emailErrorText = null;
        _isButtonEnabled = true; // Email valid, tombol diaktifkan
      });
    }
  }

  void _handleSendCode() {
    if (_emailErrorText == null) {
      // Jika email valid, lanjutkan dengan mengirim kode
      Navigator.pushNamed(context, '/verify');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final ThemeData themeData = themeProvider.getCurrentTheme();
    final Color textColor = themeData.textTheme.bodyLarge!.color!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            themeProvider.enableDarkMode ? Colors.grey.shade900 : Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.red,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Image.asset(
          'assets/logo.png',
          width: 250,
          // height: 3000,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              themeProvider.enableDarkMode = !themeProvider.enableDarkMode;
            },
            icon: Icon(
              themeProvider.enableDarkMode
                  ? Icons.wb_sunny
                  : Icons.nightlight_round,
              color:
                  themeProvider.enableDarkMode ? Colors.yellow : Colors.black,
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: themeProvider.enableDarkMode
                  ? [Colors.grey.shade800, Colors.red.shade800]
                  : [Colors.red.shade200, Colors.red.shade400],
            ),
          ),
          padding: EdgeInsets.all(10),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red,
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Text(
              "Forgot Password?",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 30, color: textColor),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Text(
                  'E-mail',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: _emailController,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: textColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      errorStyle: TextStyle(
                        backgroundColor: Colors.red,
                        color: Colors.white,
                      ),
                      hintText: 'Enter your e-mail',
                      hintStyle: TextStyle(color: textColor),
                      errorText: _emailErrorText,
                      prefixIcon: Icon(
                        Icons.email,
                        color: textColor,
                      )),
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                      _isButtonEnabled = _email
                          .isNotEmpty; // Tombol aktif jika email tidak kosong
                    });
                    _validateEmail(value);
                  },
                ))
              ],
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed:
                  _isButtonEnabled // Atur fungsi onPressed berdasarkan keadaan tombol
                      ? () {
                          _handleSendCode();
                        }
                      : null,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, minimumSize: Size(200, 50)),
              child: Text(
                'Send Code',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Back to',
                  style: TextStyle(color: textColor),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.blue),
                    )),
                Text("/"),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.blue),
                    )),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
