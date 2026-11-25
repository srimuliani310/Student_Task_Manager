
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  static const Color maroon = Color(0xFF800020);
  static const Color pink = Color(0xFFFCE4EC);
  static const Color background = Color(0xFFFFF7F8);

  // Data profil
  String nama = 'Sri Muliani';
  String nim = 'D0225310';
  String programStudi = 'Informatika';
  String kelas = 'Informatika A';
  String universitas = 'Universitas Sulawesi Barat';

  // Foto profil
  File? fotoProfil;
  final ImagePicker picker = ImagePicker();

  // Controller untuk form edit
  final TextEditingController namaController = TextEditingController();
  final TextEditingController prodiController = TextEditingController();
  final TextEditingController kelasController = TextEditingController();
  final TextEditingController universitasController =
      TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    prodiController.dispose();
    kelasController.dispose();
    universitasController.dispose();
    super.dispose();
  }

  // Fungsi memilih foto profil dari galeri
  Future<void> pilihFotoProfil() async {
    final XFile? gambar = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (gambar != null) {
      setState(() {
        fotoProfil = File(gambar.path);
      });
    }
  }

  // Fungsi menampilkan form edit profil
  void editProfil() {
    namaController.text = nama;
    prodiController.text = programStudi;
    kelasController.text = kelas;
    universitasController.text = universitas;

    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            'Edit Profil',
            style: TextStyle(
              color: maroon,
              fontWeight: FontWeight.bold,
            ),
          ),

          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Nama Lengkap
                  editField(
                    controller: namaController,
                    label: 'Nama Lengkap',
                    icon: Icons.person_outline,
                  ),

                  const SizedBox(height: 15),

                  // NIM (tidak dapat diedit)
                  TextFormField(
                    initialValue: nim,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'NIM',
                      prefixIcon: const Icon(
                        Icons.badge_outlined,
                        color: maroon,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Program Studi
                  editField(
                    controller: prodiController,
                    label: 'Program Studi',
                    icon: Icons.school_outlined,
                  ),

                  const SizedBox(height: 15),

                  // Kelas
                  editField(
                    controller: kelasController,
                    label: 'Kelas',
                    icon: Icons.groups_outlined,
                  ),

                  const SizedBox(height: 15),

                  // Universitas
                  editField(
                    controller: universitasController,
                    label: 'Universitas',
                    icon: Icons.account_balance_outlined,
                  ),
                ],
              ),
            ),
          ),

          actions: [
            // Tombol Batal
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Batal',
                style: TextStyle(color: Colors.grey),
              ),
            ),

            // Tombol Simpan
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: maroon,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    nama = namaController.text.trim();
                    programStudi = prodiController.text.trim();
                    kelas = kelasController.text.trim();
                    universitas =
                        universitasController.text.trim();
                  });

                  Navigator.pop(dialogContext);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profil berhasil diperbarui'),
                      backgroundColor: maroon,
                    ),
                  );
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  // Widget input untuk form edit
  Widget editField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: maroon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: maroon,
            width: 2,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$label tidak boleh kosong';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      // AppBar dengan tombol kembali
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Profil Saya',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
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

            // Foto profil dengan tombol kamera
            GestureDetector(
              onTap: pilihFotoProfil,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: maroon,
                    width: 3,
                  ),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Foto profil
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: pink,
                      backgroundImage: fotoProfil != null
                          ? FileImage(fotoProfil!)
                          : null,
                      child: fotoProfil == null
                          ? const Icon(
                              Icons.person,
                              size: 65,
                              color: maroon,
                            )
                          : null,
                    ),

                    // Ikon kamera di pojok kanan bawah
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 18,
                          color: maroon,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Nama mahasiswa
            Text(
              nama,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: maroon,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              'Mahasiswa $programStudi',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            // Tombol edit profil
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: editProfil,
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Edit Profil'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: maroon,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 13,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
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
                    nama,
                  ),

                  infoItem(
                    Icons.badge_outlined,
                    'NIM',
                    nim,
                  ),

                  infoItem(
                    Icons.school_outlined,
                    'Program Studi',
                    programStudi,
                  ),

                  infoItem(
                    Icons.groups_outlined,
                    'Kelas',
                    kelas,
                  ),

                  infoItem(
                    Icons.account_balance_outlined,
                    'Universitas',
                    universitas,
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
