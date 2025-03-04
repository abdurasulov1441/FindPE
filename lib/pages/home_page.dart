import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_pe/common/language/language_select_page.dart';
import 'package:find_pe/common/request_helper.dart';
import 'package:find_pe/pages/pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:find_pe/common/style/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getProductTypes();
    getOrganizations();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData(
        search: selectedSearch,
        countryId: selectedCountryId,
        organizationId: selectedOrganizationId,
        typeId: selectedTypeId,
      );
    });
  }

  String? selectedSearch;
  String? selectedCountryId;
  String? selectedOrganizationId;
  String? selectedTypeId;

  List<Map<String, dynamic>> items = [];
  List<Map<String, dynamic>> product_types = [];
  List<Map<String, dynamic>> organizations = [];

  Future<void> getProductTypes() async {
    final response = await requestHelper.get(
      '/api/public/product-types',
      log: true,
    );

    if (response['success'] == true) {
      setState(() {
        product_types = List<Map<String, dynamic>>.from(response['data']);
      });
      for (var productType in product_types) {
        print(productType['name']);
      }
    }
  }

  Future<void> getOrganizations() async {
    final response = await requestHelper.get(
      '/api/public/organizations',
      log: true,
    );

    if (response['success'] == true) {
      setState(() {
        organizations = List<Map<String, dynamic>>.from(response['data']);
      });
      for (var organization in organizations) {
        print(organization['name']);
      }
    }
  }

  Future<void> getData({
    String? search,
    String? countryId,
    String? organizationId,
    String? typeId,
  }) async {
    // Формируем URL с параметрами фильтрации
    String url = "/api/public/products";

    Map<String, String> queryParams = {};
    if (search != null && search.isNotEmpty) queryParams["search"] = search;
    if (countryId != null && countryId.isNotEmpty)
      queryParams["country_id"] = countryId;
    if (organizationId != null && organizationId.isNotEmpty)
      queryParams["organization_id"] = organizationId;
    if (typeId != null && typeId.isNotEmpty) queryParams["type_id"] = typeId;

    if (queryParams.isNotEmpty) {
      url += "?" + Uri(queryParameters: queryParams).query;
    }

    debugPrint("📡 Запрос: $url"); // Проверяем корректность URL

    final response = await requestHelper.get(url, log: true);

    if (response['success'] == true) {
      setState(() {
        items = List<Map<String, dynamic>>.from(response['data']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> localeFlags = {
      'uz': '🇺🇿',
      'ru': '🇷🇺',
      'en': '🇬🇧',
      'zh': '🇨🇳',
      'ar': '🇸🇦',
      'de': '🇩🇪',
    };

    String currentFlag = localeFlags[context.locale.languageCode] ?? '🌍';
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.grade1,
        centerTitle: true,
        title: Text(
          'FindPE',
          style: TextStyle(
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
        actions: [
          GestureDetector(
            onTap: () => showLanguageBottomSheet(context),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              child: Text(currentFlag, style: const TextStyle(fontSize: 24)),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final data = items[index];

                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
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
                              data["product_types"]?["name"] ?? "",
                              style: TextStyle(
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
                                data["name"] ?? "",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "${data["organizations"]?["name"] ?? "Noma'lum"} (${data["countries"]?["name"] ?? "Noma'lum"})",
                                style: TextStyle(
                                  color: AppColors.uiText,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _buildRow(
                        "⚖️",
                        "density",
                        data["density"]?.toString() ?? "Noma'lum",
                      ),
                      _buildRow(
                        "🔥",
                        "melt_index",
                        data["melt_index"]?.toString() ?? "Noma'lum",
                      ),

                      const SizedBox(height: 12),
                      if (data["pdf_file"] != null)
                        ElevatedButton.icon(
                          onPressed: () {
                            _openPDF(context, data["pdf_file"] ?? "Noma'lum");
                          },
                          icon: Icon(Icons.picture_as_pdf, color: Colors.white),
                          label: Text(
                            "view_pdf".tr(),
                            style: TextStyle(color: AppColors.backgroundColor),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.grade1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 16,
                            ),
                          ),
                        )
                      else
                        SizedBox(),
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

  Widget _buildRow(String icon, String label, String value) {
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
          Text(value, style: TextStyle(color: Colors.black87, fontSize: 14)),
        ],
      ),
    );
  }

  void _openPDF(BuildContext context, String filePath) async {
    String pdfUrl = "http://95.130.227.93:8090/api/$filePath";
    debugPrint("📄 PDF yuklanmoqda: $pdfUrl");

    try {
      final File file = await _downloadPDF(pdfUrl);
      if (file.existsSync()) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PDFViewerScreen(pdfFile: file),
          ),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("❌ PDF yuklab bo‘lmadi!")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("❌ PDF ochishda xatolik: $e")));
    }
  }

  Future<File> _downloadPDF(String url) async {
    final response = await http.get(Uri.parse(url));
    final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/downloaded.pdf");
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  void showPolyethyleneFilter(BuildContext context) {
    TextEditingController searchController = TextEditingController(
      text: selectedSearch ?? "",
    );

    showModalBottomSheet(
      backgroundColor: AppColors.backgroundColor,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                        "polietilen_filtr".tr(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    DropdownButtonFormField<String>(
                      value: selectedTypeId,
                      decoration: _inputDecoration(
                        "choose_type_polietilen".tr(),
                      ),
                      items:
                          product_types.map((type) {
                            return DropdownMenuItem<String>(
                              value: type["id"].toString(),
                              child: Text(type["name"]),
                            );
                          }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedTypeId = value;
                        });
                      },
                    ),
                    const SizedBox(height: 12),

                    // Выбор производителя
                    DropdownButtonFormField<String>(
                      value: selectedOrganizationId,
                      decoration: _inputDecoration("choose_manufacturer".tr()),
                      items:
                          organizations.map((org) {
                            return DropdownMenuItem<String>(
                              value: org["id"].toString(),
                              child: Text(org["name"]),
                            );
                          }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedOrganizationId = value;
                        });
                      },
                    ),
                    const SizedBox(height: 12),

                    TextField(
                      controller: searchController,
                      decoration: _inputDecoration(
                        "choose_mark_of_polietilen".tr(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedSearch = null;
                                selectedCountryId = null;
                                selectedOrganizationId = null;
                                selectedTypeId = null;
                                searchController.clear();
                              });
                          
                             
                              getData();
                              context.pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              "reset_filter".tr(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
SizedBox(height: 10 ,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          selectedSearch = searchController.text.trim();
                          getData(
                            search: selectedSearch,
                            countryId: selectedCountryId,
                            organizationId: selectedOrganizationId,
                            typeId: selectedTypeId,
                          );
                          context.pop();
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
      },
    );
  }

  // Вспомогательная функция для оформления полей ввода
  InputDecoration _inputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
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
    );
  }
}
