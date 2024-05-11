import 'package:flutter/material.dart';

class Validator {
  Validator._();

  static final _emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  static String? Function(String?) mustBeEmail(BuildContext context) {
    return (fieldValue) {
      if (fieldValue == null || fieldValue.isEmpty) {
        return 'Cannot be empty';
      }

      if (!_emailRegex.hasMatch(fieldValue)) {
        return 'Email is invalid';
      }

      return null;
    };
  }

  static String? Function(String?) cannotBeEmpty(BuildContext context) {
    return (fieldValue) {
      if (fieldValue == null || fieldValue.isEmpty) {
        return 'Cannot be empty';
      }
      return null;
    };
  }

  static String? Function(String?) mustBeNumber(BuildContext context) {
    return (fieldValue) {
      if (fieldValue == null || fieldValue.isEmpty) {
        return 'Cannot be empty';
      }

      final value = int.tryParse(fieldValue);

      if (value == null) {
        return 'Must be a number';
      }

      return null;
    };
  }
}
