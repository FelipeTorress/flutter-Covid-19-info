import 'package:covidapp/widgets/apiRequests.dart';
import 'package:covidapp/widgets/developed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.purple,
      appBar:AppBar(
        title: Text('Informações'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      drawer: Developed(),
      body:CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _header(screenHeight),
        ],
      ),
    );
  }

  //SizedBox(height: screenHeight * 0.03),

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: screenHeight * 0.03),
            _apiStatus(DataCovid.getApiStatus(),screenHeight),
          ],
        ),
      ),
    );
  }

  _apiStatus(data,screenHeight){
    return FutureBuilder(
      future: data,
      builder: (context,snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
          case ConnectionState.none:
            return Container(
              alignment: AlignmentDirectional.center,
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 5.0,
              ),
            );
          default:
            if(snapshot.hasError){
              return Container(
                child: Text('Ative a Internet!',
                style: TextStyle(fontSize: 27),
                ),
              );
            }else{
              if(snapshot.data['status'] == 'ok'){
                return _responseWidget('Online',Colors.green,screenHeight,snapshot.data['date']);
              }else{
                return _responseWidget('offline',Colors.red,screenHeight,snapshot.data['date']);
              }
            }
        }
      },
    );
  }

  _responseWidget(status,color,screenHeight,data){
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Status da API: ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              status,
              style: TextStyle(
                color: color,
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(
              status == 'Online'?Icons.check:Icons.clear,
              color: color,
              size: 22,
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.03),
        Text(
          'Última atualização: '+ data,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
