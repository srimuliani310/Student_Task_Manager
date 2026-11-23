import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/task.dart';

class TambahTugasPage extends StatefulWidget {
  final String? namaMatkul;

  const TambahTugasPage({super.key, this.namaMatkul});

  @override
  State<TambahTugasPage> createState() => _TambahTugasPageState();
}

class _TambahTugasPageState extends State<TambahTugasPage> {
  static const Color maroon = Color(0xFF800020);
  static const Color pink = Color(0xFFFCE4EC);
  static const Color background = Color(0xFFFFF7F8);

  final TextEditingController namaController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  String? matkulDipilih;
  String prioritas = 'Sedang';
  DateTime? deadline;

  final List<String> daftarMatkul = [
    'Pemrograman Mobile',
    'Basis Data',
    'Pemrograman Berorientasi Objek',
    'Dasar-Dasar Pemrograman',
  ];

  @override
  void initState() {
    super.initState();

    matkulDipilih = widget.namaMatkul;
  }

  @override
  void dispose() {
    namaController.dispose();
    deskripsiController.dispose();
    super.dispose();
  }

  Future<void> pilihDeadline() async {
    final tanggal = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: maroon,
              onPrimary: Colors.white,
              surface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (tanggal != null) {
      setState(() {
        deadline = tanggal;
      });
    }
  }

  Future<void> simpanTugas() async {
    if (namaController.text.trim().isEmpty ||
        matkulDipilih == null ||
        deadline == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lengkapi nama tugas, mata kuliah, dan deadline!'),
        ),
      );
      return;
    }

    final task = Task(
      title: namaController.text.trim(),
      description: deskripsiController.text.trim(),
      deadline: '${deadline!.day}/${deadline!.month}/${deadline!.year}',
    );

    await DatabaseHelper.instance.insertTask(task);

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Tugas berhasil disimpan!')));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          'Tambah Tugas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: maroon,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Buat Tugas Baru',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: maroon,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Masukkan informasi tugas kuliah kamu.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),

            const SizedBox(height: 25),

            buildLabel('Nama Tugas'),

            TextField(
              controller: namaController,
              decoration: inputDecoration(
                'Contoh: Membuat laporan praktikum',
                Icons.assignment_outlined,
              ),
            ),

            const SizedBox(height: 18),

            buildLabel('Mata Kuliah'),

            DropdownButtonFormField<String>(
              value: matkulDipilih,
              isExpanded: true,
              decoration: inputDecoration('Pilih mata kuliah', Icons.menu_book),
              items: daftarMatkul.map((matkul) {
                return DropdownMenuItem(value: matkul, child: Text(matkul));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  matkulDipilih = value;
                });
              },
            ),

            const SizedBox(height: 18),

            buildLabel('Deskripsi Tugas'),

            TextField(
              controller: deskripsiController,
              maxLines: 4,
              decoration: inputDecoration(
                'Tuliskan detail tugas...',
                Icons.description_outlined,
              ),
            ),

            const SizedBox(height: 18),

            buildLabel('Deadline'),

            InkWell(
              onTap: pilihDeadline,
              child: InputDecorator(
                decoration: inputDecoration(
                  'Pilih tanggal deadline',
                  Icons.calendar_month,
                ),
                child: Text(
                  deadline == null
                      ? 'Belum memilih tanggal'
                      : '${deadline!.day}/${deadline!.month}/${deadline!.year}',
                  style: TextStyle(
                    color: deadline == null ? Colors.grey : Colors.black87,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            buildLabel('Prioritas Tugas'),

            DropdownButtonFormField<String>(
              value: prioritas,
              decoration: inputDecoration(
                'Pilih prioritas',
                Icons.flag_outlined,
              ),
              items: const [
                DropdownMenuItem(value: 'Rendah', child: Text('Rendah')),
                DropdownMenuItem(value: 'Sedang', child: Text('Sedang')),
                DropdownMenuItem(value: 'Tinggi', child: Text('Tinggi')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    prioritas = value;
                  });
                }
              },
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: simpanTugas,
                icon: const Icon(Icons.save),
                label: const Text('Simpan Tugas'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: maroon,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: maroon,
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: maroon),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: pink),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: pink),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: maroon, width: 1.5),
      ),
    );
  }
}
