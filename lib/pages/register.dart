// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triumph2/provider/theme.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  String _selectedGender = 'Not Telling';
  final List<String> _genders = ['Not Telling', 'Male', 'Female'];
  IconData _selectedIcon = Icons.person;
  bool _agreedToTerms = false;
  bool _isButtonEnabled = false;

  void _updateSelectedIcon() {
    switch (_selectedGender) {
      case 'Male':
        _selectedIcon = Icons.male;
        break;
      case 'Female':
        _selectedIcon = Icons.female;
        break;
      case 'Not Telling':
        _selectedIcon = Icons.remove;
        break;
      default:
        _selectedIcon = Icons.person;
        break;
    }
  }

  String _emailErrorText = '';
  String _passwordErrorText = '';
  String _confirmPasswordErrorText = '';

  void _validateForm() {
    // Reset pesan kesalahan sebelum validasi dilakukan
    setState(() {
      _emailErrorText = '';
      _passwordErrorText = '';
      _confirmPasswordErrorText = '';
    });

    // Validasi email
    bool isEmailValid = _emailController.text.isNotEmpty &&
        RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
            .hasMatch(_emailController.text);
    if (!isEmailValid) {
      setState(() {
        _emailErrorText = 'Invalid email address';
      });
    }

    // Validasi password
    String passwordPattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{5,}$';
    bool isPasswordValid = _passwordController.text.isNotEmpty &&
        RegExp(passwordPattern).hasMatch(_passwordController.text);
    if (!isPasswordValid) {
      setState(() {
        _passwordErrorText = 'Min 5 characters (upper,lower,digit,special)';
      });
    }

    // Validasi konfirmasi password
    bool isConfirmPasswordValid = _confirmPasswordController.text.isNotEmpty &&
        _confirmPasswordController.text == _passwordController.text;
    if (!isConfirmPasswordValid) {
      setState(() {
        _confirmPasswordErrorText = 'Passwords do not match';
      });
    }

    // Validasi checkbox agree
    bool isAgreeChecked = _agreedToTerms;

    // Tombol hanya aktif jika semua validasi terpenuhi
    setState(() {
      _isButtonEnabled = isEmailValid &&
          isPasswordValid &&
          isConfirmPasswordValid &&
          isAgreeChecked;
    });
  }

  void _handleRegister() {
    // Handle register logic here
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      ModalRoute.withName('/'),
      arguments: {
        'line1': 'Your account has been created successfully',
        'line2': 'Try login with your new account',
      },
    );
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final ThemeData themeData = themeProvider.getCurrentTheme();
    final Color textColor = themeData.textTheme.bodyLarge!.color!;
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: themeProvider.enableDarkMode
              ? Colors.grey.shade900
              : Colors.white,
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
          pinned: true,
          floating: false,
        ),
        SliverFillRemaining(
            child: (Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: themeProvider.enableDarkMode
                  ? [Colors.grey.shade800, Colors.red.shade800]
                  : [Colors.red.shade200, Colors.red.shade400],
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                            onChanged: (value) {
                              _validateForm(); // Validasi email saat nilai berubah
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: textColor),
                              ),
                              hintText: 'Enter your email',
                              hintStyle: TextStyle(color: textColor),
                              prefixIcon: Icon(Icons.email, color: textColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          _emailErrorText,
                          style: TextStyle(
                              color: Colors.white, backgroundColor: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'First Name',
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
                            style: TextStyle(color: textColor),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: textColor),
                              ),
                              hintText: 'Enter your first name',
                              hintStyle: TextStyle(color: textColor),
                              prefixIcon:
                                  Icon(Icons.person_outline, color: textColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Last Name',
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
                            style: TextStyle(color: textColor),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: textColor),
                              ),
                              hintText: 'Enter your last name',
                              hintStyle: TextStyle(color: textColor),
                              prefixIcon:
                                  Icon(Icons.person_outline, color: textColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Gender',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedGender,
                            items: _genders.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedGender = newValue!;
                                _updateSelectedIcon();
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: textColor),
                              ),
                              hintText: 'Select gender',
                              hintStyle: TextStyle(color: textColor),
                              prefixIcon: Icon(
                                // Menggunakan prefixIcon di sini
                                _selectedIcon,
                                color: textColor,
                              ),
                            ),
                            style: TextStyle(color: textColor),
                            dropdownColor: themeProvider.enableDarkMode
                                ? Colors.grey.shade800
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Username',
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
                            style: TextStyle(color: textColor),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: textColor),
                              ),
                              hintText: 'Enter your username',
                              hintStyle: TextStyle(color: textColor),
                              prefixIcon: Icon(Icons.person, color: textColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Password',
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
                            controller: _passwordController,
                            style: TextStyle(color: textColor),
                            obscureText: true,
                            onChanged: (value) {
                              // Validasi password saat nilai berubah
                              _validateForm(); // Validasi email
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: textColor),
                              ),
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(color: textColor),
                              prefixIcon:
                                  Icon(Icons.lock_outline, color: textColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          _passwordErrorText,
                          style: TextStyle(
                              color: Colors.white, backgroundColor: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Confirm Password',
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
                            controller: _confirmPasswordController,
                            style: TextStyle(color: textColor),
                            obscureText: true,
                            onChanged: (value) {
                              // Validasi password saat nilai berubah
                              _validateForm(); // Validasi email
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: textColor),
                              ),
                              hintText: 'Confirm your password',
                              hintStyle: TextStyle(color: textColor),
                              prefixIcon: Icon(Icons.lock, color: textColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          _confirmPasswordErrorText,
                          style: TextStyle(
                              color: Colors.white, backgroundColor: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _agreedToTerms,
                          onChanged: (bool? value) {
                            setState(() {
                              _agreedToTerms = value!;
                              _validateForm();
                            });
                          },
                          fillColor: WidgetStateProperty.all<Color>(textColor),
                        ),
                        Text(
                          'I agree to the terms of service',
                          style: TextStyle(color: textColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: _isButtonEnabled
                          ? () {
                              _handleRegister();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: Size(200, 50)),
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(fontSize: 15.0, color: textColor),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )))
      ],
    ));
  }
}
