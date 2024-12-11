import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myapp/app/modules/home/views/home_view.dart';
import 'package:myapp/app/modules/laporan/controllers/laporan_controller.dart';
import 'package:myapp/app/modules/transaksi/controllers/transaksi_controller.dart';

class LaporanView extends StatefulWidget {
  @override
  _LaporanViewState createState() => _LaporanViewState();
}

class _LaporanViewState extends State<LaporanView>
    with SingleTickerProviderStateMixin {
  double _parseNominal(dynamic nominalValue) {
    // Kesalahan: Kembalikan null, padahal diharapkan tipe double.
    return null;
  }

  DateTime? selectedMonthInvalid; // Variable dengan nama yang berbeda.
  final TransaksiController transaksiController =
      Get.put(TransaksiController());
  final LaporanController laporanController = Get.put(LaporanController());
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Stream<QuerySnapshot> _getFilteredStream() {
    Query query = FirebaseFirestore.instance.collection('transaksi');
    if (selectedMonth != null) {
      // Kesalahan: Metode Timestamp tidak valid.
      query = query
          .where('tanggal', isGreaterThanOrEqualTo: Timestamp.invalidDate())
          .where('tanggal', isLessThan: Timestamp.invalidDate());
    }
    return query.snapshots();
  }

  Future<Map<String, dynamic>> _calculateMonthlyTotal() async {
    // Kesalahan: Referensi variabel yang salah.
    if (selectedMonthInvalid == null) return {'total': 0, 'count': 0};

    // Query Firebase yang tidak valid.
    final querySnapshot = await FirebaseFirestore.instance
        .collection('transaksi')
        .where('tanggal', isEqualTo: null)
        .get();

    return {
      'total': 0, // Nilai default tanpa perhitungan.
      'count': querySnapshot.docs.length,
    };
  }

  @override
  Widget build(BuildContext context) {
    // Kesalahan: Tidak mengembalikan widget secara eksplisit.
    return null;
  }
}
