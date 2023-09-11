// ignore_for_file: depend_on_referenced_packages
import 'dart:async';

import 'package:path/path.dart';
import 'package:silver_touch_task/modules/core/utils/app_config.dart';
import 'package:silver_touch_task/modules/dashboard/contact/model/model_contact.dart';
import 'package:sqflite/sqflite.dart';

import '../../dashboard/category/model/model_category.dart';

class OpenHelper {
  static final OpenHelper _instance = OpenHelper.internal();

  factory OpenHelper() => _instance;
  final String databaseName = 'silver_touch.db';
  final int databaseVersion = 1;

  static Database? dbBase;

  Future<Database?> get db async {
    if (dbBase != null) {
      return dbBase;
    }
    dbBase = await initDb();
    return dbBase;
  }

  initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);

    var theDb = await openDatabase(path, version: databaseVersion,
        onCreate: (Database db, int version) async {
      await db.execute('''
          create table ${AppConfig.tableCategory} ( 
          ${AppConfig.categoryId} INTEGER primary key, 
          ${AppConfig.categoryName} text not null)
          ''');

      await db.execute('''
          create table ${AppConfig.tableContact} ( 
          ${AppConfig.contactId} INTEGER primary key, 
          ${AppConfig.contactFirstName} text not null,
          ${AppConfig.contactLastName} text not null,
          ${AppConfig.contactImage} text not null,
          ${AppConfig.contactEmail} text not null,
          ${AppConfig.contactMobile} text not null,
          ${AppConfig.contactCategory} INTEGER not null)
          ''');
    });
    return theDb;
  }

  OpenHelper.internal();

  ///-----Start----Category------------
  Future<int> insertCategory(ModelCategory mModelCategory) async {
    var dbClient = await db;
    var result = await dbClient!
        .insert(AppConfig.tableCategory, mModelCategory.toJson());
    int id = -1;
    if (result != 0) {
      id = 1;
    }
    return id;
  }

  Future<List<ModelCategory>> getCategory() async {
    var dbClient = await db;
    var value =
        await dbClient!.rawQuery("SELECT * FROM ${AppConfig.tableCategory}");
    List<ModelCategory> mModelCategory = List<ModelCategory>.from(
        value.map((model) => ModelCategory.fromJson(model)));
    return mModelCategory;
  }

  Future<List<ModelCategory>> updateCategory(String name, int id) async {
    var dbClient = await db;
    var value = await dbClient!.rawQuery(
        'UPDATE ${AppConfig.tableCategory} SET ${AppConfig.categoryName} = \'$name\' WHERE ${AppConfig.categoryId} = $id');
    List<ModelCategory> mModelCategory = List<ModelCategory>.from(
        value.map((model) => ModelCategory.fromJson(model)));
    return mModelCategory;
  }

  Future<int> deleteCategory(int id) async {
    var dbClient = await db;
    return await dbClient!.rawDelete(
        'DELETE FROM ${AppConfig.tableCategory} WHERE ${AppConfig.categoryId} = ?',
        [id]);
  }

  ///-----End----Category------------

  ///-----Start----Contact------------
  Future<int> insertContact(ModelContact mModelContact) async {
    var dbClient = await db;
    var result =
        await dbClient!.insert(AppConfig.tableContact, mModelContact.toJson());
    int id = -1;
    if (result != 0) {
      id = 1;
    }
    return id;
  }

  Future<List<ModelContact>> getContact() async {
    var dbClient = await db;
    var value =
        await dbClient!.rawQuery("SELECT * FROM ${AppConfig.tableContact}");
    List<ModelContact> mModelContact = List<ModelContact>.from(
        value.map((model) => ModelContact.fromJson(model)));
    return mModelContact;
  }

  Future<bool> updateContact(Map<String, dynamic> row, int id) async {
    var dbClient = await db;
    await dbClient!.update(AppConfig.tableContact, row,
        where: '${AppConfig.contactId} = ?', whereArgs: [id]);
    return true;
  }

  Future<int> deleteContact(int id) async {
    var dbClient = await db;
    return await dbClient!.rawDelete(
        'DELETE FROM ${AppConfig.tableContact} WHERE ${AppConfig.contactId} = ?',
        [id]);
  }

  ///-----End----Contact------------

  /*
  Future<List<Mission>> emergencyLocalList(String missionID) async {
    var dbClient = await db;
    var value = await dbClient!.rawQuery("SELECT * FROM $tableMission WHERE $tableMission.$columnMissionId=$missionID");
    List<Mission> missionList = List<Mission>.from(value.map((model) => Mission.fromJson(model)));
    return missionList;
  }*/

  /*Future<int> removeBattery(int aircraftID) async {
    var dbClient = await db;
    return await dbClient!.rawDelete('DELETE FROM $tableFlightBattery WHERE $columnFlightAircraftId = ?', [aircraftID]);
  }*/

  Future close() async {
    var dbClient = await db;
    dbClient!.close();
  }
}
