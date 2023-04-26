import 'package:http/http.dart' as http;
import 'dart:convert';


class ExchangeRate{

  ExchangeRate({required this.fiat});
  


  String fiat;
  List<String> cryptos = ['BTC','LTC','ETH'];


  String apiKey = 'F527F2F8-43DB-44EB-A1F7-31328067E53C';

  String url = 'rest.coinapi.io';

  String endPoint = '/v1/exchangerate';


  Future<List<Map>> getExchangeRates() async{

    List<Map> exchangeRates = [];

    try {

      for (String crypto in cryptos){
        final reqData = Uri.https(url,'$endPoint/$crypto/$fiat');

        final response = await http.get(reqData,headers: {'X-CoinAPI-Key':apiKey});

        if(response.statusCode == 200){
          exchangeRates.add(jsonDecode(response.body));
        }

        print(response.statusCode);

      }

      return exchangeRates;
       
      
    } catch (e) {
      throw 'Failed to fetch exchange rates from coinapi';
    }
  
  }
}