import 'package:financas/models/financa.dart';
import 'package:floor/floor.dart';

@dao
abstract class FinancaDao {
  
  @Query('SELECT * FROM financas')
  Future<List<Financa>> findAllFinanca();

  @Query('SELECT * FROM financas WHERE id = :id')
  Future<List<Financa>> findFinancaById(int id);

  @insert
  Future<void> insertFinanca(Financa financa);   

  @Query('update financas set valor_renda = :renda WHERE id = :id')
  Future<void> updateFinanca(double renda, int id);   
 
  @Query('update financas set valor_poupar = :valor WHERE id = :id')
  Future<void> updateValorPoupar(double valor, int id);  

  @Query('update financas set data_renda_final = :data WHERE id = :id')
  Future<void> updateFinancaAtivo(String data, int id);  

  @Query('DELETE FROM financas WHERE id = :id')
  Future<void> delete(int id);
 }