import 'package:financas/componente_widget/cabecalho_app.dart';
import 'package:financas/containers/relatorio.dart';
import 'package:financas/database/database.dart';
import 'package:financas/models/despesa.dart';
import 'package:financas/models/financa.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textControllerDescricaoDespesa =
      TextEditingController();
  TextEditingController textControllerDataDespesa = TextEditingController();
  TextEditingController textControllerValorDespesa = TextEditingController();

  TextEditingController textControllerValorFinanca = TextEditingController();
  TextEditingController textControllerDataFinanca = TextEditingController();
  TextEditingController textControllerValorPoupar = TextEditingController();

  String data = DateTime.now().day.toString() +
      "/" +
      DateTime.now().month.toString() +
      "/" +
      DateTime.now().year.toString();

  String mes = DateTime.now().month.toString();
  String tempMes = "";
  String mostraMes = "";

  String dataInicial = "";

  String descricaoDespesa;
  double valorDespesa = 0;
  double valorRendaTotal = 0;
  String dataDespesa = "";

  double valorFinanca = 0;
  String dataFinanca = "";
  double valorPoupar = 0;

  int _indiceAtual = 0;

  int idFinanca = 0;
  int idDespesa = 0;

  List<Financa> listaFinancas;
  List<Despesa> listaDespesas;

  @override
  void initState() {
    super.initState();
    _lendoFinancas();
    //_lendoDespensas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Controle Finanças'),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _lendoFinancas();
            },
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView(children: [
          /*
          container *data *mes
          */

          CabecalhoApp(
              mostraMes: this.mes,
              dataInicial: this.dataInicial,
              data: this.data),
          Divider(
            height: 6,
            color: Colors.white,
          ),

          /*
          car *renda *poupar *despesas *sobra
          e seus valores
          */

          Card(
            elevation: 4,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
              color: Colors.white,
              child: Row(
                children: [
                  /*
                      container *renda *poupar *despesas *sobra
                    */

                  Container(
                    width: MediaQuery.of(context).size.width * 0.32,
                    height: 70,
                    color: Colors.white,
                    child: Card(
                        elevation: 4,
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.28,
                              height: 30,
                              color: Colors.green,
                              child: Text(
                                "Renda",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'helvetica_neue_light',
                                    color: Colors.white),
                              ),
                              padding: EdgeInsets.fromLTRB(0, 5, 1, 1),
                            ),
                            GestureDetector(
                                onTap: () {
                                  _showAlertAlteraFinancaValor();
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 30,
                                  color: Colors.green,
                                  child: Text(
                                    "R\$:"+this.valorFinanca.toStringAsFixed(2),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'helvetica_neue_light',
                                        color: Colors.white),
                                  ),
                                  padding: EdgeInsets.fromLTRB(5, 3, 1, 1),
                                )),
                          ],
                        )),
                  ),

                  /*
                      container *valor renda *valor poupar *valor despesas *valor sobra
                    */

                  Container(
                    width: MediaQuery.of(context).size.width * 0.32,
                    height: 70,
                    color: Colors.white,
                    child: Card(
                        elevation: 4,
                        color: Colors.green,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.28,
                              height: 30,
                              color: Colors.green,
                              child: Text(
                                "Poupar",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'helvetica_neue_light',
                                    color: Colors.white),
                              ),
                              padding: EdgeInsets.fromLTRB(0, 5, 1, 1),
                            ),
                            GestureDetector(
                                onTap: () {
                                  _showAlertAlteraFinancaPoupar();
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 30,
                                  color: Colors.green,
                                  child: Text(
                                    "R\$:"+this.valorPoupar.toStringAsFixed(2),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'helvetica_neue_light',
                                        color: Colors.white),
                                  ),
                                  padding: EdgeInsets.fromLTRB(5, 3, 1, 1),
                                )),
                          ],
                        )),
                  ),

                  /*
                      container *icon editar 
                    */

                  Container(
                      width: MediaQuery.of(context).size.width * 0.32,
                      height: 70,
                      color: Colors.white,
                      child: Card(
                          elevation: 4,
                          color: Colors.blue,
                          child: Column(children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.28,
                              height: 30,
                              color: Colors.blue,
                              child: Text(
                                "Sobra",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'helvetica_neue_light',
                                    color: Colors.white),
                              ),
                              padding: EdgeInsets.fromLTRB(0, 5, 1, 1),
                            ),
                            Container(
                              width: double.infinity,
                              height: 30,
                              color: Colors.blue,
                              child: Text(
                                "R\$:"+this.valorRendaTotal.toStringAsFixed(2),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'helvetica_neue_light',
                                    color: Colors.white),
                              ),
                              padding: EdgeInsets.fromLTRB(5, 3, 1, 1),
                            ),
                          ]))),
                ],
              ),
            ),
          ),

          /*
          container lista das despesas
          */
          Divider(
            height: 6,
            color: Colors.white,
          ),
          Container(
              width: double.infinity,
              height: 40,
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Card(
                  elevation: 4,
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        width: MediaQuery.of(context).size.width * 0.67,
                        height: 20,
                        color: Colors.red,
                        child: Text(
                          "Despesas",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'helvetica_neue_light',
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.29,
                        height: 40,
                        color: Colors.red,
                        child: Text(
                          "R\$:"+this.valorDespesa.toStringAsFixed(2),
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'helvetica_neue_light',
                              color: Colors.white),
                        ),
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      ),
                    ],
                  ))),
          Divider(
            height: 6,
            color: Colors.white,
          ),
          Container(
            width: double.infinity,
            height: 460,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (this.listaDespesas != null) ...[
                    for (int i = 0; i < this.listaDespesas.length; i++)
                      Card(
                          elevation: 4,
                          child: Row(
                            children: [
                              /*
                              container *descricao despesas
                              */
                              Container(
                                width: MediaQuery.of(context).size.width * 0.67,
                                height: 80,
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 56,
                                      color: Colors.white,
                                      padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                                      child: Text(
                                        listaDespesas[i]
                                            .descricaoDespesa
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 23.0,
                                            fontFamily: 'helvetica_neue_light'),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    /*
                                      container *data
                                    */
                                  
                                    Container(
                                      width: double.infinity,
                                      height: 20,
                                      color: Colors.white,
                                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Text(
                                        listaDespesas[i].dataDespesa.toString(),
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 16.0,
                                            fontFamily: 'helvetica_neue_light'),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              /*
                              container *valor despesas
                              */
                              Container(
                                width: MediaQuery.of(context).size.width * 0.23,
                                height: 78,
                                color: Colors.white,
                                alignment: Alignment.bottomRight,
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          _showAlertAlteraDespesa(
                                              this.listaDespesas[i].id,
                                              this
                                                  .listaDespesas[i]
                                                  .descricaoDespesa,
                                              this
                                                  .listaDespesas[i]
                                                  .valorDespesa,
                                              this
                                                  .listaDespesas[i]
                                                  .dataDespesa);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 28,
                                          color: Colors.white,
                                          padding:
                                              EdgeInsets.fromLTRB(0, 10, 0, 0),
                                          child: Text(
                                            "R\$:" +
                                                this
                                                    .listaDespesas[i]
                                                    .valorDespesa
                                                    .toStringAsFixed(2),
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 16,
                                                fontFamily:
                                                    'helvetica_neue_light'),
                                            textAlign: TextAlign.left,
                                          ),
                                        )),
                                    /*
                                    container * icon
                                    */
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.07,
                                height: 60,
                                color: Colors.white,
                                child: IconButton(
                                  alignment: Alignment.topRight,
                                  padding: const EdgeInsets.only(bottom: 2),
                                  icon: Icon(
                                    Icons.delete,
                                  ),
                                  color: Colors.red,
                                  iconSize: 20,
                                  splashColor: Colors.white,
                                  onPressed: () {
                                    _showAlertDeletaDespesa(
                                        this.listaDespesas[i].id,
                                        this.listaDespesas[i].descricaoDespesa,
                                        this.listaDespesas[i].valorDespesa,
                                        this.listaDespesas[i].dataDespesa);
                                  },
                                ),
                              )
                              /*
                              container *icon editar
                              */
                            ],
                          ))
                  ] else
                    ...[]
                ],
              ),
            ),
          ),
        ]),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        onTap: onTabTapped,
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(
              Icons.add,
              color: Colors.green,
            ),
            // ignore: deprecated_member_use
            title: new Text(
              "Novo Controle",
              style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'helvetica_neue_light',
                  fontSize: 16),
            ),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(
              Icons.attach_money,
              color: Colors.green,
            ),
            // ignore: deprecated_member_use
            title: new Text("Nova Despesa",
                style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'helvetica_neue_light',
                    fontSize: 18)),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(
              Icons.article_outlined,
              color: Colors.green,
            ),
            // ignore: deprecated_member_use
            title: new Text("Relatório",
                style: TextStyle(
                    color: Colors.black54,
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
        if (this.listaDespesas == null) {
          _showAlertCriaFinanca();
        } else {
          _showAlertCriaFinanca();
          _showAlertAntesCriaFinanca();
        }
      } else if (_indiceAtual == 1) {
        if (this.idFinanca == null) {
          _mensagem("Cadastre um novo controle");
        } else {
          _showAlertCriaDespesa();
        }
      } else if (_indiceAtual == 2) {
        if (this.listaDespesas == null) {
          _mensagem("Cadastre um novo controle");
        } else if (this.listaFinancas.toString().isEmpty) {
          _mensagem("Cadastre uma nova despesa.");
        } else if (this.valorFinanca == 0) {
          _mensagem("valor renda esta zerado.");
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Relatorio()));
        }
      }
    });
  }

  void _mensagem(String valor) {
    Fluttertoast.showToast(
        msg: valor,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 17.0);
  }

  void _showAlertCriaFinanca() {
    _setaValoresFinancaDataTemp();
    AlertDialog dialog = new AlertDialog(
      content: new Container(
        width: 260.0,
        height: 280.0,
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
                    child: Text("Controle",
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
              height: 30,
              color: Colors.white,
              child: new TextFormField(
                  maxLines: 1,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    filled: false,
                    contentPadding: new EdgeInsets.only(
                        left: 0.0, top: 10.0, bottom: 10.0, right: 10.0),
                    hintText: 'Valor finança.',
                    hintStyle: new TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 22.0,
                      fontFamily: 'helvetica_neue_light',
                    ),
                  ),
                  style: TextStyle(fontSize: 25.0),
                  controller: textControllerValorFinanca,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe algum valor';
                    }
                    return null;
                  }),
            ),
            Divider(
              height: 20,
              color: Colors.white,
            ),
            Container(
              width: double.infinity,
              height: 30,
              color: Colors.white,
              child: new TextFormField(
                  maxLines: 1,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    filled: false,
                    contentPadding: new EdgeInsets.only(
                        left: 0.0, top: 10.0, bottom: 10.0, right: 10.0),
                    hintText: 'Valor poupar.',
                    hintStyle: new TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 22.0,
                      fontFamily: 'helvetica_neue_light',
                    ),
                  ),
                  style: TextStyle(fontSize: 25.0),
                  controller: textControllerValorPoupar,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe algum valor';
                    }
                    return null;
                  }),
            ),
            Divider(
              height: 20,
              color: Colors.white,
            ),
            Container(
                width: double.infinity,
                height: 30,
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      width: 35,
                      height: 30,
                      color: Colors.white,
                      child: IconButton(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(top: 0),
                        icon: Icon(
                          Icons.date_range,
                        ),
                        color: Colors.green,
                        iconSize: 20,
                        onPressed: () async {
                          final DateTime picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2025));

                          if (picked != null)
                            setState(() {
                              String data = picked.day.toString() +
                                  "/" +
                                  picked.month.toString() +
                                  "/" +
                                  picked.year.toString();
                              this.dataFinanca = data;
                              _setaValoresFinancaData();
                            });
                        },
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 30,
                      color: Colors.white,
                      child: new TextFormField(
                          maxLines: 1,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            filled: false,
                            contentPadding: new EdgeInsets.only(
                                left: 0.0,
                                top: 10.0,
                                bottom: 10.0,
                                right: 10.0),
                            hintText: this.data,
                            hintStyle: new TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 22.0,
                              fontFamily: 'helvetica_neue_light',
                            ),
                          ),
                          style: TextStyle(fontSize: 25.0),
                          controller: textControllerDataFinanca,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe algum valor';
                            }
                            return null;
                          }),
                    )
                  ],
                )),
            Divider(
              height: 30,
              color: Colors.white,
            ),
            Container(
              width: double.infinity,
              height: 50,
              padding: new EdgeInsets.all(5.0),
              decoration: new BoxDecoration(
                  color: Colors.green[300],
                  borderRadius: new BorderRadius.all(new Radius.circular(5.0))),
              child: new FlatButton(
                onPressed: () {
                  _pegarRagistrosFinanca();
                  if (_verificaValorFinanca()) {
                    _persistenciaDadosDao(
                      "salvar",
                      "financa",
                      0,
                    );
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  'Adicionar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontFamily: 'helvetica_neue_light',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, child: dialog);
  }

  void _showAlertAlteraFinancaValor() {
    _setaValoresEditarFinanca();
    AlertDialog dialog = new AlertDialog(
      content: new Container(
        width: 260.0,
        height: 230.0,
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
                    child: Text("Editar controle",
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
                        _resetaValoresFinanca();
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
              height: 30,
              color: Colors.white,
              child: new TextFormField(
                  maxLines: 1,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    filled: false,
                    contentPadding: new EdgeInsets.only(
                        left: 0.0, top: 10.0, bottom: 10.0, right: 10.0),
                    hintText: 'Valor.',
                    hintStyle: new TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 22.0,
                      fontFamily: 'helvetica_neue_light',
                    ),
                  ),
                  style: TextStyle(fontSize: 25.0),
                  controller: textControllerValorFinanca,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe algum valor';
                    }
                    return null;
                  }),
            ),
            Divider(
              height: 20,
              color: Colors.white,
            ),
            Container(
                width: double.infinity,
                height: 30,
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      width: 35,
                      height: 30,
                      color: Colors.white,
                      child: IconButton(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(top: 0),
                        icon: Icon(
                          Icons.date_range,
                        ),
                        color: Colors.green,
                        iconSize: 20,
                        onPressed: () async {
                          final DateTime picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2025));

                          if (picked != null)
                            setState(() {
                              String data = picked.day.toString() +
                                  "/" +
                                  picked.month.toString() +
                                  "/" +
                                  picked.year.toString();
                              this.dataFinanca = data;
                              _setaValoresFinancaData();
                            });
                        },
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 30,
                      color: Colors.white,
                      child: new TextFormField(
                          maxLines: 1,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            filled: false,
                            contentPadding: new EdgeInsets.only(
                                left: 0.0,
                                top: 10.0,
                                bottom: 10.0,
                                right: 10.0),
                            hintText: this.data,
                            hintStyle: new TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 22.0,
                              fontFamily: 'helvetica_neue_light',
                            ),
                          ),
                          style: TextStyle(fontSize: 25.0),
                          controller: textControllerDataFinanca,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe algum valor';
                            }
                            return null;
                          }),
                    )
                  ],
                )),
            Divider(
              height: 30,
              color: Colors.white,
            ),
            Container(
              width: double.infinity,
              height: 50,
              padding: new EdgeInsets.all(5.0),
              decoration: new BoxDecoration(
                  color: Colors.green[300],
                  borderRadius: new BorderRadius.all(new Radius.circular(5.0))),
              child: new FlatButton(
                onPressed: () {
                  _pegarRagistrosFinanca();
                  _persistenciaDadosDao(
                    "alterarValor",
                    "financa",
                    0,
                  );
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Editar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontFamily: 'helvetica_neue_light',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, child: dialog);
  }

  void _showAlertAlteraFinancaPoupar() {
    _setaValoresEditarFinanca();
    AlertDialog dialog = new AlertDialog(
      content: new Container(
        width: 260.0,
        height: 230.0,
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
                    child: Text("Editar controle",
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
                        _resetaValoresFinanca();
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
              height: 30,
              color: Colors.white,
              child: new TextFormField(
                  maxLines: 1,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    filled: false,
                    contentPadding: new EdgeInsets.only(
                        left: 0.0, top: 10.0, bottom: 10.0, right: 10.0),
                    hintText: 'Poupar.',
                    hintStyle: new TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 22.0,
                      fontFamily: 'helvetica_neue_light',
                    ),
                  ),
                  style: TextStyle(fontSize: 25.0),
                  controller: textControllerValorPoupar,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe algum valor';
                    }
                    return null;
                  }),
            ),
            Divider(
              height: 20,
              color: Colors.white,
            ),
            Container(
                width: double.infinity,
                height: 30,
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      width: 35,
                      height: 30,
                      color: Colors.white,
                      child: IconButton(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(top: 0),
                        icon: Icon(
                          Icons.date_range,
                        ),
                        color: Colors.green,
                        iconSize: 20,
                        onPressed: () async {
                          final DateTime picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2025));

                          if (picked != null)
                            setState(() {
                              String data = picked.day.toString() +
                                  "/" +
                                  picked.month.toString() +
                                  "/" +
                                  picked.year.toString();
                              this.dataFinanca = data;
                              _setaValoresFinancaData();
                            });
                        },
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 30,
                      color: Colors.white,
                      child: new TextFormField(
                          maxLines: 1,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            filled: false,
                            contentPadding: new EdgeInsets.only(
                                left: 0.0,
                                top: 10.0,
                                bottom: 10.0,
                                right: 10.0),
                            hintText: this.data,
                            hintStyle: new TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 22.0,
                              fontFamily: 'helvetica_neue_light',
                            ),
                          ),
                          style: TextStyle(fontSize: 25.0),
                          controller: textControllerDataFinanca,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe algum valor';
                            }
                            return null;
                          }),
                    )
                  ],
                )),
            Divider(
              height: 30,
              color: Colors.white,
            ),
            Container(
              width: double.infinity,
              height: 50,
              padding: new EdgeInsets.all(5.0),
              decoration: new BoxDecoration(
                  color: Colors.green[300],
                  borderRadius: new BorderRadius.all(new Radius.circular(5.0))),
              child: new FlatButton(
                onPressed: () {
                  _pegarRagistrosFinanca();
                  _persistenciaDadosDao(
                    "alterarPoupar",
                    "financa",
                    0,
                  );
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Editar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontFamily: 'helvetica_neue_light',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, child: dialog);
  }

  void _showAlertCriaDespesa() {
    _setaValoresDespesaDataTemp();
    AlertDialog dialog = new AlertDialog(
      content: new Container(
        width: 260.0,
        height: 260.0,
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
                    child: Text("Despesa",
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
              height: 10,
              color: Colors.white,
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              child: new TextFormField(
                  maxLines: 1,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    filled: false,
                    contentPadding: new EdgeInsets.only(
                        left: 0.0, top: 10.0, bottom: 10.0, right: 10.0),
                    hintText: 'Descrição aqui.',
                    hintStyle: new TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 22.0,
                      fontFamily: 'helvetica_neue_light',
                    ),
                  ),
                  style: TextStyle(fontSize: 25.0),
                  controller: textControllerDescricaoDespesa,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe algum valor';
                    }
                    return null;
                  }),
            ),
            Divider(
              height: 20,
              color: Colors.white,
            ),
            Container(
                width: double.infinity,
                height: 30,
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      width: 35,
                      height: 30,
                      color: Colors.white,
                      child: IconButton(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(top: 0),
                        icon: Icon(
                          Icons.date_range,
                        ),
                        color: Colors.green,
                        iconSize: 20,
                        onPressed: () async {
                          final DateTime picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2025));

                          if (picked != null)
                            setState(() {
                              String data = picked.day.toString() +
                                  "/" +
                                  picked.month.toString() +
                                  "/" +
                                  picked.year.toString();

                              this.dataDespesa = data;
                              _setaValoresDespesaData();
                            });
                        },
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 30,
                      color: Colors.white,
                      child: new TextFormField(
                          maxLines: 1,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            filled: false,
                            contentPadding: new EdgeInsets.only(
                                left: 0.0,
                                top: 10.0,
                                bottom: 10.0,
                                right: 10.0),
                            hintText: this.data,
                            hintStyle: new TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 22.0,
                              fontFamily: 'helvetica_neue_light',
                            ),
                          ),
                          style: TextStyle(fontSize: 25.0),
                          controller: textControllerDataDespesa,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe algum valor';
                            }
                            return null;
                          }),
                    )
                  ],
                )),
            Divider(
              height: 10,
              color: Colors.white,
            ),
            Container(
              width: double.infinity,
              height: 30,
              color: Colors.white,
              child: new TextFormField(
                  maxLines: 1,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    filled: false,
                    contentPadding: new EdgeInsets.only(
                        left: 0.0, top: 10.0, bottom: 10.0, right: 10.0),
                    hintText: 'Valor despesa.',
                    hintStyle: new TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 22.0,
                      fontFamily: 'helvetica_neue_light',
                    ),
                  ),
                  style: TextStyle(fontSize: 25.0),
                  controller: textControllerValorDespesa,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe algum valor';
                    }
                    return null;
                  }),
            ),
            Divider(
              height: 30,
              color: Colors.white,
            ),
            Container(
              width: double.infinity,
              height: 50,
              padding: new EdgeInsets.all(5.0),
              decoration: new BoxDecoration(
                  color: Colors.green[300],
                  borderRadius: new BorderRadius.all(new Radius.circular(5.0))),
              child: new FlatButton(
                onPressed: () {
                  _pegarRagistrosDespesa();

                  if (_verificaValor()) {
                    _persistenciaDadosDao("salvar", "despesa", 0);
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  'Adicionar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontFamily: 'helvetica_neue_light',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, child: dialog);
  }

  void _showAlertAlteraDespesa(
      int id, String descricao, double valor, String dataTemp) {
    _setaValoresEditarDespesas(descricao, valor, dataTemp);
    AlertDialog dialog = new AlertDialog(
      content: new Container(
        width: 260.0,
        height: 260.0,
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
                    child: Text("Editar despesas",
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
                        _resetaValoresDespesa();
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: 10,
              color: Colors.white,
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              child: new TextFormField(
                  maxLines: 1,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    filled: false,
                    contentPadding: new EdgeInsets.only(
                        left: 0.0, top: 10.0, bottom: 10.0, right: 10.0),
                    hintText: 'Descrição aqui.',
                    hintStyle: new TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 22.0,
                      fontFamily: 'helvetica_neue_light',
                    ),
                  ),
                  style: TextStyle(fontSize: 25.0),
                  controller: textControllerDescricaoDespesa,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe algum valor';
                    }
                    return null;
                  }),
            ),
            Divider(
              height: 20,
              color: Colors.white,
            ),
            Container(
                width: double.infinity,
                height: 30,
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      width: 35,
                      height: 30,
                      color: Colors.white,
                      child: IconButton(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(top: 0),
                        icon: Icon(
                          Icons.date_range,
                        ),
                        color: Colors.green,
                        iconSize: 20,
                        onPressed: () async {
                          final DateTime picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2025));

                          if (picked != null)
                            setState(() {
                              String data = picked.day.toString() +
                                  "/" +
                                  picked.month.toString() +
                                  "/" +
                                  picked.year.toString();

                              this.dataDespesa = data;
                              _setaValoresDespesaData();
                            });
                        },
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 30,
                      color: Colors.white,
                      child: new TextFormField(
                          maxLines: 1,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            filled: false,
                            contentPadding: new EdgeInsets.only(
                                left: 0.0,
                                top: 10.0,
                                bottom: 10.0,
                                right: 10.0),
                            hintStyle: new TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 22.0,
                              fontFamily: 'helvetica_neue_light',
                            ),
                          ),
                          style: TextStyle(fontSize: 25.0),
                          controller: textControllerDataDespesa,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe algum valor';
                            }
                            return null;
                          }),
                    )
                  ],
                )),
            Divider(
              height: 10,
              color: Colors.white,
            ),
            Container(
              width: double.infinity,
              height: 30,
              color: Colors.white,
              child: new TextFormField(
                  maxLines: 1,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    filled: false,
                    contentPadding: new EdgeInsets.only(
                        left: 0.0, top: 10.0, bottom: 10.0, right: 10.0),
                    hintText: 'Valor.',
                    hintStyle: new TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 22.0,
                      fontFamily: 'helvetica_neue_light',
                    ),
                  ),
                  style: TextStyle(fontSize: 25.0),
                  controller: textControllerValorDespesa,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe algum valor';
                    }
                    return null;
                  }),
            ),
            Divider(
              height: 30,
              color: Colors.white,
            ),
            Container(
              width: double.infinity,
              height: 50,
              padding: new EdgeInsets.all(5.0),
              decoration: new BoxDecoration(
                  color: Colors.green[300],
                  borderRadius: new BorderRadius.all(new Radius.circular(5.0))),
              child: new FlatButton(
                onPressed: () {
                  _pegarRagistrosDespesa();
                  _persistenciaDadosDao(
                    "altera",
                    "despesa",
                    id,
                  );

                  Navigator.of(context).pop();
                },
                child: Text(
                  'Editar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontFamily: 'helvetica_neue_light',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, child: dialog);
  }

  void _showAlertDeletaDespesa(
      int id, String descricao, double valor, String dataTemp) {
    AlertDialog dialog = new AlertDialog(
      content: new Container(
        width: 260.0,
        height: 260.0,
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
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    color: Colors.white,
                    child: Text("Excluir despesa",
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
              height: 10,
              color: Colors.white,
            ),
            Container(
                width: double.infinity,
                height: 140,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 60,
                      color: Colors.white,
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: ListTile(
                        title: Text("Tem certeza que deseja excluir?",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 21,
                                fontFamily: 'helvetica_neue_light')),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 80,
                      color: Colors.white,
                      child: ListTile(
                        title: Text(
                            "Despesa: " +
                                descricao +
                                "\ncriado: " +
                                dataTemp +
                                "\nR\$:" +
                                valor.toStringAsFixed(2),
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20.0,
                                fontFamily: 'helvetica_neue_light')),
                      ),
                    ),
                  ],
                )),
            Divider(
              height: 30,
              color: Colors.white,
            ),
            Container(
              width: double.infinity,
              height: 50,
              padding: new EdgeInsets.all(5.0),
              decoration: new BoxDecoration(
                  color: Colors.green[300],
                  borderRadius: new BorderRadius.all(new Radius.circular(5.0))),
              child: new FlatButton(
                onPressed: () {
                  _persistenciaDadosDao("deleta", "despesa", id);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Excluir',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontFamily: 'helvetica_neue_light',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, child: dialog);
  }

  void _showAlertAntesCriaFinanca() {
    AlertDialog dialog = new AlertDialog(
      content: new Container(
        width: 260.0,
        height: 220.0,
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    height: 30,
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    color: Colors.white,
                    child: Text("Notificação!",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 26.0,
                            fontFamily: 'helvetica_neue_light')),
                  ),
                ],
              ),
            ),
            Divider(
              height: 10,
              color: Colors.white,
            ),
            Container(
                width: double.infinity,
                height: 110,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 105,
                      color: Colors.white,
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: ListTile(
                        title: Text(
                            "Ao cria um novo controle as despesa sera vinculada ao novo controle.",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 21,
                                fontFamily: 'helvetica_neue_light')),
                      ),
                    ),
                  ],
                )),
            Divider(
              height: 10,
              color: Colors.white,
            ),
            Container(
              width: double.infinity,
              height: 50,
              padding: new EdgeInsets.all(5.0),
              decoration: new BoxDecoration(
                  color: Colors.green[300],
                  borderRadius: new BorderRadius.all(new Radius.circular(5.0))),
              child: new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Ok, entendi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontFamily: 'helvetica_neue_light',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, child: dialog);
  }

  _pegarRagistrosFinanca() {
    setState(() {
      textControllerValorFinanca.text.isNotEmpty
          ? this.valorFinanca = double.parse(textControllerValorFinanca.text)
          : this.valorFinanca = 0;

      textControllerValorPoupar.text.isNotEmpty
          ? this.valorPoupar = double.parse(textControllerValorPoupar.text)
          : this.valorPoupar = 0;

      this.dataFinanca.isNotEmpty
          ? this.dataFinanca = this.dataFinanca
          : this.dataFinanca = this.data;
    });

    _lendoFinancas();
  }

  bool _verificaValorFinanca() {
    if (textControllerValorFinanca.text.isEmpty) {
      _mensagem("Campo valor finança é obrigatorio");
      return false;
    }

    return true;
  }

  _pegarRagistrosDespesa() {
    setState(() {
      this.descricaoDespesa = textControllerDescricaoDespesa.text;

      textControllerValorDespesa.text.isNotEmpty
          ? this.valorDespesa = double.parse(textControllerValorDespesa.text)
          : this.valorDespesa = 0;

      this.dataDespesa.isNotEmpty
          ? this.dataDespesa = this.dataDespesa
          : this.dataDespesa = this.data;
    });

    _lendoDespensas();
  }

  bool _verificaValor() {
    if (textControllerDescricaoDespesa.text.isEmpty) {
      _mensagem("Campo descrição obrigatorio");
      return false;
    }

    if (textControllerValorDespesa.text.isEmpty) {
      _mensagem("Campo valor obrigatorio");
      return false;
    }
    return true;
  }

  _persistenciaDadosDao(String chave, base, int id) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    if (chave == "salvar" && base == "despesa") {
      _salvarDespesas(database);
    }
    if (chave == "altera" && base == "despesa") {
      _alterandoDespesas(database, id);
    }
    if (chave == "deleta" && base == "despesa") {
      _removendoDespesa(database, id);
    }
    if (chave == "salvar" && base == "financa") {
      //_alteraFinancaDataFinal(database);
      _salvarFinancas(database);
    }
    if (chave == "alterarValor" && base == "financa") {
      _alteraFinancaRenda(database);
    }
    if (chave == "alterarPoupar" && base == "financa") {
      _alteraFinancaValorPoupar(database);
    }

    _resetaValoresFinanca();
    _resetaValoresDespesa();
    _lendoDespensas();
    _lendoFinancas();
  }

  _salvarDespesas(AppDatabase database) async {
    final despesaDao = database.despesaDao;
    Despesa despesa = new Despesa(null, this.descricaoDespesa,
        this.valorDespesa, this.dataDespesa, this.idFinanca);
    await despesaDao.insertDespesa(despesa);
  }

  _salvarFinancas(AppDatabase database) async {
    final financaDao = database.financaDao;
    Financa financa = new Financa(null, this.valorFinanca, this.dataFinanca,
        this.data, this.valorPoupar);
    await financaDao.insertFinanca(financa);
  }

  _alterandoDespesas(AppDatabase database, int id) async {
    final despesaDao = database.despesaDao;
    Despesa despesa = new Despesa(id, this.descricaoDespesa, this.valorDespesa,
        this.dataDespesa, this.idFinanca);
    await despesaDao.upDateDespesa(despesa);
    _resetaValoresDespesa();
  }

  _alteraFinancaRenda(AppDatabase database) async {
    final financaDao = database.financaDao;
    await financaDao.updateFinanca(this.valorFinanca, this.idFinanca);
    _resetaValoresFinanca();
  }

  _alteraFinancaValorPoupar(AppDatabase database) async {
    final financaDao = database.financaDao;
    await financaDao.updateValorPoupar(this.valorPoupar, this.idFinanca);
    _resetaValoresFinanca();
  }

  _removendoDespesa(AppDatabase database, int id) async {
    final despesaDao = database.despesaDao;
    await despesaDao.delete(id);
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
      }
    }

    //_comparaMes();

    setState(() {
      if (tempValorRenda != null) this.valorFinanca = tempValorRenda;
      if (tempValorPoupar != null) this.valorPoupar = tempValorPoupar;
      if (tempDatainicial != null) this.dataInicial = tempDatainicial;
      if (this.tempMes != null) this.mostraMes = this.tempMes;
      if (tempMes != null) this.idFinanca = tempId;
    });
    _lendoDespensas();
  }

  _lendoDespensas() async {
    double temporariaSoma = 0;
    int idTemp = this.idFinanca;
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final despesaDao = database.despesaDao;
    if (this.idFinanca != null) {
      this.listaDespesas = await despesaDao.findAllDespesaId(idTemp);
    }

    if (this.listaDespesas != null) {
      for (int i = 0; i < this.listaDespesas.length; i++) {
        temporariaSoma += this.listaDespesas[i].valorDespesa;
      }
    }

    this.valorDespesa = temporariaSoma;

    setState(() {
      this.valorRendaTotal =
          this.valorFinanca - this.valorPoupar - this.valorDespesa;
    });
  }

  _setaValoresFinancaData() {
    setState(() {
      textControllerDataFinanca.text = this.dataFinanca;
    });
  }

  _setaValoresFinancaDataTemp() {
    setState(() {
      textControllerDataFinanca.text = this.data;
    });
  }

  _setaValoresDespesaData() {
    setState(() {
      textControllerDataDespesa.text = this.dataDespesa;
    });
  }

  _setaValoresDespesaDataTemp() {
    setState(() {
      textControllerDataDespesa.text = this.data;
    });
  }

  _resetaValoresFinanca() {
    setState(() {
      textControllerDataFinanca.text = "";
      textControllerValorFinanca.text = "";
      textControllerValorPoupar.text = "";
    });
  }

  _resetaValoresDespesa() {
    setState(() {
      textControllerDescricaoDespesa.text = "";
      textControllerDataDespesa.text = "";
      textControllerValorDespesa.text = "";
    });
  }

  _setaValoresEditarDespesas(String descricao, double valor, String dataTemp) {
    setState(() {
      textControllerDescricaoDespesa.text = descricao;
      textControllerValorDespesa.text = valor.toStringAsFixed(2);
      textControllerDataDespesa.text = dataTemp;
      this.dataDespesa = dataTemp;
    });
  }

  _setaValoresEditarFinanca() {
    setState(() {
      textControllerValorFinanca.text = this.valorFinanca.toStringAsFixed(2);
      textControllerValorPoupar.text = this.valorPoupar.toStringAsFixed(2);
      textControllerDataFinanca.text = this.dataInicial;
      this.dataFinanca = this.dataInicial;
    });
  }
}
