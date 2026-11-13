import 'package:flutter/material.dart';

import 'home_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const Color primaryMaroon = Color(0xFF7D1128);
  static const Color darkButtonMaroon = Color(0xFF470815);
  static const Color softPinkWave = Color(0xFFF3C6D0);
  static const Color lightPinkWave = Color(0xFFFCEEF1);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primaryMaroon,
      body: Stack(
        children: [
          // 1. Gelombang Dekoratif Bagian Atas
          Positioned(
            top: -58,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(size.width, 130),
              painter: TopWavePainter(
                backWaveColor: softPinkWave,
                frontWaveColor: lightPinkWave,
              ),
            ),
          ),

          // 2. Gelombang Dekoratif Bagian Bawah
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(size.width, 85),
              painter: BottomWavePainter(
                backWaveColor: softPinkWave,
                frontWaveColor: lightPinkWave,
              ),
            ),
          ),

          // 3. Konten Utama di Tengah Layar
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),

                    // Ikon Toga Wisuda & Buku Terbuka
                    const CustomPaint(
                      size: Size(115, 130),
                      painter: GraduationBookPainter(color: Colors.white),
                    ),
                    const SizedBox(height: 28),

                    // Judul Utama
                    const Text(
                      'Student\nTask Manager',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        height: 1.18,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Subjudul / Tagline
                    const Text(
                      'Plan • Organize • Achieve',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Tombol "Get Started ->"
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: darkButtonMaroon,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: const StadiumBorder(),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Get Started',
                              style: TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward,
                              size: 17,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TopWavePainter extends CustomPainter {
  final Color backWaveColor;
  final Color frontWaveColor;

  TopWavePainter({required this.backWaveColor, required this.frontWaveColor});

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;

    final Paint backPaint = Paint()
      ..color = backWaveColor
      ..style = PaintingStyle.fill;

    final Path backPath = Path()
      ..moveTo(0, 44)
      ..lineTo(w, 44)
      ..lineTo(w, 92)
      ..cubicTo(w * 0.72, 108, w * 0.32, 74, 0, 92)
      ..close();

    canvas.drawPath(backPath, backPaint);

    final Paint frontPaint = Paint()
      ..color = frontWaveColor
      ..style = PaintingStyle.fill;

    final Path frontPath = Path()
      ..moveTo(0, 62)
      ..lineTo(w, 62)
      ..lineTo(w, 98)
      ..cubicTo(w * 0.68, 122, w * 0.30, 82, 0, 102)
      ..close();

    canvas.drawPath(frontPath, frontPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BottomWavePainter extends CustomPainter {
  final Color backWaveColor;
  final Color frontWaveColor;

  BottomWavePainter({
    required this.backWaveColor,
    required this.frontWaveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final Paint backPaint = Paint()
      ..color = backWaveColor
      ..style = PaintingStyle.fill;

    final Path backPath = Path()
      ..moveTo(0, h * 0.25)
      ..cubicTo(w * 0.32, h * 0.65, w * 0.68, h * 0.05, w, h * 0.35)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();

    canvas.drawPath(backPath, backPaint);

    final Paint frontPaint = Paint()
      ..color = frontWaveColor
      ..style = PaintingStyle.fill;

    final Path frontPath = Path()
      ..moveTo(0, h * 0.55)
      ..cubicTo(w * 0.35, h * 0.85, w * 0.70, h * 0.35, w, h * 0.55)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();

    canvas.drawPath(frontPath, frontPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class GraduationBookPainter extends CustomPainter {
  final Color color;

  const GraduationBookPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final double w = size.width;
    final double h = size.height;
    final double cx = w / 2;

    final Path capTop = Path()
      ..moveTo(cx, h * 0.04)
      ..lineTo(w * 0.90, h * 0.19)
      ..lineTo(cx, h * 0.34)
      ..lineTo(w * 0.10, h * 0.19)
      ..close();
    canvas.drawPath(capTop, strokePaint);

    final Path capBase = Path()
      ..moveTo(w * 0.27, h * 0.26)
      ..lineTo(w * 0.27, h * 0.39)
      ..quadraticBezierTo(cx, h * 0.48, w * 0.73, h * 0.39)
      ..lineTo(w * 0.73, h * 0.26);
    canvas.drawPath(capBase, strokePaint);

    final Path tassel = Path()
      ..moveTo(w * 0.86, h * 0.21)
      ..lineTo(w * 0.86, h * 0.37);
    canvas.drawPath(tassel, strokePaint);

    final double bookTopY = h * 0.54;
    final double bookBottomY = h * 0.92;
    final double leftX = w * 0.13;
    final double rightX = w * 0.87;

    final Path leftPage = Path()
      ..moveTo(cx, bookTopY + 6)
      ..quadraticBezierTo(w * 0.32, bookTopY - 6, leftX, bookTopY + 4)
      ..lineTo(leftX, bookBottomY)
      ..quadraticBezierTo(w * 0.32, bookBottomY - 10, cx, bookBottomY + 4)
      ..close();
    canvas.drawPath(leftPage, strokePaint);

    final Path rightPage = Path()
      ..moveTo(cx, bookTopY + 6)
      ..quadraticBezierTo(w * 0.68, bookTopY - 6, rightX, bookTopY + 4)
      ..lineTo(rightX, bookBottomY)
      ..quadraticBezierTo(w * 0.68, bookBottomY - 10, cx, bookBottomY + 4)
      ..close();
    canvas.drawPath(rightPage, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
