// Copyright 2020, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.9

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import './utils/exception.dart';
import '../platform_interface/platform_interface_crashlytics.dart';

/// The entry point for accessing a method channel based Crashlytics instance.
///
/// You can get an instance by calling [MethodChannelFirebaseCrashlytics.instance].
class MethodChannelFirebaseCrashlytics extends FirebaseCrashlyticsPlatform {
  /// Create an instance of [MethodChannelFirebaseCrashlytics].
  MethodChannelFirebaseCrashlytics({FirebaseApp app}) : super(appInstance: app);

  /// The [MethodChannel] used to communicate with the native plugin
  static MethodChannel channel = MethodChannel(
    'plugins.flutter.io/firebase_crashlytics',
  );

  bool /*!*/ _isCrashlyticsCollectionEnabled;

  @override
  bool get isCrashlyticsCollectionEnabled {
    return _isCrashlyticsCollectionEnabled;
  }

  @override
  MethodChannelFirebaseCrashlytics setInitialValues({
    bool /*!*/ isCrashlyticsCollectionEnabled,
  }) {
    this._isCrashlyticsCollectionEnabled = isCrashlyticsCollectionEnabled;
    return this;
  }

  @override
  Future<bool /*!*/ > checkForUnsentReports() async {
    try {
      Map<String, dynamic> data =
          await channel.invokeMapMethod<String, dynamic>(
              'Crashlytics#checkForUnsentReports');

      return data['unsentReports'];
    } catch (e, s) {
      throw convertPlatformException(e, s);
    }
  }

  @override
  Future<void> crash() async {
    try {
      await channel.invokeMethod<void>('Crashlytics#crash');
    } catch (e, s) {
      throw convertPlatformException(e, s);
    }
  }

  @override
  Future<void> deleteUnsentReports() async {
    try {
      await channel.invokeMethod<void>('Crashlytics#deleteUnsentReports');
    } catch (e, s) {
      throw convertPlatformException(e, s);
    }
  }

  @override
  Future<bool /*!*/ > didCrashOnPreviousExecution() async {
    try {
      Map<String, dynamic> data =
          await channel.invokeMapMethod<String, dynamic>(
              'Crashlytics#didCrashOnPreviousExecution');

      return data['didCrashOnPreviousExecution'];
    } catch (e, s) {
      throw convertPlatformException(e, s);
    }
  }

  @override
  Future<void> recordError({
    String /*!*/ exception,
    String /*!*/ information,
    String /*?*/ reason,
    List<Map<String, String>> /*?*/ stackTraceElements,
  }) async {
    try {
      await channel
          .invokeMethod<void>('Crashlytics#recordError', <String, dynamic>{
        'exception': exception,
        'information': information,
        'reason': reason,
        'stackTraceElements': stackTraceElements ?? [],
      });
    } catch (e, s) {
      throw convertPlatformException(e, s);
    }
  }

  @override
  Future<void> log(String message) async {
    try {
      await channel.invokeMethod<void>('Crashlytics#log', <String, dynamic>{
        'message': message,
      });
    } catch (e, s) {
      throw convertPlatformException(e, s);
    }
  }

  @override
  Future<void> sendUnsentReports() async {
    try {
      await channel.invokeMethod<void>('Crashlytics#sendUnsentReports');
    } catch (e, s) {
      throw convertPlatformException(e, s);
    }
  }

  @override
  Future<void> setCrashlyticsCollectionEnabled(bool enabled) async {
    try {
      Map<String, dynamic> data = await channel
          .invokeMapMethod<String, dynamic>(
              'Crashlytics#setCrashlyticsCollectionEnabled', <String, dynamic>{
        'enabled': enabled,
      });

      _isCrashlyticsCollectionEnabled = data['isCrashlyticsCollectionEnabled'];
    } catch (e, s) {
      throw convertPlatformException(e, s);
    }
  }

  @override
  Future<void> setUserIdentifier(String identifier) async {
    try {
      await channel.invokeMethod<void>(
          'Crashlytics#setUserIdentifier', <String, dynamic>{
        'identifier': identifier,
      });
    } catch (e, s) {
      throw convertPlatformException(e, s);
    }
  }

  @override
  Future<void> setCustomKey(String key, String value) async {
    try {
      await channel
          .invokeMethod<void>('Crashlytics#setCustomKey', <String, dynamic>{
        'key': key,
        'value': value,
      });
    } catch (e, s) {
      throw convertPlatformException(e, s);
    }
  }
}
