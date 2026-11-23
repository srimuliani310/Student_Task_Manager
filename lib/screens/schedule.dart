
import 'package:flutter/material.dart';
import 'tambah_tugas.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  static const Color maroon = Color(0xFF800020);
  static const Color pink = Color(0xFFFCE4EC);
  static const Color background = Color(0xFFFFF7F8);

  String filterStatus = 'Semua';
  String filterPrioritas = 'Semua';
  bool mencari = false;

  final TextEditingController searchController = TextEditingController();

  // Data tugas sementara
  final List<Map<String, String>> daftarTugas = [
    {
      'nama': 'Membuat UI Flutter',
      'matkul': 'Pemrograman Mobile',
      'deadline': '10 Nov 2026',
      'status': 'Belum',
      'prioritas': 'Tinggi',
    },
    {
      'nama': 'Membuat ERD',
      'matkul': 'Basis Data',
      'deadline': '08 Nov 2026',
      'status': 'Selesai',
      'prioritas': 'Sedang',
    },
    {
      'nama': 'Laporan Praktikum',
      'matkul': 'PBO',
      'deadline': '12 Nov 2026',
      'status': 'Belum',
      'prioritas': 'Sedang',
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Membuka form tambah tugas
  Future<void> tambahTugas() async {
    final hasil = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => const TambahTugasPage(),
      ),
    );

    if (hasil != null) {
      setState(() {
        daftarTugas.add({
          'nama': hasil['nama'] ?? '',
          'matkul': hasil['matkul'] ?? '',
          'deadline': hasil['deadline'] ?? '',
          'status': 'Belum',
          'prioritas': hasil['prioritas'] ?? 'Sedang',
        });
      });
    }
  }

  // Mengubah status tugas
  void ubahStatus(int index) {
    setState(() {
      if (daftarTugas[index]['status'] == 'Belum') {
        daftarTugas[index]['status'] = 'Selesai';
      } else {
        daftarTugas[index]['status'] = 'Belum';
      }
    });
  }

  // Menghapus tugas
  void hapusTugas(int index) {
    setState(() {
      daftarTugas.removeAt(index);
    });
  }

  // Menampilkan dialog filter prioritas
  void tampilkanFilter() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filter Prioritas'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              'Semua',
              'Rendah',
              'Sedang',
              'Tinggi',
            ].map((prioritas) {
              return RadioListTile<String>(
                title: Text(prioritas),
                value: prioritas,
                groupValue: filterPrioritas,
                activeColor: maroon,
                onChanged: (value) {
                  setState(() {
                    filterPrioritas = value!;
                  });

                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  // Filter tugas
  List<Map<String, String>> get tugasTerfilter {
    return daftarTugas.where((tugas) {
      bool cocokStatus = filterStatus == 'Semua' ||
          tugas['status'] == filterStatus;

      bool cocokPrioritas = filterPrioritas == 'Semua' ||
          tugas['prioritas'] == filterPrioritas;

      bool cocokNama = tugas['nama']!
              .toLowerCase()
              .contains(searchController.text.toLowerCase()) ||
          tugas['matkul']!
              .toLowerCase()
              .contains(searchController.text.toLowerCase());

      return cocokStatus && cocokPrioritas && cocokNama;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // Header
      appBar: AppBar(
        backgroundColor: maroon,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: mencari
            ? TextField(
                controller: searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Cari tugas...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {});
                },
              )
            : const Text(
                'Schedule',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
        actions: [
          // Tombol pencarian
          IconButton(
            icon: Icon(
              mencari ? Icons.close : Icons.search,
            ),
            onPressed: () {
              setState(() {
                mencari = !mencari;
                searchController.clear();
              });
            },
          ),

          // Tombol filter
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: tampilkanFilter,
          ),
        ],
      ),

      // Isi halaman
      body: Column(
        children: [
          // Tab filter status
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
            child: Row(
              children: [
                tabStatus('Semua'),
                const SizedBox(width: 10),
                tabStatus('Belum'),
                const SizedBox(width: 10),
                tabStatus('Selesai'),
              ],
            ),
          ),

          // Daftar tugas
          Expanded(
            child: tugasTerfilter.isEmpty
                ? const Center(
                    child: Text(
                      'Tidak ada tugas.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: tugasTerfilter.length,
                    itemBuilder: (context, index) {
                      final tugas = tugasTerfilter[index];

                      // Cari index asli pada daftar
                      final indexAsli =
                          daftarTugas.indexOf(tugas);

                      return kartuTugas(
                        tugas,
                        indexAsli,
                      );
                    },
                  ),
          ),
        ],
      ),

      // Tombol tambah tugas
      floatingActionButton: FloatingActionButton(
        onPressed: tambahTugas,
        backgroundColor: maroon,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add, size: 30),
      ),

      // Bottom navigation diatur oleh main_page.dart
    );
  }

  // Widget tab status
  Widget tabStatus(String status) {
    bool aktif = filterStatus == status;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            filterStatus = status;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: aktif ? maroon : pink,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            status,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: aktif ? Colors.white : maroon,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  // Widget kartu tugas
  Widget kartuTugas(
    Map<String, String> tugas,
    int indexAsli,
  ) {
    bool selesai = tugas['status'] == 'Selesai';

    Color warnaIcon;
    IconData iconTugas;

    if (selesai) {
      warnaIcon = Colors.green;
      iconTugas = Icons.check;
    } else if (tugas['prioritas'] == 'Tinggi') {
      warnaIcon = Colors.redAccent;
      iconTugas = Icons.priority_high;
    } else {
      warnaIcon = Colors.orange;
      iconTugas = Icons.check;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: pink),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon status
          GestureDetector(
            onTap: () => ubahStatus(indexAsli),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: warnaIcon,
                shape: BoxShape.circle,
              ),
              child: Icon(
                iconTugas,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Informasi tugas
          Expanded(
            child: GestureDetector(
              onTap: () => ubahStatus(indexAsli),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tugas['nama']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    tugas['matkul']!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        size: 13,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        tugas['deadline']!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Label status
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: selesai
                  ? const Color(0xFFD5F3E2)
                  : const Color(0xFFFFDDE0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              selesai ? 'Selesai' : 'Belum',
              style: TextStyle(
                fontSize: 11,
                color: selesai
                    ? Colors.green
                    : Colors.redAccent,
              ),
            ),
          ),

          // Menu hapus
          PopupMenuButton<String>(
            padding: EdgeInsets.zero,
            iconSize: 18,
            onSelected: (value) {
              if (value == 'hapus') {
                hapusTugas(indexAsli);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'hapus',
                child: Text('Hapus tugas'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
