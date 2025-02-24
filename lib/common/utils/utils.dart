import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

abstract final class Utils {
  static String getPlatformForEOrder() {
    return Platform.isIOS ? 'klient_ios' : 'klient_android';
  }

  static String formatLeftSeconds(int seconds) {
    if (seconds < 60) {
      return '00:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${(seconds ~/ 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}';
    }
  }

  static String imageUrl(String path) {
    return 'https://api.insurance.uz/$path';
  }

  static final NumberFormat moneyFormat = NumberFormat.currency(
    locale: 'uz_UZ',
    symbol: '',
    decimalDigits: 0,
    name: '',
  );
  static bool isMarked = false;

  static String formatMoney(num amount) {
    return moneyFormat.format(amount);
  }

  static final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  static final DateFormat dateFormatUI = DateFormat('dd.MM.yyyy');

  static String formatBackendForUI(String date) {
    try {
      return dateFormatUI.format(dateFormat.parse(date));
    } catch (_) {
      return date;
    }
  }

  static DateTime? parseDate(String? date) {
    try {
      return dateFormat.parse(date!);
    } catch (_) {
      return null;
    }
  }

  static ({String? firstName, String? lastName, String? middleName})
      parseFullName(String? fullName) {
    String? firstName;
    String? lastName;
    String? middleName;

    fullName = fullName?.trim();

    try {
      lastName = fullName!.split(' ')[0];
    } catch (_) {}

    try {
      firstName = fullName!.split(' ')[1];
    } catch (_) {}

    try {
      middleName = fullName!.split(' ').sublist(2).join(' ');
    } catch (_) {}

    return (
      lastName: lastName,
      firstName: firstName,
      middleName: middleName,
    );
  }

  static FilteringTextInputFormatter decimalFormatter() {
    return FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'));
  }
}

class FormatUtil {
  static String formatCurrency(
    int amount, {
    String locale = 'uz_UZ',
    String? symbol,
    int decimalDigits = 0,
  }) {
    return NumberFormat.currency(
      locale: locale,
      symbol: symbol ?? '',
      // Default symbol is the dollar sign if none is provided
      decimalDigits: decimalDigits,
    ).format(amount);
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
