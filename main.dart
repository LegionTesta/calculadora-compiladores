import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:string_validator/string_validator.dart';

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

  List<dynamic> numReais;
  List<dynamic> numInts;
  List<dynamic> opSoma;
  List<dynamic> opMult;
  List<dynamic> opSub;
  List<dynamic> opDivis;
  List<dynamic> abreParen;
  List<dynamic> fechaParen;
  List<dynamic> erros;
  
  void tokeniza(String entrada){

    TipoToken ultimoToken = TipoToken.ESPACO;
    String stringAtual = "";

    for(int x = 0; x < entrada.length; x++){

      var charCode = entrada.codeUnitAt(x);
      switch (charCode){

        case 32:
          print(charCode);
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
          ultimoToken == TipoToken.ESPACO;
        break;

        case 40:
          print(charCode);
          if(ultimoToken != TipoToken.ESPACO){
            stringAtual += entrada[x];
            ultimoToken = TipoToken.ERRO;
          } else{
            stringAtual = "(";
            ultimoToken = TipoToken.APAR;
          }
        break;

        case 41:
          print(charCode);
          if(ultimoToken != TipoToken.ESPACO){
            stringAtual += entrada[x];
            ultimoToken = TipoToken.ERRO;
          } else{
            stringAtual = ")";
            ultimoToken = TipoToken.FPAR;
          }
        break;

        case 42:
          print(charCode);
          if(ultimoToken != TipoToken.ESPACO){
            stringAtual += entrada[x];
            ultimoToken = TipoToken.ERRO;
          } else{
            stringAtual = "*";
            ultimoToken = TipoToken.MULTIPLICACAO;
          }
        break;

        case 43:
          print(charCode);
          if(ultimoToken != TipoToken.ESPACO){
            stringAtual += entrada[x];
            ultimoToken = TipoToken.ERRO;
          } else{
            print("aa");
            stringAtual = "+";
            ultimoToken = TipoToken.ADICAO;
          }             
        break;

        case 45:
          print(charCode);
          if(ultimoToken != TipoToken.ESPACO){
            stringAtual += entrada[x];
            ultimoToken = TipoToken.ERRO;
          } else {
            stringAtual = "-";
            ultimoToken = TipoToken.SUBTRACAO;
          }            
        break;

        case 47:
          print(charCode);
          if(ultimoToken != TipoToken.ESPACO){
            stringAtual += entrada[x];
            ultimoToken = TipoToken.ERRO;
          } else {
            stringAtual = "/";
            ultimoToken = TipoToken.DIVISAO;
          }
        break;

        default:
          print(charCode);
          if((charCode > 47 && charCode < 58) || charCode == 46){
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
      print("Operadores de multiplicacao: ");
      opSub.forEach((element) {print("$element ");});
    }
    if(opDivis.length != 0 ){
      print("Operadores de multiplicacao: ");
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
      print("Erros: ");
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
