import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:untitled11/main5.dart';
class DbHelper{

static Database? _database;

Future<Database?> get  db async{

  if(_database!=null){
    return _database;
  }
  _database=await initDatabase();
}


Future<Database> initDatabase() async{

  Directory document_Directory =await getApplicationDocumentsDirectory();

  var openDB=openDatabase(document_Directory.path,version: 1,onCreate: _oncreate);

  return openDB;
}

_oncreate(Database db,  int version) async{
await db.execute(
'''
CREATE TABLE product


(
id INTEGER PRIMARY KEY,
tittle TEXT,
 
)

'''

    );



}


Future insertProductData(ProductModel todo)async{

  Database? database=await db;
  return await  database?.insert("product",ProductModel().toJson());
}


Future< List<ProductModel>?> getProductData() async{
  Database? database=await db;
var data=await database!.query("product",orderBy: "id");


List <ProductModel>  productModel= data.map((e) => ProductModel.fromJson(e)).toList();
return productModel;


}




}