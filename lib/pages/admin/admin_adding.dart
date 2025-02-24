import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:find_pe/common/style/app_colors.dart';
import 'package:go_router/go_router.dart';

class AdminAdding extends StatefulWidget {
  const AdminAdding({super.key});

  @override
  _AdminAddingState createState() => _AdminAddingState();
}

class _AdminAddingState extends State<AdminAdding> {
  final TextEditingController _manufacturerController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _legacyNameController = TextEditingController();
  final TextEditingController _densityController = TextEditingController();
  final TextEditingController _meltIndexController = TextEditingController();

  File? _selectedFile; // PDF faylni saqlash uchun o‘zgaruvchi

  // 📂 PDF faylni tanlash funksiyasi
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });

      print("Tanlangan fayl: ${_selectedFile!.path}");
    }
  }

  // 📤 Ma'lumotlarni jo‘natish (PDF bilan birga)
  void _submitData() {
    if (_manufacturerController.text.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        _densityController.text.isNotEmpty &&
        _meltIndexController.text.isNotEmpty &&
        _selectedFile != null) {
      
      print("✅ Ishlab chiqaruvchi: ${_manufacturerController.text}");
      print("✅ Name: ${_nameController.text}");
      print("✅ Legacy Name: ${_legacyNameController.text}");
      print("✅ Zichlik: ${_densityController.text}");
      print("✅ Melt Index: ${_meltIndexController.text}");
      print("✅ PDF Fayl: ${_selectedFile!.path}");

      // TODO: Bu yerda API-ga yuborish yoki ma'lumotni saqlashni qo‘shish mumkin.

      // 🧹 Maydonlarni tozalash
      _manufacturerController.clear();
      _nameController.clear();
      _legacyNameController.clear();
      _densityController.clear();
      _meltIndexController.clear();
      setState(() {
        _selectedFile = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ma'lumotlar muvaffaqiyatli qo‘shildi!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Iltimos, barcha maydonlarni to‘ldiring va PDF yuklang!")),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ui,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back, color: AppColors.backgroundColor),
        ),
        backgroundColor: AppColors.grade1,
        title: Text(
          'Admin Adding',
          style: TextStyle(color: AppColors.backgroundColor, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _manufacturerController,
                decoration: InputDecoration(
                  labelText: "Firma nomi",
                  border: OutlineInputBorder(),
                ),
              ),
                 SizedBox(height: 10),
              TextField(
                controller: _manufacturerController,
                decoration: InputDecoration(
                  labelText: "Firma davlati",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
                            TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Polietilen turi ",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Polietilen nomi (Name)",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),

              TextField(
                controller: _legacyNameController,
                decoration: InputDecoration(
                  labelText: "Legacy Name (majburiy emas)",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _densityController,
                decoration: InputDecoration(
                  labelText: "Zichlik (Density g/cm³)",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _meltIndexController,
                decoration: InputDecoration(
                  labelText: "Melt Index (g/10 min)",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
        
              // 📂 Fayl tanlash tugmasi
              ElevatedButton.icon(
                onPressed: _pickFile,
                icon: Icon(Icons.attach_file),
                label: Text("PDF yuklash"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.grade1,
                ),
              ),
        
              // 📌 Tanlangan faylni ko‘rsatish
              if (_selectedFile != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "📄 Fayl: ${_selectedFile!.path.split('/').last}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
        
              SizedBox(height: 20),
        
              // 📤 Ma'lumotlarni yuborish tugmasi
              ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.grade1,
                ),
                child: Text(
                  "Ma'lumotni qo'shish",
                  style: TextStyle(color: AppColors.backgroundColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
