import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:string_validator/string_validator.dart';

/*
Codigo para analise lexica de entradas para calculadora.
Necessario espaco apos cada elemento (numeros contam como um elemento unico).
Necessario existir espaco apos ultimo elemento da entrada.
Necessario existir um arquivo nomeado "entrada.txt" no mesmo diretorio que este codigo.
O programa irá ler somente a primeira linha da entrada
*/

void main() async {

  List<String> entrada = await getEntrada();
  if(entrada == null){
    print("Erro na leitura do arquivo!");
    return;
  }
  TabelaDeTokens tabelaDeTokens = TabelaDeTokens();  
  tabelaDeTokens.tokeniza(entrada[0]);
  tabelaDeTokens.mostraValores();
  
}

class TabelaDeTokens{
  
  TabelaDeTokens(){
    numReais = List();
    numInts = List();
    opSoma = List();
    opMult = List();
    opSub = List();
    opDivis = List();
    abreParen = List();
    fechaParen = List();
    erros = List();
  }

  List<String> numReais;
  List<String> numInts;
  List<String> opSoma;
  List<String> opMult;
  List<String> opSub;
  List<String> opDivis;
  List<String> abreParen;
  List<String> fechaParen;
  List<String> erros;
  
  void tokeniza(String entrada){

    print("Tokenizando a entrada: $entrada");

    TipoToken ultimoToken = TipoToken.ESPACO;
    String stringAtual = "";

    for(int x = 0; x < entrada.length; x++){

      switch (entrada[x]){

        case " ":
          if(ultimoToken == TipoToken.NUMERO){
            if(isInt(stringAtual))
              numInts.add(stringAtual);
            else if(isFloat(stringAtual))
              numReais.add(stringAtual);
            else 
              erros.add(stringAtual);
          }

          if(ultimoToken == TipoToken.ADICAO)
            opSoma.add(stringAtual);
          
          if(ultimoToken == TipoToken.SUBTRACAO)
            opSub.add(stringAtual);
          
          if(ultimoToken == TipoToken.DIVISAO)
            opDivis.add(stringAtual);
          
          if(ultimoToken == TipoToken.MULTIPLICACAO)
            opMult.add(stringAtual);
          
          if(ultimoToken == TipoToken.APAR)
            abreParen.add(stringAtual);
          
          if(ultimoToken == TipoToken.FPAR)
            fechaParen.add(stringAtual);
          
          if(ultimoToken == TipoToken.ERRO)
            erros.add(stringAtual);
          
          stringAtual = "";
          ultimoToken = TipoToken.ESPACO;
        break;

        case "(":
          if(ultimoToken != TipoToken.ESPACO){
            stringAtual += entrada[x];
            ultimoToken = TipoToken.ERRO;
          } else{
            stringAtual = "(";
            ultimoToken = TipoToken.APAR;
          }
        break;

        case ")":
          if(ultimoToken != TipoToken.ESPACO){
            stringAtual += entrada[x];
            ultimoToken = TipoToken.ERRO;
          } else{
            stringAtual = ")";
            ultimoToken = TipoToken.FPAR;
          }
        break;

        case "*":
          if(ultimoToken != TipoToken.ESPACO){
            stringAtual += entrada[x];
            ultimoToken = TipoToken.ERRO;
          } else{
            stringAtual = "*";
            ultimoToken = TipoToken.MULTIPLICACAO;
          }
        break;

        case "+":
          if(ultimoToken != TipoToken.ESPACO){
            stringAtual += entrada[x];
            ultimoToken = TipoToken.ERRO;
          } else{
            stringAtual = "+";
            ultimoToken = TipoToken.ADICAO;
          }             
        break;

        case "-":
          if(ultimoToken != TipoToken.ESPACO){
            stringAtual += entrada[x];
            ultimoToken = TipoToken.ERRO;
          } else {
            stringAtual = "-";
            ultimoToken = TipoToken.SUBTRACAO;
          }            
        break;

        case "/":
          if(ultimoToken != TipoToken.ESPACO){
            stringAtual += entrada[x];
            ultimoToken = TipoToken.ERRO;
          } else {
            stringAtual = "/";
            ultimoToken = TipoToken.DIVISAO;
          }
        break;

        default:
          if((entrada.codeUnitAt(x) > 47 && entrada.codeUnitAt(x) < 58) || entrada[x] == "."){
            stringAtual += entrada[x];
            ultimoToken = TipoToken.NUMERO;
          } else {
            stringAtual += entrada[x];
            ultimoToken = TipoToken.ERRO;
          }
        break;
      }
    }
  }

  void mostraValores(){
    if(numReais.length != 0 ){
      print("Numeros reais: ");
      numReais.forEach((element) {print("$element ");});
    }
    if(numInts.length != 0 ){
      print("Numeros inteiros: ");
      numInts.forEach((element) {print("$element ");});
    }
    if(opSoma.length != 0 ){
      print("Operadores de soma: ");
      opSoma.forEach((element) {print("$element ");});
    }
    if(opMult.length != 0 ){
      print("Operadores de multiplicacao: ");
      opMult.forEach((element) {print("$element ");});
    }
    if(opSub.length != 0 ){
      print("Operadores de subtracao: ");
      opSub.forEach((element) {print("$element ");});
    }
    if(opDivis.length != 0 ){
      print("Operadores de divisao: ");
      opDivis.forEach((element) {print("$element ");});
    }
    if(abreParen.length != 0 ){
      print("Parenteses abrindo: ");
      abreParen.forEach((element) {print("$element ");});
    }
    if(fechaParen.length != 0 ){
      print("Parenteses fechando: ");
      fechaParen.forEach((element) {print("$element ");});
    }
    if(erros.length != 0 ){
      print("Erros lexicos: ");
      erros.forEach((element) {print("$element ");});
    }
  }
}

enum TipoToken{
  ADICAO, SUBTRACAO, DIVISAO, MULTIPLICACAO, APAR, FPAR, ESPACO, ERRO, NUMERO
}

Future<List<String>> getEntrada() async{

  final file = File('entrada.txt');
  Stream<List<int>> inputStream = file.openRead();

  return (await inputStream
  .transform(utf8.decoder)
  .toList());
}
