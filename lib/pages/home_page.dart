import 'package:easy_localization/easy_localization.dart';
import 'package:find_pe/common/language/language_select_page.dart';
import 'package:find_pe/common/request_helper.dart';
import 'package:find_pe/pages/search_results.dart';
import 'package:flutter/material.dart';
import 'package:find_pe/common/style/app_colors.dart';
import 'package:lottie/lottie.dart';

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

    debugPrint("📡 Запрос: $url");

    final response = await requestHelper.get(url, log: true);

    if (response['success'] == true) {
      setState(() {
        items = List<Map<String, dynamic>>.from(response['data']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController(
      text: selectedSearch ?? "",
    );
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
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => showLanguageBottomSheet(context),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 15,
              child: Text(currentFlag, style: const TextStyle(fontSize: 24)),
            ),
          ),
        ),
        actions: [
          if (selectedSearch != null ||
              selectedTypeId != null ||
              selectedOrganizationId != null)
            IconButton(
              icon: Icon(Icons.clear, color: Colors.white),
              onPressed: () {
                getData();
                setState(() {
                  selectedSearch = null;
                  selectedTypeId = null;
                  selectedOrganizationId = null;
                  searchController.clear();
                });
              },
            ),

          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LottieBuilder.asset('assets/lotties/search.json',
              //pause
              repeat: false,
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  "polietilen_filtr".tr(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: selectedTypeId, // Используется selectedTypeId
                decoration: _inputDecoration("choose_type_polietilen".tr()),
                items: [
                  DropdownMenuItem(
                    value: null,
                    child: Text("Все"),
                  ), // Добавляем "Все"
                  ...product_types.map((type) {
                    return DropdownMenuItem<String>(
                      value: type["id"].toString(),
                      child: Text(type["name"]),
                    );
                  }).toList(),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedTypeId = value;
                  });
                  getData();
                },
              ),
              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                value: selectedOrganizationId,
                decoration: _inputDecoration("choose_manufacturer".tr()),
                items: [
                  DropdownMenuItem(
                    value: null,
                    child: Text("Все"),
                  ), // Добавляем "Все"
                  ...organizations.map((org) {
                    return DropdownMenuItem<String>(
                      value: org["id"].toString(),
                      child: Text(org["name"]),
                    );
                  }).toList(),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedOrganizationId = value;
                  });
                  getData();
                },
              ),
              const SizedBox(height: 12),

              TextField(
                controller: searchController,
                decoration: _inputDecoration("choose_mark_of_polietilen".tr()),
              ),
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => MyWidget(
                              search: searchController.text.trim(),
                              typeId: selectedTypeId,
                              organizationId: selectedOrganizationId,
                            ),
                      ),
                    );
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
      ),
    );
  }

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
