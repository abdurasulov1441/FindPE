import 'package:find_pe/common/style/app_colors.dart';
import 'package:flutter/material.dart';
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

  List<Map<String, String>> polietilenList = [
    {"Firma": "Россия", "Name": "LD 03210 FE", "Legacy Name": "15303-003", "Density": "0.921", "Melt Index": "0.3"},
    {"Firma": "Россия", "Name": "LD 20190 FE", "Legacy Name": "15803-020", "Density": "0.919", "Melt Index": "2.0"},
    {"Firma": "Россия", "Name": "LD 08220 FE", "Legacy Name": "-", "Density": "0.921", "Melt Index": "0.8"},
    {"Firma": "Россия", "Name": "LD 20220 FE", "Legacy Name": "-", "Density": "0.922", "Melt Index": "2.0"},
    {"Firma": "Россия", "Name": "LD 04200 FE", "Legacy Name": "-", "Density": "0.920", "Melt Index": "0.4"},
    {"Firma": "Россия", "Name": "LD 50210 EC", "Legacy Name": "-", "Density": "0.921", "Melt Index": "5.0"},
    {"Firma": "Россия", "Name": "LD 75210 EC", "Legacy Name": "-", "Density": "0.921", "Melt Index": "7.5"},
  ];

  void _addPolietilen() {
    if (_nameController.text.isNotEmpty &&
        _densityController.text.isNotEmpty &&
        _meltIndexController.text.isNotEmpty) {
      setState(() {
        polietilenList.add({
          "Firma": _manufacturerController.text.isEmpty ? "Россия" : _manufacturerController.text,
          "Name": _nameController.text,
          "Legacy Name": _legacyNameController.text.isEmpty ? "-" : _legacyNameController.text,
          "Density": _densityController.text,
          "Melt Index": _meltIndexController.text,
        });
      });

      // Konsolga chiqarish (Kelajakda API-ga yuborish mumkin)
      print("Yangi polietilen qo'shildi: ${polietilenList.last}");

      // Maydonlarni tozalash
      _nameController.clear();
      _legacyNameController.clear();
      _densityController.clear();
      _meltIndexController.clear();
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _manufacturerController,
              decoration: InputDecoration(
                labelText: "Firma (Россия avtomatik)",
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
            ElevatedButton(
              onPressed: _addPolietilen,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.grade1,
              ),
              child: Text(
                "Qo'shish",
                style: TextStyle(color: AppColors.backgroundColor),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: polietilenList.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(
                        "${polietilenList[index]['Firma']} - ${polietilenList[index]['Name']}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Legacy Name: ${polietilenList[index]['Legacy Name']}\n"
                        "Zichligi: ${polietilenList[index]['Density']} | "
                        "Melt Index: ${polietilenList[index]['Melt Index']}",
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
