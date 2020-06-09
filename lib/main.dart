import 'package:flutter/material.dart';
import 'package:paymentcheckout/payments/checkout.dart';
import 'package:paymentcheckout/payments/payment_card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {






  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.teal,
        title: Text('Payments')
      ),
      body: Text('payments'),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          PaymentCard card = PaymentCard(
            "42424242",
            '12',
            '2019',
          );

          CheckoutPayment payment = CheckoutPayment();
          payment.makePayment(card, 1550);



        },
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
