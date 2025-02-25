import 'package:easy_localization/easy_localization.dart';
import 'package:find_pe/common/language/language_select_page.dart';
import 'package:find_pe/pages/home_botom_shet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:find_pe/common/style/app_colors.dart';
import 'package:find_pe/common/style/app_style.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  final List<Map<String, String>> items = const [
    {
      "Turi": "HDPE",
      "Markirovka": "15803-020",
      "Proizvoditel": "Сибур",
      "Davlat": "Россия",
      "Zichlik": "0,920 g/cm³",
      "Melt Index": "2,0 g/10 min",
      "PDF": "example1.pdf"
    },
    {
      "Turi": "LDPE",
      "Markirovka": "15303-003",
      "Proizvoditel": "Казаньоргсинтез",
      "Davlat": "Россия",
      "Zichlik": "0,920 g/cm³",
      "Melt Index": "0,3 g/10 min",
      "PDF": "example2.pdf"
    }
  ];

  @override
  Widget build(BuildContext context) {
    final Map<String, String> localeFlags = {
      'uz': '🇺🇿', // Узбекский
      'ru': '🇷🇺', // Русский
      'en': '🇬🇧', // Английский
      'zh': '🇨🇳', // Китайский
      'ar': '🇸🇦', // Арабский
      'de': '🇩🇪', // Немецкий
    };
  String currentFlag =
        localeFlags[context.locale.languageCode] ?? '🌍'; 
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.grade1,
        centerTitle: true,
        title: Text(
          'FindPE',
          style: AppStyle.fontStyle.copyWith(
            color: AppColors.backgroundColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              showPolyethyleneFilter(context);
            },
            icon: CircleAvatar(
              backgroundColor: AppColors.backgroundColor,
              radius: 18,
            
              child: SvgPicture.asset(
                'assets/icons/filter.svg',
                color: AppColors.grade1,
                width: 25,
                height: 25,
              ),
            ),
          ),
  actions: [GestureDetector(
                      onTap: () => showLanguageBottomSheet(context),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: Text(
                          currentFlag,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final data = items[index];

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: AppColors.grade1,
                            child: Text(
                              data["Turi"]??"",
                              style: AppStyle.fontStyle.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data["Markirovka"]!,
                                style: AppStyle.fontStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "${data["Proizvoditel"]} (${data["Davlat"]})",
                                style: AppStyle.fontStyle.copyWith(
                                  color: AppColors.uiText,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _buildRow("⚖️","density", data["Zichlik"]!),
                      _buildRow("🔥", "melt_index",data["Melt Index"]!),

                      const SizedBox(height: 12),

                      // 📄 PDF-ni ko‘rish tugmasi
                      ElevatedButton.icon(
                        onPressed: () {
                          _openPDF(context, data["PDF"]!);
                        },
                        icon: Icon(Icons.picture_as_pdf, color: Colors.white),
                        label: Text("view_pdf".tr(),style: AppStyle.fontStyle.copyWith(color: AppColors.backgroundColor),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.grade1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 🏷 Har bir elementni chiroyli chiqarish uchun yordamchi funksiya
  Widget _buildRow(String icon,String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text(icon, style: TextStyle(fontSize: 14)),
          const SizedBox(width: 5),
          Text(
            label.tr(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(width: 5),
          Text(
            value,
            style: TextStyle(color: Colors.black87, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // 📂 PDF-ni ochish funksiyasi
  void _openPDF(BuildContext context, String fileName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("📄 $fileName ochilmoqda..."),
        duration: Duration(seconds: 2),
      ),
    );
    // TODO: PDF ochish uchun implementatsiya qo‘shish
  }
}
