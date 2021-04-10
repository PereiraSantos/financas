import 'package:financas/compara_mes/compara_mes.dart';
import 'package:flutter/material.dart';

class CabecalhoApp extends StatelessWidget {
  final mostraMes;
  final dataInicial;
  final data;

  CabecalhoApp(
      {Key key,
      @required this.mostraMes,
      @required this.dataInicial,
      this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ContainerMes(mostraMes: this.mostraMes),
          if (this.dataInicial != "") ...[
            ContainerDataInicial(
              dataInicial: this.dataInicial,
              data: this.data,
            )
          ] else
            ...[]
        ],
      ),
    );
  }
}

class ContainerMes extends StatelessWidget {
  final mostraMes;
  ContainerMes({Key key, this.mostraMes});

  @override
  Widget build(BuildContext context) {
    ComparaMes compara = ComparaMes();
    final String mes = compara.comparaMes(this.mostraMes);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 25,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(10, 5, 1, 1),
      child: Text(mes,
          style: TextStyle(
              fontSize: 17,
              fontFamily: 'helvetica_neue_light',
              color: Colors.black54)),
      
    );
  }
}

class ContainerDataInicial extends StatelessWidget {
  final dataInicial;
  final data;

  ContainerDataInicial({Key key, @required this.dataInicial, this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 20,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(10, 0, 1, 1),
      child: Text(this.dataInicial + " a " + this.data,
          style: TextStyle(
              fontSize: 17,
              fontFamily: 'helvetica_neue_light',
              color: Colors.black54)),
      
    );
  }
}
