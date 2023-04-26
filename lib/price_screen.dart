import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;


import 'package:bitcoin_ticker/coin_data.dart';

import 'package:bitcoin_ticker/exchange_rate.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
 
  
  static String selectedCurrency = 'USD';

  Map<String,int> cryptoExchangeRates = {};


  ExchangeRate exchangeRate = ExchangeRate(fiat: selectedCurrency);


  


  Widget getPicker(){

    if(Platform.isAndroid){ 
           return DropdownButton<String>(
              value: selectedCurrency,
              icon: const Icon(Icons.arrow_circle_down_outlined),
              elevation: 16,
              onChanged: (String? value) async{
                setState(() {
                  selectedCurrency = value.toString();
                });

                exchangeRate.fiat = selectedCurrency;

                List<Map> exchangeRateData = await exchangeRate.getExchangeRates();

                
                for (Map data in exchangeRateData){
                    setState(() {
                          cryptoExchangeRates[data['asset_id_base']] = data['rate'].toInt();
                    });
                }

                
                

                
              },
              items: currenciesList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
            );
    }else if(Platform.isIOS){
      return CupertinoPicker(
                    magnification: 1.22,
                    squeeze: 1.2,
                    useMagnifier: true,
                    itemExtent: 32.0,
                    // This is called when selected item is changed.
                    onSelectedItemChanged: (int selectedIndex) async{
                      setState(() {
                        selectedCurrency = currenciesList[selectedIndex];
                      });


                      exchangeRate.fiat = selectedCurrency;

                      List<Map> exchangeRateData = await exchangeRate.getExchangeRates();

                      
                      for (Map data in exchangeRateData){

                        setState(() {
                          cryptoExchangeRates[data['asset_id_base']] = data['rate'].toInt();
                        });
                        
                      }

                      


                      
                    },
                    children:List<Widget>.generate(currenciesList.length, (int index) {
                      return Center(
                        child: Text(currenciesList[index]),
                      );
                    }),
                  );
    }
    return Text('uncaught platform');
  }

 

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:<Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              children: [
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = ${cryptoExchangeRates.isEmpty == false ? cryptoExchangeRates['BTC'] : '?'  } $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = ${cryptoExchangeRates.isEmpty == false ? cryptoExchangeRates['LTC'] : '?'  } $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = ${cryptoExchangeRates.isEmpty == false ? cryptoExchangeRates['ETH'] : '?'  } $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }
}

