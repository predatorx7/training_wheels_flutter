import 'package:path/path.dart' as path;
import 'package:flutter/foundation.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

import 'file_io_stub.dart' // Stubbed implementation by default.
    // Concrete implementation if File IO is available.
    if (dart.library.io) 'file_io.dart' as file_io;

Future<Database> _openDatabase(String dbPath) async {
  final DatabaseFactory databaseFactory;
  if (kIsWeb) {
    databaseFactory = databaseFactoryWeb;
  } else {
    databaseFactory = databaseFactoryIo;
  }

  final Database db = await databaseFactory.openDatabase(dbPath);

  return db;
}

Database? _cachedAppDatabase;

Future<Database> getAppDatabaseInstance() async {
  if (_cachedAppDatabase == null) {
    const appDatabaseFilePath = 'app-main.db';
    _cachedAppDatabase = await _openDatabase(path.join(
      await file_io.localPath,
      appDatabaseFilePath,
    ));
  }
  return _cachedAppDatabase!;
}

Database getAppDatabaseInstanceSync() {
  assert(
    _cachedAppDatabase != null,
    'Make sure you run `getAppDatabaseInstance` atleast once before using this function',
  );
  return _cachedAppDatabase!;
}

typedef AuthStoreRef = StoreRef<int, Map<String, Object?>>;

AuthStoreRef getAuthStore() {
  return intMapStoreFactory.store('auth');
}
