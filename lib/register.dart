import 'package:flutter/material.dart';
import 'login.dart';
import 'user_data.dart'; // import untuk simpan data global

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // warna background ungu terong biar konsisten dengan login
        decoration: const BoxDecoration(
          color: Color(0xFF4B0082), // ungu terong
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              // biru muda transparan
              color: const Color.fromARGB(255, 182, 237, 244).withOpacity(0.85),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo sama seperti login
                      Image.asset("assets/logo.jpeg", height: 100),
                      const SizedBox(height: 20),
                      const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Email
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.email, color: Colors.white),
                          hintText: "Email Baru",
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintStyle: const TextStyle(color: Colors.white70),
                        ),
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email wajib diisi";
                          }
                          if (!value.contains("@")) {
                            return "Format email tidak valid";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Password
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.lock, color: Colors.white),
                          hintText: "Password Baru",
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintStyle: const TextStyle(color: Colors.white70),
                        ),
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password wajib diisi";
                          }
                          if (value.length < 6) {
                            return "Password minimal 6 karakter";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Konfirmasi Password
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline,
                              color: Colors.white),
                          hintText: "Konfirmasi Password",
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintStyle: const TextStyle(color: Colors.white70),
                        ),
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return "Password tidak sama";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),

                      // Tombol daftar
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // simpan ke global variable
                              registeredEmail = _emailController.text.trim();
                              registeredPassword =
                                  _passwordController.text.trim();

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Registrasi berhasil!")),
                              );

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.pink,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            "Daftar",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
