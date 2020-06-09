

import 'dart:convert';

import 'package:paymentcheckout/payments/payment_card.dart';
import 'package:http/http.dart' as http;

class CheckoutPayment{
  static const _tokenUrl = 'https://api.sandbox.checkout.com/tokens';
  static const _paymentUrl = 'https://api.sandbox.checkout.com/payments';



  static const String _publicKey = '';
  static const String _secretKey = '';

  static const Map<String,String> _tokenHeader = {
    'Content-Type' : 'Application/json' ,
    'Authorization': _publicKey ,
  };

  static const Map<String,String> _paymentHeader = {
    'Content-Type' : 'Application/json' ,
    'Authorization': _secretKey ,
  };



   Future<String> _getToken(PaymentCard card)async {
     Map<String,String> body = {
       'type' : 'card' ,
       'number' :card.number  ,
       'expiry_month':card.expiry_month ,
       'expiry_year':card.expiry_year ,

     };
     http.Response response = await http.post(_tokenUrl,headers: _tokenHeader,body: jsonEncode(body),);
      switch(response.statusCode){
        case 201 :
          var data = jsonDecode(response.body);
          return data['token'] ;
          break ;
        default :
          throw Exception('Card Invalid');
          break ; 

      }
  }

  Future<bool> makePayment(PaymentCard card, int amount)async {

    String token = await _getToken(card);

    Map<String,dynamic> body = {
      'source':{
        'type' :'token', 
        'token' : token ,
      },
      'amount' :amount ,
      'currency':'usd',
    };
   http.Response response = await http.post(_paymentUrl,headers: _paymentHeader,body: jsonEncode(body)); 
  switch(response.statusCode){
    case 201 :
      var data = jsonDecode(response.body) ;
      print(data['response_summary']);
      return true ;

      break ;
    default :
      throw Exception('payment failed');
      break ; 
  }

   }




}