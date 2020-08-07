import 'package:url_launcher/url_launcher.dart';

class CovidHelper{
  static void callSUS(){
    launch('tel:136');
  }
  static void whatsAppNumber(){
    const url = 'https://wa.me/5561999380031';
    _launchURL(url);
  }
  static void covidTest(){
    const url = 'https://www.coronabr.com.br/';
    _launchURL(url);
  }
  static void coronaSusApp(){
    const url = 'https://play.google.com/store/apps/details?id=br.gov.datasus.guardioes&hl=pt_BR';
    _launchURL(url);
  }
}
_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}