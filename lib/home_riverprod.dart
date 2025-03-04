// import 'package:easy_localization/easy_localization.dart';
// import 'package:find_pe/common/language/language_select_page.dart';
// import 'package:find_pe/common/style/app_colors.dart';
// import 'package:find_pe/pages/home_botom_shet.dart';
// import 'package:find_pe/pages/provider/product_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart';

// class ProductScreen extends ConsumerWidget {
//   const ProductScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final productsAsync = ref.watch(fetchProductsProvider);
//         final Map<String, String> localeFlags = {
//       'uz': '🇺🇿',
//       'ru': '🇷🇺',
//       'en': '🇬🇧',
//       'zh': '🇨🇳',
//       'ar': '🇸🇦',
//       'de': '🇩🇪',
//     };

//     String currentFlag = localeFlags[context.locale.languageCode] ?? '🌍';

//     return Scaffold(
//      appBar:  AppBar(
//         backgroundColor: AppColors.grade1,
//         centerTitle: true,
//         title: Text(
//           'FindPE',
//           style: TextStyle(
//             color: AppColors.backgroundColor,
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             showPolyethyleneFilter(context);
//           },
//           icon: CircleAvatar(
//             backgroundColor: AppColors.backgroundColor,
//             radius: 18,

//             child: SvgPicture.asset(
//               'assets/icons/filter.svg',
//               color: AppColors.grade1,
//               width: 25,
//               height: 25,
//             ),
//           ),
//         ),
//         actions: [
//           GestureDetector(
//             onTap: () => showLanguageBottomSheet(context),
//             child: CircleAvatar(
//               backgroundColor: Colors.white,
//               radius: 20,
//               child: Text(currentFlag, style: const TextStyle(fontSize: 24)),
//             ),
//           ),
//           SizedBox(width: 10),
//         ],
//       ),
//       body: productsAsync.when(
//          loading: () => const Center(child: CircularProgressIndicator()),
//         error: (err, _) => Center(child: Text('Ошибка: $err')),
//         data: (products) => Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 final data = products[index];

//                 return Container(
//                   margin: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 8,
//                   ),
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 5,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 24,
//                             backgroundColor: AppColors.grade1,
//                             child: Text(
//                               data.countries.name ?? "",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 data.meltIndex.toString(),
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 18,
//                                 ),
//                               ),
//                               Text(
//                                 data.organizations as String,
//                                 style: TextStyle(
//                                   color: AppColors.uiText,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       _buildRow("⚖️", "density", data.density as String),
//                       _buildRow("🔥", "melt_index", data.meltIndex as String),

//                       const SizedBox(height: 12),

//                       ElevatedButton.icon(
//                         onPressed: () {
//                           _openPDF(context, data.pdfFile as String);
//                         },
//                         icon: Icon(Icons.picture_as_pdf, color: Colors.white),
//                         label: Text(
//                           "view_pdf".tr(),
//                           style: TextStyle(color: AppColors.backgroundColor),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.grade1,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           padding: EdgeInsets.symmetric(
//                             vertical: 10,
//                             horizontal: 16,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       )
       
//       ),
//     );
//   }
// }
// Widget _buildRow(String icon, String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 6),
//       child: Row(
//         children: [
//           Text(icon, style: TextStyle(fontSize: 14)),
//           const SizedBox(width: 5),
//           Text(
//             label.tr(),
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//           ),
//           const SizedBox(width: 5),
//           Text(value, style: TextStyle(color: Colors.black87, fontSize: 14)),
//         ],
//       ),
//     );
//   }

//   // 📂 PDF-ni ochish funksiyasi
//   void _openPDF(BuildContext context, String fileName) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text("📄 $fileName ochilmoqda..."),
//         duration: Duration(seconds: 2),
//       ),
//     );
//     // TODO: PDF ochish uchun implementatsiya qo‘shish
//   }