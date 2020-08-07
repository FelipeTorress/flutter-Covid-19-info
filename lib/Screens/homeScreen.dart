import 'package:covidapp/widgets/developed.dart';
import 'package:covidapp/widgets/urlCovidHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title:Text('Home'),
      centerTitle: true,
      backgroundColor: Colors.purple,
      elevation: 0.0,
    ),
      drawer: Drawer(
        child: Developed(),
      ),
      body:CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _header(screenHeight),
          _covidTestBox(screenHeight),
          _coronaSusApp(screenHeight),
        ],
      ),
    );
  }

  SliverToBoxAdapter _header(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'COVID-19',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/image/brasil.png'),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Está com sintomas?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Se você está com os sintomas da COVID-19, por favor entre em contato com especialistas!',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton.icon(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 15.0,
                      ),
                      onPressed: () {
                        CovidHelper.callSUS();
                      },
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      icon: const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Ligue Agora',//numero 136
                        style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                      textColor: Colors.white,
                    ),
                    FlatButton.icon(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 15.0,
                      ),
                      onPressed: () {
                        CovidHelper.whatsAppNumber();
                      },
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      icon: const Icon(
                        Icons.chat_bubble,
                        color: Colors.white,
                      ),
                      label: Text(
                        '  WhatsApp   ',
                        style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _covidTestBox(double screenHeight){
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: (){
          CovidHelper.covidTest();
        },
        child: Padding(
          padding: EdgeInsets.only(top: 5.0, right: 5.0, left: 5.0),
          child: Container(
            padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
            decoration: myBoxDecoration(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'assets/image/medical-sister.png',
                  fit: BoxFit.cover,
                  width: 100,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(height: screenHeight * 0.03),
                      Text(
                        'Faça o teste em casa!',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                          'clique aqui para fazer um teste online da Covid-19 totalmente gratuito!',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 15.0,
                          ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _coronaSusApp(double screenHeight){
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: (){
          CovidHelper.coronaSusApp();
        },
        child: Padding(
          padding: EdgeInsets.only(top: 5.0, right: 5.0, left: 5.0),
          child: Container(
            padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
            decoration: myBoxDecoration(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 17.0,right: 5.0),
                  child: Image.asset(
                    'assets/image/gg-play.png',
                    width: 70,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(height: screenHeight * 0.03),
                      Text(
                        'Baixe o App do SUS',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'clique aqui para baixar o aplicativo oficial do SUS para ficar informado e se proteger do Corona Vírus',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 15.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration(){
    return BoxDecoration(
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.purple,
      border: Border.all(
        color: Colors.grey,
        width: 1,
      ),
    );
  }
}