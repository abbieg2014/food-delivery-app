import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'password_reset_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController verificationEmailController = TextEditingController();
  bool isSignIn = true;
  bool showPassword = false;
  bool savePassword = false;
  bool isVerifyingEmail = false;
  String? tempEmail;
  String? tempUsername;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  void _loadSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('username');
    String? savedPassword = prefs.getString('password');

    if (savedUsername != null && savedPassword != null) {
      usernameController.text = savedUsername;
      passwordController.text = savedPassword;
      setState(() {
        savePassword = true;
      });
    }
  }

  void toggleAuthMode() {
    setState(() {
      isSignIn = !isSignIn;
      isVerifyingEmail = false;
    });
  }

  void toggleShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  Future<void> signIn() async {
    try {
      // Fetch the email associated with the username
      String username = usernameController.text;
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(username).get();

      if (userDoc.exists) {
        String email = userDoc.get('email');

        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: passwordController.text,
        );

        if (userCredential.user != null && userCredential.user!.emailVerified) {
          if (savePassword) {
            _saveCredentials();
          } else {
            _clearCredentials();
          }
          setState(() {
            isVerifyingEmail = true;
            tempUsername = username;
            tempEmail = email;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please verify your email to continue.'),
            ),
          );
          await _auth.signOut();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Username not found.'),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      print("Sign in error: ${e.message}");
      Navigator.pushReplacementNamed(context, '/error');
    }
  }

  Future<void> verifyEmail() async {
    if (verificationEmailController.text == tempEmail) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email verification failed. Please enter the correct email.'),
        ),
      );
    }
  }

  Future<void> signUp() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      await userCredential.user?.sendEmailVerification();

      // Store the username, email, and user ID in Firestore
      await _firestore.collection('users').doc(usernameController.text).set({
        'email': emailController.text,
        'uid': userCredential.user?.uid,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verification email sent. Please check your inbox.'),
        ),
      );
      await _auth.signOut();
      setState(() {
        isSignIn = true;
      });
    } on FirebaseAuthException catch (e) {
      print("Sign up error: ${e.message}");
      Navigator.pushReplacementNamed(context, '/error');
    }
  }

  void _saveCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', usernameController.text);
    await prefs.setString('password', passwordController.text);
  }

  void _clearCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade200,
      body: Column(
        children: [
          Expanded(child: Container()), // This will push the content to the bottom
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (!isVerifyingEmail)
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.asset('assets/images/login_register.png'),
                      ),
                      const SizedBox(height: 25),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Food Delivery App',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                if (isVerifyingEmail) ...[
                  const Text('Please verify by entering the email associated with your account:'),
                  TextField(
                    controller: verificationEmailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      filled: true,
                      fillColor: Colors.orangeAccent,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: verifyEmail,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, // Set the background color to orange
                    ),
                    child: const Text('Verify Email'),
                  ),
                ] else ...[
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      filled: true,
                      fillColor: Colors.orangeAccent,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  if (!isSignIn)
                    const SizedBox(height: 5),
                  if (!isSignIn)
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.orangeAccent,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: passwordController,
                    obscureText: !showPassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.orangeAccent,
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
                        onPressed: toggleShowPassword,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: savePassword,
                        onChanged: (bool? value) {
                          setState(() {
                            savePassword = value ?? false;
                          });
                        },
                      ),
                      const Text('Save password'),
                    ],
                  ),
                  const SizedBox(height: 0),
                  ElevatedButton(
                    onPressed: isSignIn ? signIn : signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade400, // Set the background color to orange
                    ),
                    child: Text(isSignIn ? 'Sign In' : 'Sign Up'),
                  ),
                  TextButton(
                    onPressed: toggleAuthMode,
                    child: Text(isSignIn ? 'Don\'t have an account? Sign Up' : 'Already have an account? Sign In'),
                  ),
                  if (isSignIn)
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PasswordResetPage()),
                        );
                      },
                      child: const Text('Forgot Password?'),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
