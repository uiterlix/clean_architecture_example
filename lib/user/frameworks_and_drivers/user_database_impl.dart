import 'package:clean_architecture_example/user/entity/user_entity.dart';
import 'package:clean_architecture_example/user/interface_adapters/repository/user_database.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

@Singleton(as: UserDatabase)
class UserDatabaseImpl implements UserDatabase {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'user_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(email TEXT PRIMARY KEY, firstName TEXT, lastName TEXT, password TEXT)',
        );
      },
      version: 1,
    );
  }

  @override
  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert('users', {
      'email': user.email,
      'firstName': user.firstName,
      'lastName': user.lastName,
      'password': user.password,
    });
  }

  @override
  Future<void> updateUser(User user) async {
    final db = await database;
    await db.update(
      'users',
      {
        'firstName': user.firstName,
        'lastName': user.lastName,
        'password': user.password,
      },
      where: 'email = ?',
      whereArgs: [user.email],
    );
  }

  @override
  Future<List<User>> queryUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return User(
        firstName: maps[i]['firstName'],
        lastName: maps[i]['lastName'],
        email: maps[i]['email'],
        password: maps[i]['password'],
      );
    });
  }

  @override
  Future<void> deleteUser(String email) async {
    final db = await database;
    await db.delete('users', where: 'email = ?', whereArgs: [email]);
  }

  @override
  Future<bool> userExists(String email) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return maps.isNotEmpty;
  }

  @override
  Future<User> queryUser(String eMail) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [eMail],
    );
    if (maps.isEmpty) {
      throw Exception('User not found');
    }
    return User(
      firstName: maps[0]['firstName'],
      lastName: maps[0]['lastName'],
      email: maps[0]['email'],
      password: maps[0]['password'],
    );
  }
}