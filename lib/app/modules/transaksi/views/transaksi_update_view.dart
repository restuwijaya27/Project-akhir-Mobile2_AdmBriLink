import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/transaksi/controllers/transaksi_controller.dart';

class TransaksiUpdateView extends GetView<TransaksiController> {
  const TransaksiUpdateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Color(0xFF005FAE), // BRI Blue
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Ubah Data Transaksi',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: FutureBuilder<DocumentSnapshot<Object?>>(
            future: controller.GetDataById(Get.arguments),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var data = snapshot.data!.data() as Map<String, dynamic>;
                controller.cNama.text = data['nama'];
                controller.cNomer_rekening.text = data['nomer_rekening'];
                controller.cJenis_transaksi.text = data['jenis_transaksi'];
                controller.cNominal.text = data['nominal'];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Edit Transaksi',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF005FAE),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    _buildTextField(
                      controller: controller.cNama,
                      labelText: "Nama",
                      icon: Icons.person,
                    ),
                    SizedBox(height: 15),
                    _buildTextField(
                      controller: controller.cNomer_rekening,
                      labelText: "Nomor Rekening",
                      icon: Icons.credit_card,
                    ),
                    SizedBox(height: 15),
                    _buildTextField(
                      controller: controller.cJenis_transaksi,
                      labelText: "Jenis Transaksi",
                      icon: Icons.swap_horiz,
                    ),
                    SizedBox(height: 15),
                    _buildTextField(
                      controller: controller.cNominal,
                      labelText: "Nominal",
                      icon: Icons.attach_money,
                    ),
                    SizedBox(height: 15),
                    _buildTextField(
                      controller: controller.cKode_struk,
                      labelText: "Kode Struk",
                      icon: Icons.description,
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () => controller.Update(
                        controller.cNama.text,
                        controller.cNomer_rekening.text,
                        controller.cJenis_transaksi.text,
                        controller.cNominal.text,
                        controller.cKode_struk.text,
                        Get.arguments,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF005FAE),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 8,
                      ),
                      child: Text(
                        "Ubah Data",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              }

              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF005FAE)),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Color(0xFF005FAE)),
        filled: true,
        fillColor: Colors.blue[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF005FAE), width: 2),
        ),
      ),
    );
  }
}
