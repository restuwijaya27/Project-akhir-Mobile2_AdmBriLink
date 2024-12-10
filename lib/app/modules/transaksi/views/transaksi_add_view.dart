import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myapp/app/modules/transaksi/controllers/transaksi_controller.dart';

class TransaksiAddView extends GetView<TransaksiController> {
  const TransaksiAddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.cTanggal.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    });

    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA), // Softer background
      appBar: AppBar(
        title: Text(
          'Tambah Transaksi BRI Link', 
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: Color(0xFF005FAE), // BRI Blue
        centerTitle: true,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25)
          )
        ),
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
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTextField(
                    controller: controller.cNama,
                    label: "Nama Lengkap",
                    icon: Icons.person_outline_rounded,
                  ),
                  SizedBox(height: 15),
                  _buildTextField(
                    controller: controller.cNomer_rekening,
                    label: "Nomor Rekening",
                    icon: Icons.credit_card_rounded,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 15),
                  _buildTextField(
                    controller: controller.cJenis_transaksi,
                    label: "Jenis Transaksi",
                    icon: Icons.swap_horiz_rounded,
                  ),
                  SizedBox(height: 15),
                  _buildTextField(
                    controller: controller.cNominal,
                    label: "Nominal Transaksi",
                    icon: Icons.attach_money_rounded,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 15),
                  _buildTextField(
                    controller: controller.cKode_struk,
                    label: "Kode Struk",
                    icon: Icons.description_outlined,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 15),
                  _buildDateField(context),
                  SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {
                      // Add validation before submitting
                      if (_validateInputs()) {
                        controller.add(
                          controller.cNama.text,
                          controller.cNomer_rekening.text,
                          controller.cJenis_transaksi.text,
                          controller.cNominal.text,
                          controller.cTanggal.text,
                          controller.cKode_struk.text,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF005FAE),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      "Simpan Transaksi",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  )
                ],
              ),
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
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      style: TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(0xFF005FAE)),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.blue[200]!, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Color(0xFF005FAE), width: 2),
        ),
      ),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return TextField(
      controller: controller.cTanggal,
      readOnly: true,
      style: TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        labelText: "Tanggal Transaksi",
        prefixIcon: Icon(Icons.calendar_today_rounded, color: Color(0xFF005FAE)),
        suffixIcon: IconButton(
          icon: Icon(Icons.date_range_rounded, color: Color(0xFF005FAE)),
          onPressed: () => _selectDate(context),
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.blue[200]!, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Color(0xFF005FAE), width: 2),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF005FAE), // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            datePickerTheme: DatePickerThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      controller.cTanggal.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }
}