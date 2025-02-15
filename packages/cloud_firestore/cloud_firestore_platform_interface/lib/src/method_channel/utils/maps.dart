// Copyright 2017, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.9

/// Casts a Map<dynamic, dynamic> to Map<String, dynamic>
Map<String, dynamic> asStringKeyedMap(Map<dynamic, dynamic> map) =>
    map?.cast<String, dynamic>();
