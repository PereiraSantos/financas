import 'package:financas/database/database.dart';
import 'package:financas/models/despesa.dart';
import 'package:financas/models/financa.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Relatorio extends StatefulWidget {
  Relatorio({Key key}) : super(key: key);

  @override
  _RelatorioState createState() => _RelatorioState();
}

class _RelatorioState extends State<Relatorio> {
  String data = "";

  String mes = DateTime.now().month.toString();
  String tempMes = "";
  String mostraMes = "";
  int _indiceAtual = 0;

  String dataInicial = "";

  double valorFinanca = 0.0;

  double valorDespesa = 0.0;
  double valorRendaTotal = 0.0;
  String dataDespesa = "01/01/2999";

  double valorRenda = 0.0;
  String dataRenda = "01/01/2999";
  String dataFinancafinal = '';
  double valorPoupar = 0.0;

  int idFinanca = 0;

  List<Financa> listaFinancas;
  List<Despesa> listaDespesas;

  List<charts.Series<PieData, String>> _pieData;

  double alturaAlerta = 0;
  double alturaContainerFinancas = 0;

  @override
  void initState() {
    super.initState();
    _lendoFinancas();
    _pieData = List<charts.Series<PieData, String>>();
  }

  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relatório'),
      ),
      body: Container(
          color: Colors.white,
          child: ListView(
            children: [
              Container(
                width: double.infinity,
                height: 50,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50,
                      color: Colors.white,
                      child: ListTile(
                        title: Text("Relatorio financeiro",
                            style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'helvetica_neue_light',
                                color: Colors.black54)),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 4,
                child: Container(
                  width: double.infinity,
                  height: 95,
                  margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
                  color: Colors.white,
                  child: Row(
                    children: [
                      /*
                      container *renda *poupar *despesas *sobra
                    */

                      Container(
                        width: MediaQuery.of(context).size.width * 0.24,
                        height: 95,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 30,
                              color: Colors.white,
                              child: Text(
                                "Renda",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'helvetica_neue_light',
                                    color: Colors.black54),
                              ),
                              padding: EdgeInsets.fromLTRB(5, 3, 1, 1),
                            ),
                            Container(
                              width: double.infinity,
                              height: 30,
                              color: Colors.white,
                              child: Text(
                                "R\$:" + this.valorFinanca.toStringAsFixed(2),
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'helvetica_neue_light',
                                    color: Colors.green),
                              ),
                              padding: EdgeInsets.fromLTRB(5, 3, 1, 1),
                            ),
                            Divider(
                              height: 1,
                              color: Colors.black54,
                            ),
                            Container(
                              width: double.infinity,
                              height: 30,
                              color: Colors.white,
                              child: Text(
                                this.dataInicial + "  a",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'helvetica_neue_light',
                                    color: Colors.black54),
                              ),
                              padding: EdgeInsets.fromLTRB(5, 5, 1, 1),
                            ),
                          ],
                        ),
                      ),

                      /*
                      container *valor renda *valor poupar *valor despesas *valor sobra
                    */

                      Container(
                        width: MediaQuery.of(context).size.width * 0.24,
                        height: 95,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 30,
                              color: Colors.white,
                              child: Text(
                                "Poupar",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'helvetica_neue_light',
                                    color: Colors.black54),
                              ),
                              padding: EdgeInsets.fromLTRB(5, 3, 1, 1),
                            ),
                            Container(
                              width: double.infinity,
                              height: 30,
                              color: Colors.white,
                              child: Text(
                                "R\$:" + this.valorPoupar.toStringAsFixed(2),
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'helvetica_neue_light',
                                    color: Colors.green),
                              ),
                              padding: EdgeInsets.fromLTRB(5, 3, 1, 1),
                            ),
                            Divider(
                              height: 1,
                              color: Colors.black54,
                            ),
                            Container(
                              width: double.infinity,
                              height: 30,
                              color: Colors.white,
                              child: Text(
                                this.data,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'helvetica_neue_light',
                                    color: Colors.black54),
                              ),
                              padding: EdgeInsets.fromLTRB(3, 5, 1, 1),
                            ),
                          ],
                        ),
                      ),

                      /*
                      container *icon editar 
                    */

                      Container(
                          width: MediaQuery.of(context).size.width * 0.24,
                          height: 95,
                          color: Colors.white,
                          child: Column(children: [
                            Container(
                              width: double.infinity,
                              height: 30,
                              color: Colors.white,
                              child: Text(
                                "Despesa",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'helvetica_neue_light',
                                    color: Colors.black54),
                              ),
                              padding: EdgeInsets.fromLTRB(5, 3, 1, 1),
                            ),
                            GestureDetector(
                                onTap: () {
                                  int chave = this.listaDespesas.length;
                                  _showAlertDespesas(chave.toDouble());
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 30,
                                  color: Colors.white,
                                  child: Text(
                                    "R\$:" +
                                        this.valorDespesa.toStringAsFixed(2),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'helvetica_neue_light',
                                        color: Colors.red),
                                  ),
                                  padding: EdgeInsets.fromLTRB(5, 3, 1, 1),
                                )),
                            Divider(
                              height: 1,
                              color: Colors.black54,
                            ),
                          ])),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.24,
                          height: 95,
                          color: Colors.white,
                          child: Column(children: [
                            Container(
                              width: double.infinity,
                              height: 30,
                              color: Colors.white,
                              child: Text(
                                "Sobra",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'helvetica_neue_light',
                                    color: Colors.black54),
                              ),
                              padding: EdgeInsets.fromLTRB(5, 3, 1, 1),
                            ),
                            Container(
                              width: double.infinity,
                              height: 30,
                              color: Colors.white,
                              child: Text(
                                "R\$:" +
                                    this.valorRendaTotal.toStringAsFixed(2),
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'helvetica_neue_light',
                                    color: Colors.blue),
                              ),
                              padding: EdgeInsets.fromLTRB(5, 3, 1, 1),
                            ),
                            Divider(
                              height: 1,
                              color: Colors.black54,
                            ),
                          ])),
                    ],
                  ),
                ),
              ),

              /*
              container com o grafico
              */

              Divider(
                height: 15,
                color: Colors.white,
              ),
              Container(
                width: double.infinity,
                height: 300,
                color: Colors.white,
                child: charts.PieChart(generateData(),
                    animate: false,
                    animationDuration: Duration(seconds: 0),
                    defaultRenderer: new charts.ArcRendererConfig(
                        arcWidth: 150,
                        arcRendererDecorators: [
                          new charts.ArcLabelDecorator(
                              labelPosition: charts.ArcLabelPosition.inside)
                        ])),
              ),
              Container(
                width: double.infinity,
                height: 100,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.09,
                      height: 25,
                      color: Colors.white,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      height: 25,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.03,
                            height: 10,
                            color: Colors.red,
                            padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 25,
                            color: Colors.white,
                            padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                            child: Text(
                              "Despesas",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      height: 25,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.03,
                            height: 10,
                            color: Colors.green,
                            padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 25,
                            color: Colors.white,
                            padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                            child: Text(
                              "Poupar",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      height: 25,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.03,
                            height: 10,
                            color: Colors.blue,
                            padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 25,
                            color: Colors.white,
                            padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                            child: Text(
                              "Sobra",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
      bottomNavigationBar: new BottomNavigationBar(
        onTap: onTabTapped,
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(
              Icons.refresh,
              color: Colors.green,
            ),
            // ignore: deprecated_member_use
            title: new Text(
              "Recarregar",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'helvetica_neue_light',
                  fontSize: 16),
            ),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(
              Icons.calendar_today,
              color: Colors.green,
            ),
            // ignore: deprecated_member_use
            title: new Text("Troca mês",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'helvetica_neue_light',
                    fontSize: 18)),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _indiceAtual = index;
      if (_indiceAtual == 0) {
        _lendoFinancas();
      } else if (_indiceAtual == 1) {
        _lendoFinancasEscolhida();
      }
    });
  }

  _lendoFinancas() async {
    double tempValorRenda = 0;
    double tempValorPoupar = 0;
    String tempDatainicial = "";
    int tempId;

    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final financaDao = database.financaDao;
    this.listaFinancas = await financaDao.findAllFinanca();

    if (this.listaFinancas != null) {
      for (int i = 0; i < this.listaFinancas.length; i++) {
        tempValorRenda = this.listaFinancas[i].valorRenda;
        tempValorPoupar = this.listaFinancas[i].valorPoupar;
        tempDatainicial = this.listaFinancas[i].dataRendaInicial;
        tempId = this.listaFinancas[i].id;
        this.data = _geraData();
      }
    }

    setState(() {
      this.valorFinanca = tempValorRenda;
      this.valorPoupar = tempValorPoupar;
      this.dataInicial = tempDatainicial;
      this.mostraMes = this.tempMes;
      this.idFinanca = tempId;
    });
    _lendoDespensas();
  }

  _lendoDespensas() async {
    double temporariaSoma = 0;
    int idTemp = this.idFinanca;
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final despesaDao = database.despesaDao;
    this.listaDespesas = await despesaDao.findAllDespesaId(idTemp);
    for (int i = 0; i < this.listaDespesas.length; i++) {
      temporariaSoma += this.listaDespesas[i].valorDespesa;
    }

    this.valorDespesa = temporariaSoma;

    setState(() {
      this.valorRendaTotal =
          this.valorFinanca - this.valorPoupar - this.valorDespesa;
    });
  }

  _lendoFinancasEscolhidaU(int id) async {
    double tempValorRenda = 0;
    double tempValorPoupar = 0;
    String tempDatainicial = "";
    int tempId;

    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final financaDao = database.financaDao;
    this.listaFinancas = await financaDao.findFinancaById(id);

    if (this.listaFinancas != null) {
      for (int i = 0; i < this.listaFinancas.length; i++) {
        tempValorRenda = this.listaFinancas[i].valorRenda;
        tempValorPoupar = this.listaFinancas[i].valorPoupar;
        tempDatainicial = this.listaFinancas[i].dataRendaInicial;
        this.dataFinancafinal = this.listaFinancas[i].dataRendaFinal;
        tempId = this.listaFinancas[i].id;
      }
    }

    setState(() {
      this.valorFinanca = tempValorRenda;
      this.valorPoupar = tempValorPoupar;
      this.dataInicial = tempDatainicial;
      this.mostraMes = this.tempMes;
      this.idFinanca = tempId;
      this.data = this.dataFinancafinal;
    });
    _lendoDespensasEscolhida(tempId);
  }

  _lendoDespensasEscolhida(int id) async {
    double temporariaSoma = 0;

    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final despesaDao = database.despesaDao;
    this.listaDespesas = await despesaDao.findAllDespesaId(id);
    for (int i = 0; i < this.listaDespesas.length; i++) {
      temporariaSoma += this.listaDespesas[i].valorDespesa;
    }

    this.valorDespesa = temporariaSoma;

    setState(() {
      this.valorRendaTotal =
          this.valorFinanca - this.valorPoupar - this.valorDespesa;
    });
  }

  generateData() {
    var piedata = [
      new PieData("R\$:" + this.valorPoupar.toStringAsFixed(2),
          this.valorPoupar / 100, Colors.green),
      new PieData("R\$:" + this.valorRendaTotal.toStringAsFixed(2),
          this.valorRendaTotal / 100, Colors.blue),
      new PieData("R\$:" + this.valorDespesa.toStringAsFixed(2),
          this.valorDespesa / 100, Colors.red),
    ];
    _pieData = [];
    _pieData.add(
      charts.Series(
        domainFn: (PieData data, _) => data.activity,
        measureFn: (PieData data, _) => data.time,
        id: 'Time spent',
        data: piedata,
        colorFn: (PieData data, _) => data.color,
        labelAccessorFn: (PieData row, _) => '${row.activity}',
      ),
    );
    return _pieData;
  }

  _lendoFinancasEscolhida() async {
    int chave;

    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final financaDao = database.financaDao;
    this.listaFinancas = await financaDao.findAllFinanca();
    if (this.listaFinancas != null) {
      chave = this.listaFinancas.length;
      _showAlertFinancas(chave.toDouble());
    }
  }

  void _showAlertFinancas(double chave) {
    double valorAlertaTemp = chave * 75;
    double valorContainerTemp = valorAlertaTemp + 60;

    if (valorContainerTemp >= 420.0) {
      this.alturaAlerta = 420.0;
      this.alturaContainerFinancas = 350.0;
    } else {
      this.alturaAlerta = valorContainerTemp;
      this.alturaContainerFinancas = valorAlertaTemp;
    }

    AlertDialog dialog = new AlertDialog(
      content: new Container(
        width: 260.0,
        height: this.alturaAlerta, //este
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFFFFF),
          borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 30,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 200,
                    height: 30,
                    color: Colors.white,
                    child: Text("Controles",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 26.0,
                            fontFamily: 'helvetica_neue_light')),
                  ),
                  Container(
                    width: 50,
                    height: 30,
                    alignment: Alignment.topRight,
                    color: Colors.white,
                    child: IconButton(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(bottom: 2),
                      icon: Icon(
                        Icons.close,
                      ),
                      color: Colors.red,
                      iconSize: 20,
                      splashColor: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: 30,
              color: Colors.white,
            ),
            Container(
              width: double.infinity,
              height: this.alturaContainerFinancas, // este tambem
              color: Colors.white,
              child: ListView(
                children: [
                  if (this.listaFinancas != null) ...[
                    for (int i = 0; i < this.listaFinancas.length; i++)
                      Card(
                        elevation: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _lendoFinancasEscolhidaU(
                                    this.listaFinancas[i].id);
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.60,
                                height: 60,
                                color: Colors.white,
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: ListTile(
                                  title: Text(
                                      "Data: " +
                                          this
                                              .listaFinancas[i]
                                              .dataRendaInicial +
                                          " \nValor R\$:" +
                                          this
                                              .listaFinancas[i]
                                              .valorRenda
                                              .toStringAsFixed(2),
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 21,
                                          fontFamily: 'helvetica_neue_light')),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ] else
                    ...[]
                ],
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, child: dialog);
  }

  void _showAlertDespesas(double chave) {
    double valorAlertaTemp = chave * 85;
    double valorContainerTemp = valorAlertaTemp + 70;

    if (valorContainerTemp >= 430.0) {
      this.alturaAlerta = 430.0;
      this.alturaContainerFinancas = 350.0;
    } else {
      this.alturaAlerta = valorContainerTemp;
      this.alturaContainerFinancas = valorAlertaTemp;
    }

    AlertDialog dialog = new AlertDialog(
      content: new Container(
        width: 260.0,
        height: this.alturaAlerta, //este
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFFFFF),
          borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 30,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 200,
                    height: 30,
                    color: Colors.white,
                    child: Text("Despesas",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 26.0,
                            fontFamily: 'helvetica_neue_light')),
                  ),
                  Container(
                    width: 50,
                    height: 30,
                    alignment: Alignment.topRight,
                    color: Colors.white,
                    child: IconButton(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(bottom: 2),
                      icon: Icon(
                        Icons.close,
                      ),
                      color: Colors.red,
                      iconSize: 20,
                      splashColor: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: 30,
              color: Colors.white,
            ),
            Container(
              width: double.infinity,
              height: this.alturaContainerFinancas, // este tambem
              color: Colors.white,
              child: ListView(
                children: [
                  if (this.listaDespesas != null) ...[
                    for (int i = 0; i < this.listaDespesas.length; i++)
                      Card(
                        elevation: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.60,
                              height: 80,
                              color: Colors.white,
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: ListTile(
                                title: Text(
                                    "Despesa: " +
                                        this.listaDespesas[i].descricaoDespesa +
                                        " \nData: " +
                                        this.listaDespesas[i].dataDespesa +
                                        "\nValor R\$:" +
                                        this
                                            .listaDespesas[i]
                                            .valorDespesa
                                            .toStringAsFixed(2),
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 21,
                                        fontFamily: 'helvetica_neue_light')),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ] else
                    ...[]
                ],
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, child: dialog);
  }

  String _geraData() {
    return data = DateTime.now().day.toString() +
        "/" +
        DateTime.now().month.toString() +
        "/" +
        DateTime.now().year.toString();
  }
}

class PieData {
  String activity;
  double time;
  final charts.Color color;

  PieData(this.activity, this.time, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
