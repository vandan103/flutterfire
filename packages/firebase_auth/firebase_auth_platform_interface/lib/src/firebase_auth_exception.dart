// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// @dart=2.9

import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';
import 'auth_credential.dart';

/// Generic exception related to Firebase Authentication. Check the error code
/// and message for more details.
class FirebaseAuthException extends FirebaseException implements Exception {
  // ignore: public_member_api_docs
  @protected
  FirebaseAuthException(
      {@required this.message,
      @required this.code,
      this.email,
      this.credential,
      this.phoneNumber,
      this.tenantId})
      : super(plugin: 'firebase_auth', message: message, code: code);

  /// Unique error code
  final String code;

  /// Complete error message.
  final String message;

  /// The email of the user's account used for sign-in/linking.
  final String email;

  /// The [AuthCredential] that can be used to resolve the error.
  final AuthCredential credential;

  /// The phone number of the user's account used for sign-in/linking.
  final String phoneNumber;

  /// The tenant ID being used for sign-in/linking.
  final String tenantId;
}
