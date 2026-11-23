
import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  static const Color maroon = Color(0xFF800020);
  static const Color pink = Color(0xFFFCE4EC);
  static const Color background = Color(0xFFFFF7F8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          'Profil Saya',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: maroon,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 15),

            // Foto profil
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: maroon,
                  width: 3,
                ),
              ),
              child: const CircleAvatar(
                radius: 55,
                backgroundColor: pink,
                child: Icon(
                  Icons.person,
                  size: 65,
                  color: maroon,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Nama mahasiswa
            const Text(
              'Sri Muliani',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: maroon,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Mahasiswa Informatika',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            // Informasi mahasiswa
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: pink),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Informasi Mahasiswa',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: maroon,
                    ),
                  ),

                  const SizedBox(height: 20),

                  infoItem(
                    Icons.person_outline,
                    'Nama Lengkap',
                    'Sri Muliani',
                  ),

                  infoItem(
                    Icons.badge_outlined,
                    'NIM',
                    'D0225310',
                  ),

                  infoItem(
                    Icons.school_outlined,
                    'Program Studi',
                    'Informatika',
                  ),

                  infoItem(
                    Icons.groups_outlined,
                    'Kelas',
                    'Informatika A',
                  ),

                  infoItem(
                    Icons.account_balance_outlined,
                    'Universitas',
                    'Universitas Sulawesi Barat',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Tentang aplikasi
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: pink),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: maroon,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Tentang Aplikasi',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: maroon,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  Text(
                    'Student Task Manager merupakan aplikasi '
                    'untuk membantu mahasiswa mengelola jadwal '
                    'kuliah dan tugas agar kegiatan akademik '
                    'lebih teratur.',
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(height: 15),

                  Text(
                    'Versi Aplikasi: 1.0.0',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Student Task Manager © 2026',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  // Widget informasi profil
  Widget infoItem(
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: maroon,
            size: 22,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
