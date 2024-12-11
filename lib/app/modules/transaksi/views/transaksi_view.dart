import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myapp/app/modules/home/views/home_view.dart';
import 'package:myapp/app/modules/transaksi/controllers/transaksi_controller.dart';
import 'package:myapp/app/modules/transaksi/views/transaksi_add_view.dart';
import 'package:myapp/app/modules/transaksi/views/transaksi_update_view.dart';
import 'package:animations/animations.dart'; // Tambahkan package animasi

class TransaksiView extends StatefulWidget {
  @override
  _TransaksiViewState createState() => _TransaksiViewState();
}

class _TransaksiViewState extends State<TransaksiView> with SingleTickerProviderStateMixin {
  final TransaksiController controller = Get.put(TransaksiController());
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Animasi kontroller untuk efek scroll dan transisi
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 26, 35, 126),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: OpenContainer(
          closedBuilder: (context, action) => IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: action,
          ),
          openBuilder: (context, action) => HomeView(),
          transitionType: ContainerTransitionType.fadeThrough,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1A237E), 
              Color(0xFF283593), 
              Color(0xFF3F51B5)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: ScaleTransition(
            scale: _animation,
            child: Column(
              children: [
                _buildHeaderSection(),
                Expanded(
                  child: _buildTransactionList(),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ScaleTransition(
        scale: _animation,
        child: _buildAddTransactionButton(),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tambahkan efek shimmer pada header
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                Colors.white.withOpacity(0.7),
                Colors.white.withOpacity(0.3)
              ],
            ).createShader(bounds),
            child: Text(
              'Transaksi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Kelola Transaksi Anda dengan Mudah',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList() {
    return StreamBuilder<QuerySnapshot>(
      stream: controller.streamData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _buildEmptyState();
        }

        // Gunakan AnimatedList untuk efek transisi yang lebih menarik
        return AnimatedList(
          initialItemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index, animation) {
            var data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: _buildTransactionCard(data, snapshot.data!.docs[index].id),
            );
          },
        );
      },
    );
  }

  // Method lainnya tetap sama seperti kode sebelumnya, 
  // dengan beberapa penyesuaian minor pada warna dan gaya

  // Tambahkan efek interaksi pada bottom sheet
  void _showTransactionDetails(Map<String, dynamic> data) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 2,
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Sisanya sama seperti kode sebelumnya
            ],
          ),
        ),
      ),
      // Tambahkan efek transisi
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
    );
  }

  // Method lainnya tetap sama
}