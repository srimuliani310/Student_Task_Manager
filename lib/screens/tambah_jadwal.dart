import 'package:flutter/material.dart';

class TambahJadwalPage extends StatefulWidget {
  const TambahJadwalPage({super.key});

  @override
  State<TambahJadwalPage> createState() => _TambahJadwalPageState();
}

class _TambahJadwalPageState extends State<TambahJadwalPage> {
  static const Color maroon = Color(0xFF800020);
  static const Color pink = Color(0xFFFCE4EC);
  static const Color background = Color(0xFFFFF7F8);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController matkulController = TextEditingController();
  final TextEditingController dosenController = TextEditingController();
  final TextEditingController ruanganController = TextEditingController();

  String? hariDipilih;
  TimeOfDay? jamMulai;
  TimeOfDay? jamSelesai;

  final List<String> daftarHari = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];

  // Mengubah format jam menjadi HH:mm
  String formatJam(TimeOfDay? waktu) {
    if (waktu == null) return '';

    final jam = waktu.hour.toString().padLeft(2, '0');
    final menit = waktu.minute.toString().padLeft(2, '0');

    return '$jam:$menit';
  }

  // Memilih waktu
  Future<void> pilihWaktu(bool mulai) async {
    final waktu = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 0),
    );

    if (waktu != null) {
      setState(() {
        if (mulai) {
          jamMulai = waktu;
        } else {
          jamSelesai = waktu;
        }
      });
    }
  }

  // Menyimpan data jadwal sementara
  void simpanJadwal() {
    if (!_formKey.currentState!.validate()) return;

    if (hariDipilih == null || jamMulai == null || jamSelesai == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lengkapi hari dan waktu kuliah!')),
      );
      return;
    }

    final mulai = jamMulai!.hour * 60 + jamMulai!.minute;
    final selesai = jamSelesai!.hour * 60 + jamSelesai!.minute;

    if (selesai <= mulai) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jam selesai harus setelah jam mulai!')),
      );
      return;
    }

    final dataJadwal = {
      'matkul': matkulController.text.trim(),
      'dosen': dosenController.text.trim(),
      'hari': hariDipilih!,
      'mulai': formatJam(jamMulai),
      'selesai': formatJam(jamSelesai),
      'ruangan': ruanganController.text.trim(),
    };

    // Mengirim data kembali ke halaman sebelumnya
    Navigator.pop(context, dataJadwal);
  }

  @override
  void dispose() {
    matkulController.dispose();
    dosenController.dispose();
    ruanganController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      appBar: AppBar(
        title: const Text(
          'Tambah Jadwal',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: maroon,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Informasi Mata Kuliah',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: maroon,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Masukkan informasi jadwal perkuliahan kamu.',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),

              const SizedBox(height: 25),

              // Nama mata kuliah
              buildLabel('Nama Mata Kuliah'),
              buildTextField(
                controller: matkulController,
                hint: 'Contoh: Pemrograman Mobile',
                icon: Icons.menu_book,
              ),

              const SizedBox(height: 18),

              // Nama dosen
              buildLabel('Nama Dosen'),
              buildTextField(
                controller: dosenController,
                hint: 'Masukkan nama dosen',
                icon: Icons.person_outline,
              ),

              const SizedBox(height: 18),

              // Pilih hari
              buildLabel('Hari Kuliah'),
              DropdownButtonFormField<String>(
                value: hariDipilih,
                decoration: inputDecoration(
                  'Pilih hari kuliah',
                  Icons.calendar_month,
                ),
                items: daftarHari.map((hari) {
                  return DropdownMenuItem(value: hari, child: Text(hari));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    hariDipilih = value;
                  });
                },
                validator: (value) {
                  if (value == null) return 'Pilih hari kuliah';
                  return null;
                },
              ),

              const SizedBox(height: 18),

              // Jam mulai
              buildLabel('Jam Mulai'),
              buildTimeButton(
                label: jamMulai == null
                    ? 'Pilih jam mulai'
                    : formatJam(jamMulai),
                onPressed: () => pilihWaktu(true),
              ),

              const SizedBox(height: 18),

              // Jam selesai
              buildLabel('Jam Selesai'),
              buildTimeButton(
                label: jamSelesai == null
                    ? 'Pilih jam selesai'
                    : formatJam(jamSelesai),
                onPressed: () => pilihWaktu(false),
              ),

              const SizedBox(height: 18),

              // Ruangan
              buildLabel('Ruangan'),
              buildTextField(
                controller: ruanganController,
                hint: 'Contoh: A1',
                icon: Icons.location_on_outlined,
              ),

              const SizedBox(height: 30),

              // Tombol simpan
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: simpanJadwal,
                  icon: const Icon(Icons.save),
                  label: const Text(
                    'Simpan Jadwal',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: maroon,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Label input
  Widget buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: maroon,
        ),
      ),
    );
  }

  // Input teks
  Widget buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: inputDecoration(hint, icon),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Bagian ini wajib diisi';
        }
        return null;
      },
    );
  }

  // Dekorasi input
  InputDecoration inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: maroon),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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

  // Tombol pemilihan waktu
  Widget buildTimeButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.access_time, color: maroon),
        label: Align(
          alignment: Alignment.centerLeft,
          child: Text(label, style: const TextStyle(color: Colors.black87)),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: pink),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
