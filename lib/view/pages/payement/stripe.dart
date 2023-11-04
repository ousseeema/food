import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:get/get_connect/connect.dart';
import 'package:stripe_checkout/stripe_checkout.dart';

class Stripe extends GetConnect {
  //apikey one private and one publish
  static String privatekey =
      "sk_test_51O4PlUB1oYs4MxbD45QacOD91nuJEMJkVM7hpRh5JlY2HSI3AwYXf8e0D6WijnCk3FywsBaMMac9B15fTJukOAhG00Sd3xKZY7";
  static String publishbalkey =
      "pk_test_51O4PlUB1oYs4MxbD0WDJgRHTDZyuTqwMrhvH7HunbAn2KS2XIRZbn0B5bj1IU1bP8QhOcIZzsffevcjIpk7uEeRq00ylmk5EtH";


// this function will send data to the endpoint and recive an response to confirme or to deinded
  static Future<dynamic> CreateCheckoutSession(
      List<dynamic> itemsList, AmountTotal) async {
        // api endpoint
    final url = Uri.parse("https://api.stripe.com/v1/checkout/sessions");
    String lineitems = "";
    int index = 0;
        // besh naaml parcours ll list mtaa items eli besh naamlelhom payment
        // w nhothom fi variable fi from message besh nbaatha fi requette post 
    itemsList.forEach((val) {
      var product_price = (val["product_price"] * 100).round().toString();
      lineitems +=
          "&line_items[$index][price_data][product_data][name]=${val['product_name']}";
      lineitems += "&line_items[$index][price_data][unit_amount]=$product_price";
      lineitems += "&line_items[$index][price_data][currency]=EUR";
      lineitems += "&line_items[$index][quantity]=${val['qty'].toString()}";
      index++;
    });

   http.Response response = await  http.post(url,
        body:
            "success_url=https://checkout.stripe.dev/success&mode=payment$lineitems",
        headers: {
          'Authorization': 'bearer $privatekey',
          'Content-Type': 'application/x-www-form-urlencoded'
        });
     print(response.body);
     

     // baaed ma yetaada payment mrygl  besh nrajaa eli idi mtaa transaction 
    return  json.decode(response.body)["id"];
    
  }



   // si function eli lfoug aamletli session nkml nkharej ui mtaa payment sinon taamli erreur 
   // nb : yazem tkoun session s7i7a besh naajm naaml payment w yokhrejli UI
  static Future<dynamic> StripePaymentCheckout(
      productitems, subtotal, context, mounted,
      // optionaal parametre
      {onSuccess,
      onCancel,
      onError}) async {
       final String sessionId =
        await CreateCheckoutSession(productitems, subtotal);
          // besh tkharejli ui function hedhy deja predefini 
    final resultat = await redirectToCheckout(
        context: context,
        sessionId: sessionId,
        publishableKey: publishbalkey,
        successUrl: "https://checkout.stripe.dev/success",
        canceledUrl: "https://checkout.stripe.dev/cancel"
        
        );
          // baaed maa yetaaml paiment w kol fonctionnette hedho besh yetaado si el payment saret besh nemshy el page okhra 
          // si el paiment ghalta les details chnowa besh naml "
          // si el clients aaml cancel ll payment chnowa naaml 
        if(mounted){

          final text= resultat.when(
            redirected: ()=> "redirected successfuly",
             success: ()=> onSuccess(),
              canceled: ()=>onCancel(), 
              error: (e)=>onError(e));
              return text;
        }
  }
}
