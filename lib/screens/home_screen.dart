import '../database/database_helper.dart';
import '../models/task.dart';

import 'package:flutter/material.dart';

import 'jadwal.dart';
import 'profil.dart';
import 'schedule.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Data dashboard
  final int totalJadwal = 0;

  int totalTugas = 0;
  int tugasBelum = 0;
  int tugasSelesai = 0;

  String? deadlineTerdekat;

  final List<Map<String, String>> aktivitasHariIni = [];

  List<Task> daftarTugas = [];
  @override
  void initState() {
    super.initState();
    muatDataTugas();
  }

  Future<void> muatDataTugas() async {
    final data = await DatabaseHelper.instance.getTasks();

    if (!mounted) return;

    setState(() {
      daftarTugas = data;

      totalTugas = data.length;

      tugasSelesai = data.where((task) => task.isCompleted == 1).length;

      tugasBelum = data.where((task) => task.isCompleted == 0).length;
    });
  }

  // Palet warna sesuai desain
  static const Color primaryMaroon = Color(0xFF7D1128);
  static const Color softPinkBackground = Color(0xFFFDF2F4);
  static const Color softPinkCard = Color(0xFFFBE7EB);
  static const Color iconPurple = Color(0xFF5C4DB1);
  static const Color iconRed = Color(0xFFD93025);
  static const Color iconGreen = Color(0xFF1E8E3E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softPinkBackground,
      body: Column(
        children: [
          // 1. Header Atas Berwarna Maroon
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 56, 24, 28),
            decoration: const BoxDecoration(color: primaryMaroon),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, Mahasiswa! 👋',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Semangat belajar hari ini!',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    // Aksi notifikasi
                  },
                  icon: const Icon(
                    Icons.notifications_none_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),

          // 2. Konten Utama Dashboard
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Empat Kartu Statistik Default (0 Semua)
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.calendar_today_outlined,
                          iconColor: Colors.black87,
                          count: '$totalJadwal',
                          label: 'Jadwal',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.assignment_turned_in_outlined,
                          iconColor: iconPurple,
                          count: '$totalTugas',
                          label: 'Tugas',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.error_outline_rounded,
                          iconColor: iconRed,
                          count: '$tugasBelum',
                          label: 'Belum',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.check_circle_rounded,
                          iconColor: iconGreen,
                          count: '$tugasSelesai',
                          label: 'Selesai',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Kartu Banner Deadline Terdekat (Default Kosong)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: softPinkCard,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black54,
                              width: 1.5,
                            ),
                          ),
                          child: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.black54,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Deadline Terdekat',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                deadlineTerdekat ?? 'Belum ada tugas',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 3),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 13,
                                    color: Colors.black45,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '-',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Judul Section "Aktivitas Hari Ini"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Aktivitas Hari Ini',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigasi ke tab Jadwal
                          setState(() {
                            _selectedIndex = 1;
                          });
                        },
                        child: const Row(
                          children: [
                            Text(
                              'Lihat Semua',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: primaryMaroon,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward,
                              size: 15,
                              color: primaryMaroon,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Kartu Aktivitas Hari Ini (Default Kosong)
                  if (aktivitasHariIni.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.event_busy_outlined,
                            color: primaryMaroon,
                            size: 28,
                          ),
                          SizedBox(width: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Belum ada jadwal hari ini',
                                style: TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                '00.00 - 00.00',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 24),

                  const Text(
                    'Daftar Tugas',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 14),

                  if (daftarTugas.isEmpty)
                    const Center(child: Text('Belum ada tugas'))
                  else
                    ...daftarTugas.map((task) {
                      return Card(
                        color: Colors.white,
                        child: ListTile(
                          leading: const Icon(
                            Icons.assignment_outlined,
                            color: primaryMaroon,
                          ),
                          title: Text(
                            task.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Deadline: ${task.deadline}\n${task.description}',
                          ),
                          trailing: Icon(
                            task.isCompleted == 1
                                ? Icons.check_circle
                                : Icons.pending_actions,
                            color: task.isCompleted == 1 ? iconGreen : iconRed,
                          ),
                        ),
                      );
                    }),
                ],
              ),
            ),
          ),
        ],
      ),
      // 3. Bottom Navigation Bar (4 Menu)
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black12, width: 0.8)),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const JadwalPage()),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SchedulePage()),
              );
            } else if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilPage()),
              );
            } else {
              setState(() {
                _selectedIndex = index;
              });
            }
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: primaryMaroon,
          unselectedItemColor: Colors.black54,
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_rounded),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              label: 'Jadwal',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_turned_in_outlined),
              label: 'Schedule',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }

  // Widget pembantu untuk 4 kartu statistik atas
  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String count,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(height: 10),
          Text(
            count,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
