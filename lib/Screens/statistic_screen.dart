import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:covidapp/widgets/developed.dart';
import 'package:covidapp/widgets/infoBlocks.dart';
import 'package:covidapp/widgets/apiRequests.dart';
import 'package:covidapp/widgets/statesClass.dart';


States selectedState;

List<States> _states = <States>[
  const States('BR', 'Brasil'),
  const States('AC', 'Acre'),
  const States('AL', 'Alagoas'),
  const States('AP', 'Amapá'),
  const States('AM', 'Amazonas'),
  const States('CE', 'Ceará'),
  const States('DF', 'Distrito Federal'),
  const States('ES', 'Espírito Santo'),
  const States('GO', 'Goiás'),
  const States('MA', 'Maranhão'),
  const States('MT', 'Mato Grosso'),
  const States('MS', 'Mato Grosso do Sul'),
  const States('MG', 'Minas Gerais'),
  const States('PA', 'Pará'),
  const States('PB', 'Paraíba'),
  const States('PR', 'Paraná'),
  const States('PE', 'Pernambuco'),
  const States('PI', 'Piauí'),
  const States('RJ', 'Rio de Janeiro'),
  const States('RN', 'Rio Grande do Norte'),
  const States('RS', 'Rio Grande do Sul'),
  const States('RO', 'Rondônia'),
  const States('RR', 'Roraima'),
  const States('SC', 'Santa Catarina'),
  const States('SP', 'São Paulo'),
  const States('SE', 'Sergipe'),
  const States('TO', 'Tocantins'),
];

class StatisticScreen extends StatefulWidget {
  @override
  _StatisticScreenState createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.purple,
        appBar:AppBar(
          title: Text('Estatisticas'),
          centerTitle: true,
          backgroundColor: Colors.purple,
          elevation: 0,
          bottom: TabBar(
            indicator: BubbleTabIndicator(
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              indicatorHeight: 40.0,
              indicatorColor: Colors.white30,
            ),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Text('Brasil',style: TextStyle(fontSize: 20.0)),
              Text('Mundo',style: TextStyle(fontSize: 20.0)),
            ],
          ),
        ),
        drawer: Developed(),
        body:TabBarView(
          children: <Widget>[
            CustomScrollView(
              physics: ClampingScrollPhysics(),
              slivers: <Widget>[
                dropDButtom(),
                infoBody(//infoBlocks
                    selectedState.name == 'Brasil'?
                    DataCovid.getDataBrasil()
                        :
                    DataCovid.getDataStateBrasil(selectedState.initials
                        .toLowerCase()),

                    selectedState),
              ],
            ),

            CustomScrollView(
              physics: ClampingScrollPhysics(),
              slivers: <Widget>[
                infoBody(DataCovid.getDataWorld(),null),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter dropDButtom(){
    return SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.only(top: 20.0),
          alignment: AlignmentDirectional.center,
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Selecione a Região:  ',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              DropdownButton<States>(
                value: selectedState,
                icon: Icon(Icons.keyboard_arrow_down),
                iconSize: 27,
                iconEnabledColor: Colors.black,
                onChanged: (States states){
                  setState(() {
                    selectedState = states;
                  });
                },

                items:  _states.map((States state){
                  return DropdownMenuItem<States>(
                    value: state,
                    child: Text(
                      state.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
              ),
            ],
          )
        ),
    );
  }

  @override
  void initState() {
    super.initState();
    selectedState = const States('BR', 'Brasil');
  }
}
