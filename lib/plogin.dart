import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:loguinsintese_app/plogin.dart';
import 'Phome.dart';

class plogin extends StatefulWidget {
  @override
  _ploginState createState() => _ploginState();
}

class _ploginState extends State<plogin> {
  final _ControlerCpf = TextEditingController();
  final _ControlerSenha = TextEditingController();
  _conexaologin() async {
    String CpfDigitado = _ControlerCpf.text;
    String SenhaDigitada = _ControlerSenha.text;
    String UrlLogin =
        "http://177.159.234.147:8090/sintese/WebLoginUser.rule?sys=SIF&pLogin=${CpfDigitado};${SenhaDigitada}";
    http.Response response;
    response = await http.get(UrlLogin);
    Map<String, dynamic> retorno = json.decode(response.body);
    //variaveis recebendo resultado da api login sintese
    String Resposta = retorno["Resposta"];
    //Controler recebendo dados da api login sintese
    _ControlerSenha.text = Resposta;
    _ControlerCpf.text = Resposta;

    if ((_ControlerCpf.text == "Error") || (_ControlerCpf.text == "Error")) {
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      AlertDialog alerta = AlertDialog(
        title: Text("Alerta!"),
        content: Text("Usuário Invalido!"),
        actions: [okButton],
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alerta;
          });
      _ControlerCpf.text = "";
      _ControlerSenha.text = "";
    } else {
      Widget NaoButton = FlatButton(
        child: Text("Não"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      Widget simButton = FlatButton(
        child: Text("Sim"),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => phome(
                        CpfDigitado,
                      )));
        },
      );
      AlertDialog alerta = AlertDialog(
        title: Text("Alerta"),
        content: Text("Vc é: ${_ControlerCpf.text}"),
        actions: [
          simButton,
          NaoButton,
        ],
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alerta;
          });
      _ControlerCpf.text = "";
      _ControlerSenha.text = "";
    }
    //setState(() {
    //_ControlerSenha;
    //_ControlerCpf;
    //});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    "imagens/REDESINTESE.jpg",
                    width: 200,
                    height: 200,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    maxLength: 11,
                    controller: _ControlerCpf,
                    autofocus: true,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Digite apenas os números do cpf",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                TextField(
                  controller: _ControlerSenha,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Digite sua senha",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32))),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 20),
                  child: RaisedButton(
                      child: Text(
                        "Entrar",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.red,
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      onPressed: () {
                        if ((_ControlerCpf.text == "") ||
                            (_ControlerSenha.text == "")) {
                          //configurando button
                          Widget okButton = FlatButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          );
                          AlertDialog alerta = AlertDialog(
                            title: Text("Alerta!"),
                            content: Text("Campos não podem está vazio"),
                            actions: [okButton],
                          );
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alerta;
                              });
                        } else {
                          _conexaologin();
                        }
                      }),
                ),
                Center(
                  child: GestureDetector(
                    child: Text(
                      "Click aqui para ir ao nosso website!",
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
