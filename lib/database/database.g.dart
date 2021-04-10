// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  DespesaDao _despesaDaoInstance;

  FinancaDao _financaDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `despesas` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `descricao_despesa` TEXT NOT NULL, `valor_despesa` REAL NOT NULL, `data_despesa` TEXT NOT NULL, `id_financa` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `financas` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `valor_renda` REAL NOT NULL, `data_renda_inicial` TEXT NOT NULL, `data_renda_final` TEXT NOT NULL, `valor_poupar` REAL NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  DespesaDao get despesaDao {
    return _despesaDaoInstance ??= _$DespesaDao(database, changeListener);
  }

  @override
  FinancaDao get financaDao {
    return _financaDaoInstance ??= _$FinancaDao(database, changeListener);
  }
}

class _$DespesaDao extends DespesaDao {
  _$DespesaDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _despesaInsertionAdapter = InsertionAdapter(
            database,
            'despesas',
            (Despesa item) => <String, dynamic>{
                  'id': item.id,
                  'descricao_despesa': item.descricaoDespesa,
                  'valor_despesa': item.valorDespesa,
                  'data_despesa': item.dataDespesa,
                  'id_financa': item.idFinanca
                },
            changeListener),
        _despesaUpdateAdapter = UpdateAdapter(
            database,
            'despesas',
            ['id'],
            (Despesa item) => <String, dynamic>{
                  'id': item.id,
                  'descricao_despesa': item.descricaoDespesa,
                  'valor_despesa': item.valorDespesa,
                  'data_despesa': item.dataDespesa,
                  'id_financa': item.idFinanca
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Despesa> _despesaInsertionAdapter;

  final UpdateAdapter<Despesa> _despesaUpdateAdapter;

  @override
  Future<List<Despesa>> findAllDespesa() async {
    return _queryAdapter.queryList('SELECT * FROM despesas',
        mapper: (Map<String, dynamic> row) => Despesa(
            row['id'] as int,
            row['descricao_despesa'] as String,
            row['valor_despesa'] as double,
            row['data_despesa'] as String,
            row['id_financa'] as int));
  }

  @override
  Future<List<Despesa>> findAllDespesaId(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM despesas WHERE id_financa = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Despesa(
            row['id'] as int,
            row['descricao_despesa'] as String,
            row['valor_despesa'] as double,
            row['data_despesa'] as String,
            row['id_financa'] as int));
  }

  @override
  Stream<Despesa> findDespesaById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM despesas WHERE id = ?',
        arguments: <dynamic>[id],
        queryableName: 'despesas',
        isView: false,
        mapper: (Map<String, dynamic> row) => Despesa(
            row['id'] as int,
            row['descricao_despesa'] as String,
            row['valor_despesa'] as double,
            row['data_despesa'] as String,
            row['id_financa'] as int));
  }

  @override
  Future<void> updateDespesaDescricao(String descricao, int id) async {
    await _queryAdapter.queryNoReturn(
        'update despesas set descricao_despesa = ? WHERE id = ?',
        arguments: <dynamic>[descricao, id]);
  }

  @override
  Future<void> updateDespesaValor(double valor, int id) async {
    await _queryAdapter.queryNoReturn(
        'update despesas set valor_despesa = ? WHERE id = ?',
        arguments: <dynamic>[valor, id]);
  }

  @override
  Future<void> updateDespesaData(String data, int id) async {
    await _queryAdapter.queryNoReturn(
        'update despesas set data_despesa = ? WHERE id = ?',
        arguments: <dynamic>[data, id]);
  }

  @override
  Future<void> delete(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM despesas WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> insertDespesa(Despesa despesa) async {
    await _despesaInsertionAdapter.insert(despesa, OnConflictStrategy.abort);
  }

  @override
  Future<void> upDateDespesa(Despesa despesa) async {
    await _despesaUpdateAdapter.update(despesa, OnConflictStrategy.abort);
  }
}

class _$FinancaDao extends FinancaDao {
  _$FinancaDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _financaInsertionAdapter = InsertionAdapter(
            database,
            'financas',
            (Financa item) => <String, dynamic>{
                  'id': item.id,
                  'valor_renda': item.valorRenda,
                  'data_renda_inicial': item.dataRendaInicial,
                  'data_renda_final': item.dataRendaFinal,
                  'valor_poupar': item.valorPoupar
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Financa> _financaInsertionAdapter;

  @override
  Future<List<Financa>> findAllFinanca() async {
    return _queryAdapter.queryList('SELECT * FROM financas',
        mapper: (Map<String, dynamic> row) => Financa(
            row['id'] as int,
            row['valor_renda'] as double,
            row['data_renda_inicial'] as String,
            row['data_renda_final'] as String,
            row['valor_poupar'] as double));
  }

  @override
  Future<List<Financa>> findFinancaById(int id) async {
    return _queryAdapter.queryList('SELECT * FROM financas WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Financa(
            row['id'] as int,
            row['valor_renda'] as double,
            row['data_renda_inicial'] as String,
            row['data_renda_final'] as String,
            row['valor_poupar'] as double));
  }

  @override
  Future<void> updateFinanca(double renda, int id) async {
    await _queryAdapter.queryNoReturn(
        'update financas set valor_renda = ? WHERE id = ?',
        arguments: <dynamic>[renda, id]);
  }

  @override
  Future<void> updateValorPoupar(double valor, int id) async {
    await _queryAdapter.queryNoReturn(
        'update financas set valor_poupar = ? WHERE id = ?',
        arguments: <dynamic>[valor, id]);
  }

  @override
  Future<void> updateFinancaAtivo(String data, int id) async {
    await _queryAdapter.queryNoReturn(
        'update financas set data_renda_final = ? WHERE id = ?',
        arguments: <dynamic>[data, id]);
  }

  @override
  Future<void> delete(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM financas WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> insertFinanca(Financa financa) async {
    await _financaInsertionAdapter.insert(financa, OnConflictStrategy.abort);
  }
}
