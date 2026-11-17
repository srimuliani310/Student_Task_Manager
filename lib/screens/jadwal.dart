import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: JadwalPage()),
  );
}

class JadwalPage extends StatelessWidget {
  const JadwalPage({super.key});

  static const Color maroon = Color(0xFF800020);
  static const Color pink = Color(0xFFFCE4EC);
  static const Color background = Color(0xFFFFF7F8);

  final List<Map<String, String>> daftarJadwal = const [
    {
      'matkul': 'Pemrograman Mobile',
      'dosen': 'Dr. Andi Saputra',
      'hari': 'Senin',
      'mulai': '08.00',
      'selesai': '10.00',
      'ruangan': 'A1',
    },
  ];

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

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Tombol Tambah Jadwal diklik'),
                    ),
                  );
                },
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
                child: const Icon(Icons.menu_book, color: maroon, size: 28),
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
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Tambah tugas untuk ${jadwal['matkul']}'),
                  ),
                );
              },
              icon: const Icon(Icons.add_task),
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
