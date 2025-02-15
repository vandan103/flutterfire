// @dart = 2.9

// Copyright 2020, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.9

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void runGeoPointTests() {
  group('$GeoPoint', () {
    /*late*/ FirebaseFirestore firestore;

    setUpAll(() async {
      firestore = FirebaseFirestore.instance;
    });

    Future<DocumentReference> initializeTest(String path) async {
      String prefixedPath = 'flutter-tests/$path';
      await firestore.doc(prefixedPath).delete();
      return firestore.doc(prefixedPath);
    }

    test('sets a $GeoPoint & returns one', () async {
      DocumentReference doc = await initializeTest('geo-point');
      await doc.set({'foo': GeoPoint(10, -10)});
      DocumentSnapshot snapshot = await doc.get();
      GeoPoint geopoint = snapshot.data()['foo'];
      expect(geopoint, isA<GeoPoint>());
      expect(geopoint.latitude, equals(10));
      expect(geopoint.longitude, equals(-10));
    });

    test('updates a $GeoPoint & returns', () async {
      DocumentReference doc = await initializeTest('geo-point-update');
      await doc.set({'foo': GeoPoint(10, -10)});
      await doc.update({'foo': GeoPoint(-10, 10)});
      DocumentSnapshot snapshot = await doc.get();
      GeoPoint geopoint = snapshot.data()['foo'];
      expect(geopoint, isA<GeoPoint>());
      expect(geopoint.latitude, equals(-10));
      expect(geopoint.longitude, equals(10));
    });
  });
}
