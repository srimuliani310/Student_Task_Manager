import 'package:flutter/material.dart';

import 'tambah_jadwal.dart';
import 'tambah_tugas.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  static const Color maroon = Color(0xFF800020);
  static const Color pink = Color(0xFFFCE4EC);
  static const Color background = Color(0xFFFFF7F8);

  // Data jadwal awal
  final List<Map<String, String>> daftarJadwal = [
    {
      'matkul': 'Pemrograman Mobile',
      'dosen': 'Dr. Andi Saputra',
      'hari': 'Senin',
      'mulai': '08.00',
      'selesai': '10.00',
      'ruangan': 'A1',
    },
  ];

  // Membuka halaman tambah jadwal
  Future<void> bukaFormJadwal() async {
    final hasil = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(builder: (context) => const TambahJadwalPage()),
    );

    if (hasil != null) {
      setState(() {
        daftarJadwal.add(hasil);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          'Jadwal Kuliah',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: maroon,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daftar Mata Kuliah',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: maroon,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Kelola jadwal dan tugas dari setiap mata kuliah.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Tombol tambah jadwal
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: bukaFormJadwal,
                icon: const Icon(Icons.add),
                label: const Text('Tambah Jadwal'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: maroon,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Menampilkan daftar jadwal
            ...daftarJadwal.map((jadwal) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: jadwalCard(context, jadwal),
              );
            }),
          ],
        ),
      ),
    );
  }

  // Tampilan kartu jadwal
  Widget jadwalCard(BuildContext context, Map<String, String> jadwal) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: pink),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: pink,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  'assets/images/book.png',
                  width: 28,
                  height: 28,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  jadwal['matkul']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: maroon,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          infoRow(Icons.person_outline, jadwal['dosen']!),
          const SizedBox(height: 8),

          infoRow(
            Icons.calendar_today_outlined,
            '${jadwal['hari']}, ${jadwal['mulai']} - ${jadwal['selesai']}',
          ),
          const SizedBox(height: 8),

          infoRow(Icons.location_on_outlined, 'Ruang ${jadwal['ruangan']}'),

          const SizedBox(height: 15),
          const Divider(color: pink),

          // Tombol tambah tugas
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () async {
                final hasil = await Navigator.push<Map<String, String>>(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TambahTugasPage(namaMatkul: jadwal['matkul']),
                  ),
                );

                if (hasil != null) {
                  print(hasil);
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Tambah Tugas'),
              style: OutlinedButton.styleFrom(
                foregroundColor: maroon,
                side: const BorderSide(color: maroon),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Menampilkan informasi jadwal
  Widget infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: maroon),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}
