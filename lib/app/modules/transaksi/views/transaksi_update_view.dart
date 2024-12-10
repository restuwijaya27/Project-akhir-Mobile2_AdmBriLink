import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/transaksi/controllers/transaksi_controller.dart';

class TransaksiUpdateView extends GetView<TransaksiController> {
  const TransaksiUpdateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F7FA), // Softer background color
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade100.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3),
              )
            ]
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF1A5CAD)),
            onPressed: () => Get.back(),
          ),
        ),
        title: Text(
          'Ubah Data Transaksi',
          style: TextStyle(
            color: Color(0xFF1A5CAD),
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade100.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                )
              ]
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

                  return Padding(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Edit Transaksi',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1A5CAD),
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        _buildTextField(
                          controller: controller.cNama,
                          labelText: "Nama Lengkap",
                          icon: Icons.person_outline_rounded,
                        ),
                        SizedBox(height: 15),
                        _buildTextField(
                          controller: controller.cNomer_rekening,
                          labelText: "Nomor Rekening",
                          icon: Icons.credit_card_rounded,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 15),
                        _buildTextField(
                          controller: controller.cJenis_transaksi,
                          labelText: "Jenis Transaksi",
                          icon: Icons.swap_horiz_rounded,
                        ),
                        SizedBox(height: 15),
                        _buildTextField(
                          controller: controller.cNominal,
                          labelText: "Nominal Transaksi",
                          icon: Icons.attach_money_rounded,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 15),
                        _buildTextField(
                          controller: controller.cKode_struk,
                          labelText: "Kode Struk",
                          icon: Icons.description_outlined,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            if (_validateInputs()) {
                              controller.Update(
                                controller.cNama.text,
                                controller.cNomer_rekening.text,
                                controller.cJenis_transaksi.text,
                                controller.cNominal.text,
                                controller.cKode_struk.text,
                                Get.arguments,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1A5CAD),
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                          ),
                          child: Text(
                            "Ubah Data",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1A5CAD)),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  bool _validateInputs() {
    if (controller.cNama.text.isEmpty) {
      Get.snackbar(
        'Error', 
        'Nama Lengkap harus diisi',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade50,
        colorText: Colors.red,
      );
      return false;
    }
    if (controller.cNomer_rekening.text.isEmpty) {
      Get.snackbar(
        'Error', 
        'Nomor Rekening harus diisi',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade50,
        colorText: Colors.red,
      );
      return false;
    }
    // Add more validations as needed
    return true;
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      style: TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Color(0xFF1A5CAD)),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.blue[200]!, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Color(0xFF1A5CAD), width: 2),
        ),
      ),
    );
  }
}