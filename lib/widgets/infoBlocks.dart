import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const subtitleTextStyle = TextStyle(fontSize:16.0,fontWeight:FontWeight.bold,color: Colors.black);
const numberTextStyle = TextStyle(fontSize: 27.0,fontWeight: FontWeight.bold,color: Colors.black);

int confirmed, recovered, deaths, cases;

SliverToBoxAdapter infoBody(data,selectedState) {
  return SliverToBoxAdapter(
      child: FutureBuilder(
        future: data,
        builder:(context,snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Container(
                width: 200.0,
                height: 200.0,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 6.0,
                ),
              );
            default:
              if(snapshot.hasError){
                return Container(
                  child: Text('Ative a Internet!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 23),),
                );
              } else{
                if(selectedState != null && selectedState.name == 'Brasil'){ //retornar informaçôes do Brasil
                  return _infoBrasil(context,snapshot);
                }else if(selectedState != null){
                  return _infoStateBrasil(context,snapshot);
                }else
                  return _infoWorld(context,snapshot);//retornar informações do Brasil
              }
          }
        } ,
      )
  );
}

_infoStateBrasil(context,snapshot){
  confirmed = 0; recovered = 0 ; deaths = 0 ; cases = 0;

  //Na API quando requisitado os dados por estado os mesmos diferem de outras requisições
  cases = snapshot.data['cases'];//casos viram confirmados
  confirmed = snapshot.data['suspects'];//confirmados viram suspeitos
  deaths = snapshot.data['deaths'];//se mantem
  recovered = snapshot.data['refuses'];//recuperados viram casos descartados

  return _infoBlocks(context, snapshot,true);
}

_infoBrasil(context,snapshot){
  confirmed = 0; recovered = 0 ; deaths = 0 ; cases = 0;

  cases = snapshot.data['data']['cases'];
  confirmed = snapshot.data['data']['confirmed'];
  deaths = snapshot.data['data']['deaths'];
  recovered = snapshot.data['data']['recovered'];

  return _infoBlocks(context, snapshot,false);
}

_infoWorld(context,snapshot){

  confirmed = 0; recovered = 0 ; deaths = 0 ; cases = 0;

  for(int i = 0; i < 188 ; i++){
    cases += snapshot.data['data'][i]['cases'];
    confirmed += snapshot.data['data'][i]['confirmed'];
    deaths += snapshot.data['data'][i]['deaths'];
    if(snapshot.data['data'][i]['recovered'] != null)
      recovered += snapshot.data['data'][i]['recovered'];
  }

  return _infoBlocks(context, snapshot,false);
}

_infoBlocks(context,snapshot,isState){
  return Padding(
    padding: EdgeInsets.only(top: 25.0,left: 10.0, right: 10.0),
      child: Column(
        children: <Widget>[

          _buildBlock(
              isState?
                Text(
                  'Confirmados:',style: subtitleTextStyle,textAlign: TextAlign.start,
                )
                    :
                Text(
                  'Suspeitos:',style: subtitleTextStyle,textAlign: TextAlign.start,
                ),

              Text(cases.toString(),style: numberTextStyle,),

              Colors.blue
          ),

          _buildBlock(
              isState?
              Text(
                'Suspeitos:',style: subtitleTextStyle,textAlign: TextAlign.start,
              )
                :
              Text(
                'Confirmados:',style: subtitleTextStyle,textAlign: TextAlign.start,
              ),

              Text(confirmed.toString(),style: numberTextStyle,),

              Colors.yellow
          ),

          _buildBlock(
              Text(
                'Mortes:',style: subtitleTextStyle,textAlign: TextAlign.start,
              ),
              Text(deaths.toString(),style: numberTextStyle,),
              Colors.red
          ),
          _buildBlock(
              isState?
                Text(
                  'Descartados:',style: subtitleTextStyle,textAlign: TextAlign.start,
                )
                    :
                Text(
                  'Recuperados:',style: subtitleTextStyle,textAlign: TextAlign.start,
                ),

              Text(recovered.toString(),style: numberTextStyle,),
              Colors.green
          ),

        ],
      ),
  );
}

_buildBlock(text1,text2,colorblock){
  return Padding(
    padding: EdgeInsets.only(top:15.0),
    child: Container(
      padding: EdgeInsets.all(8.0),
      width: 300,
      child: Column(
        children: <Widget>[
          text1,
          text2
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: colorblock,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
    ),
  );
}
