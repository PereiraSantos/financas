import 'package:floor/floor.dart';

@Entity(tableName: 'despesas')
class Despesa{

  @PrimaryKey(autoGenerate: true) 
  final int id;

  @ColumnInfo(name: 'descricao_despesa', nullable: false)
  final String descricaoDespesa;

  @ColumnInfo(name: 'valor_despesa', nullable: false)
  final double valorDespesa;

  @ColumnInfo(name: 'data_despesa', nullable: false)
  final String dataDespesa;

  @ColumnInfo(name: 'id_financa', nullable: false)
  final int idFinanca;

  Despesa(this.id, this.descricaoDespesa, this.valorDespesa, this.dataDespesa, this.idFinanca);
}