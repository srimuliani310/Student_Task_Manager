import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Warna sesuai desain gambar pertama
    const Color darkMaroonBg = Color(0xFF6B1325);
    const Color buttonMaroon = Color(0xFF7F1D32);
    const Color subtitleCream = Color(0xFFE6C8CE);

    return Scaffold(
      backgroundColor: darkMaroonBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 32.0),
          child: Column(
            children: [
              const Spacer(flex: 2),
                            // Logo Gambar (Topi Toga + Buku)
              Image.asset(
                'assets/images/image.png',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
              
              const SizedBox(height: 32),
              // Judul Utama
              const Text(
                'Student\nTask Manager',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 14),
              // Subjudul
              const Text(
                'Plan • Organize • Achieve',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: subtitleCream,
                  letterSpacing: 0.8,
                ),
              ),
              const Spacer(flex: 3),
              // Tombol "Get Started ->"
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Tambahkan navigasi ke halaman Beranda di sini
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonMaroon,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: BorderSide(
                        color: Colors.white.withOpacity(0.25),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
