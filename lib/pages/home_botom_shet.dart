import 'package:easy_localization/easy_localization.dart';
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
      String? selectedManufacturer; // Исправлено название переменной
      TextEditingController searchController = TextEditingController();

      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 10,
                decoration: BoxDecoration(
                  color: AppColors.grade1,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  "polietilen_filtr".tr(), // ✅ Исправлено
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),

              /// Выбор типа полиэтилена
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "choose_type_polietilen".tr(), // ✅ Исправлено
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.grade1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.grade1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.grade1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items:
                    ["LD", "HD", "LLD"].map((String type) {
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

              /// Выбор производителя (исправлено)
              DropdownButtonFormField<String>(
                
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.grade1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.grade1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.grade1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: "choose_manufacturer".tr(), // ✅ Исправлено
                  
                ),
                items:
                    ["Sibur", "Kazanjorgsintez", "Lukoil", "Borealis"].map((
                      String manufacturer,
                    ) {
                      return DropdownMenuItem<String>(
                        value: manufacturer,
                        child: Text(manufacturer),
                      );
                    }).toList(),
                onChanged: (value) {
                  selectedManufacturer = value;
                },
              ),
              const SizedBox(height: 12),

              /// Ввод марки полиэтилена
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: "choose_mark_of_polietilen".tr(),
                  labelStyle: TextStyle(),
                    focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.grade1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.grade1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.grade1),
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
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.grade1,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "search".tr(),
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.backgroundColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
