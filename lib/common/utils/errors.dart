import 'package:easy_localization/easy_localization.dart';

final class ServerError {
  final String? message;

  ServerError([this.message]);

  @override
  String toString() {
    // return message ?? 'Server Error';
    return "serverErrorMessage".tr();
  }
}

final class UnauthenticatedError {
  @override
  String toString() {
    return 'unauthenticated'.tr();
  }
}

final class Unauthenticated {
  @override
  String toString() {
    return 'Jismoniy shaxsning E imzosi bilan kirish taqiqlanadi';
  }
}

final class NoDataError {
  final String? message;

  NoDataError([this.message]);

  @override
  String toString() {
    return message ?? 'noData'.tr();
  }
}

final class UnknownError {
  final String? message;

  UnknownError([this.message]);

  @override
  String toString() {
    return message ?? 'unknownError'.tr();
  }
}
