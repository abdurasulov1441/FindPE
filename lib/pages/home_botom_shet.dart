import 'package:find_pe/common/style/app_colors.dart';
import 'package:find_pe/common/style/app_style.dart';
import 'package:flutter/material.dart';

void showPolyethyleneFilter(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: AppColors.backgroundColor,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      String? selectedType;
      String? selectedCountry;
      TextEditingController searchController = TextEditingController();

      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(width: 60,height: 10,decoration: BoxDecoration(
                color: AppColors.grade1,
                borderRadius: BorderRadius.circular(5),
              ),),
              SizedBox(height: 20,),
              Center(
                child: Text(
                  "Фильтр полиэтилена",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),

              /// Выбор типа полиэтилена
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Выберите тип полиэтилена",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: ["LD", "HD", "LLD"].map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedType = value;
                },
              ),
              const SizedBox(height: 12),

              /// Выбор производителя
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Выберите страну",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: ["Russia", "China", "Germany", "USA"].map((String country) {
                  return DropdownMenuItem<String>(
                    value: country,
                    child: Text(country),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedCountry = value;
                },
              ),
              const SizedBox(height: 12),

              /// Ввод марки полиэтилена
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: "Введите марку полиэтилена",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    String searchQuery = searchController.text.trim();
                    if (searchQuery.isNotEmpty) {
                     
                      Navigator.pop(context); 
                      showResults(context, searchQuery, selectedType, selectedCountry);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.grade1,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child:  Text("Найти", style: AppStyle.fontStyle.copyWith(fontSize: 16,color: AppColors.backgroundColor,fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

/// **Функция для отображения результатов поиска**
void showResults(BuildContext context, String query, String? type, String? country) {
  // Здесь можно подгружать данные с допуском ±3 (Density, Melt Index) из базы
  List<Map<String, dynamic>> results = [
    {"name": "LD 03210 FE", "density": 0.921, "melt": 0.3, "file": "TDS PE LD03210 FE_RUS.pdf"},
    {"name": "LD 04200 FE", "density": 0.922, "melt": 4.0, "file": "TDS LD04200 FE_RUS.pdf"},
  ];

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Заголовок результатов
            Text(
              "Результаты поиска",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            /// Список найденных марок
            ...results.map((item) => ListTile(
                  title: Text(item["name"], style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("Density: ${item["density"]} | Melt index: ${item["melt"]}"),
                  trailing: IconButton(
                    icon: Icon(Icons.picture_as_pdf, color: Colors.red),
                    onPressed: () {
                      // Открытие PDF-файла
                    },
                  ),
                )),
          ],
        ),
      );
    },
  );
}
