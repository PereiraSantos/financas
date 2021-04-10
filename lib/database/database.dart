import 'dart:async';
import 'package:financas/dao/despesadao.dart';
import 'package:financas/dao/financadao.dart';
import 'package:financas/models/despesa.dart';
import 'package:financas/models/financa.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

  


part 'database.g.dart'; // the generated code will be there

 @Database(version: 1, entities: [Despesa, Financa])
 abstract class AppDatabase extends FloorDatabase {
  DespesaDao get despesaDao;
  FinancaDao get financaDao;

 }