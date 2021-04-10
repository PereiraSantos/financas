import 'package:floor/floor.dart';

@Entity(tableName: 'financas')
class Financa{

  @PrimaryKey(autoGenerate: true) 
  final int id;

  @ColumnInfo(name: 'valor_renda', nullable: false)
  final double valorRenda;

  @ColumnInfo(name: 'data_renda_inicial', nullable: false)
  final String dataRendaInicial;

  @ColumnInfo(name: 'data_renda_final', nullable: false)
  final String dataRendaFinal;

  @ColumnInfo(name: 'valor_poupar', nullable: false)
  final double valorPoupar;

  Financa(this.id, this.valorRenda, this.dataRendaInicial,this.dataRendaFinal ,this.valorPoupar);
}