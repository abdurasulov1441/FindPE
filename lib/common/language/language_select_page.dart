import 'package:find_pe/common/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> showLanguageBottomSheet(BuildContext context) async {
  final List<Map<String, dynamic>> languages = [
    {'locale': const Locale('ru'), 'name': 'Русский', 'flag': '🇷🇺'},
    {'locale': const Locale('en'), 'name': 'English', 'flag': '🇬🇧'},
    {'locale': const Locale('zh'), 'name': '中文 (Chinese)', 'flag': '🇨🇳'},
    {'locale': const Locale('ar'), 'name': 'العربية (Arabic)', 'flag': '🇸🇦'},
    {'locale': const Locale('de'), 'name': 'Deutsch (German)', 'flag': '🇩🇪'},
  ];

  Locale? selectedLocale = context.locale;

  await showModalBottomSheet(
    backgroundColor: AppColors.backgroundColor,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isScrollControlled: true, // ✅ Позволяет раскрывать модальное окно
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.6, // ✅ Ограничиваем высоту окна до 60% экрана
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               Text(
                'select_language'.tr(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ).tr(),
              const SizedBox(height: 16),
              Expanded( // ✅ Используем Expanded, чтобы список не выходил за границы
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: languages.length,
                  itemBuilder: (context, index) {
                    final lang = languages[index];
                    return GestureDetector(
                      onTap: () {
                        selectedLocale = lang['locale'];
                        context.setLocale(selectedLocale!);
                        Navigator.pop(context); // Закрытие боттом-шита
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: selectedLocale == lang['locale']
                              ? Colors.blue.shade100
                              : Colors.white,
                          border: Border.all(
                            color: selectedLocale == lang['locale']
                                ? Colors.blue
                                : Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
                            ClipOval(
                              child: Container(
                                color: Colors.grey.shade200,
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  lang['flag'],
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              lang['name'],
                              style: TextStyle(
                                color: selectedLocale == lang['locale']
                                    ? Colors.blue
                                    : Colors.black,
                              ),
                            ),
                          ],
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
    },
  );
}
