import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart';
import 'package:myapp/app/modules/dashboard/views/dashboard_view.dart';
import 'package:myapp/app/modules/laporan/views/laporan_view.dart';
import 'package:myapp/app/modules/transaksi/views/transaksi_add_view.dart';
import 'package:myapp/app/modules/transaksi/views/transaksi_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final AuthController cAuth = Get.find<AuthController>();
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    DashboardView(),
    TransaksiView(),
    LaporanView(),
  ];

  final List<String> _titles = [
    'Dashboard',
    'Data Transaksi',
    'Laporan',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Warna background halus
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Color(0xFF005DAA), // Warna biru khas
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.3),
      ),
      body: _pages[_selectedIndex], // Konten berganti sesuai index
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Transaksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Laporan',
          ),
        ],
        selectedItemColor: Color(0xFF005DAA),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
      drawer: _buildCustomDrawer(),
    );
  }

  Widget _buildCustomDrawer() {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              "Admin",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            accountEmail: const Text("admin@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.account_circle,
                color: Color(0xFF005DAA),
                size: 60,
              ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF005DAA), Color(0xFF00A3E1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          _drawerItem(
            icon: Icons.dashboard,
            title: 'Dashboard',
            onTap: () => _navigateTo(0),
          ),
          _drawerItem(
            icon: Icons.receipt,
            title: 'Data Transaksi',
            onTap: () => _navigateTo(1),
          ),
          _drawerItem(
            icon: Icons.report,
            title: 'Laporan',
            onTap: () => _navigateTo(2),
          ),
          const Divider(),
          _drawerItem(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () => cAuth.logout(),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF005DAA)),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      onTap: () {
        onTap();
        Navigator.pop(context);
      },
    );
  }

  void _navigateTo(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
