  void main(){
    print("a");
  }

class TabelaDeTokens{
  
  TabelaDeTokens(){
    numReais = List();
    numInts = List();
    opSoma = List();
    opMult = List();
    abreParen = List();
    fechaParen = List();
  }

  List<dynamic> numReais;
  List<dynamic> numInts;
  List<dynamic> opSoma;
  List<dynamic> opMult;
  List<dynamic> abreParen;
  List<dynamic> fechaParen;


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
    if(abreParen.length != 0 ){
      print("Parenteses abrindo: ");
      abreParen.forEach((element) {print("$element ");});
    }
    if(fechaParen.length != 0 ){
      print("Parenteses fechando: ");
      fechaParen.forEach((element) {print("$element ");});
    }
  }
}
