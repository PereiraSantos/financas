import 'package:financas/models/despesa.dart';
import 'package:floor/floor.dart';

@dao
abstract class DespesaDao {

  @Query('SELECT * FROM despesas')
  Future<List<Despesa>> findAllDespesa();

  @Query('SELECT * FROM despesas WHERE id_financa = :id')
  Future<List<Despesa>> findAllDespesaId(int id);

  @Query('SELECT * FROM despesas WHERE id = :id')
  Stream<Despesa> findDespesaById(int id);

  @insert
  Future<void> insertDespesa(Despesa despesa);

  @update
  Future<void> upDateDespesa(Despesa despesa);

  @Query('update despesas set descricao_despesa = :descricao WHERE id = :id')
  Future<void> updateDespesaDescricao(String descricao, int id);

  @Query('update despesas set valor_despesa = :valor  WHERE id = :id')
  Future<void> updateDespesaValor(double valor, int id);

  @Query('update despesas set data_despesa = :data WHERE id = :id')
  Future<void> updateDespesaData(String data, int id);

  @Query('DELETE FROM despesas WHERE id = :id')
  Future<void> delete(int id);
}
