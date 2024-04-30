// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:freo_assignment/features/wiki/data/data_source/local/dao/wiki_dao.dart';
import 'package:freo_assignment/features/wiki/data/model/page_model.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [PageModel])
abstract class AppDatabase extends FloorDatabase {
  WikiPageDao get wikiPageDao;
}
