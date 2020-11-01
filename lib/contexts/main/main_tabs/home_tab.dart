import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/contexts/main/main_tabs/animated_list_item.dart';
import 'package:flutter_redux_boilerplate/contexts/main/widgets/circular_progress_item.dart';

class HomeTab extends StatelessWidget {
  HomeTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        alignment: Alignment.topLeft,
        color: Color.fromRGBO(245, 245, 245, 1),
        child: Column(children: [_onProgress(), _almostDue(), _todayClass()]));
  }

  Widget _todayClass() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Padding(
          padding: EdgeInsets.only(left: 21.0, top: 0),
          child: new Text(
            'Today Calss',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        this._buildTodayClass()
      ],
    );
  }

  Widget _buildTodayClass() {
    return new Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      height: 150.0,
      child: ListView(
          padding: EdgeInsets.only(left: 21.0),
          scrollDirection: Axis.horizontal,
          children: List.generate(
              5,
              (i) => new AnimatedListItem(
                  i,
                  Container(
                      width: 300,
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Center(
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        new ListTile(
                                          title: Text(
                                            'Algorithm',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          subtitle: Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(Icons.location_on, color: Colors.grey,size: 18,),
                                                Text(
                                                  'Room 3A',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Text('08:00 - 10:00',
                                                        textAlign:
                                                            TextAlign.right))
                                              ]),
                                        ),
                                        new Row(
                                          children: [
                                            new Icon(Icons.error_outline , color:Colors.orange,size: 18,),
                                            new Text(
                                                'You have one incpmplete task',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.orange))
                                          ],
                                        ),
                                      ])))))))),
    );
  }

  Widget _almostDue() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Padding(
          padding: EdgeInsets.only(left: 21.0, top: 20),
          child: new Text(
            'Almost Due',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        this._buildAlmostDueList()
      ],
    );
  }

  Widget _onProgress() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Padding(
          padding: EdgeInsets.only(left: 21.0, top: 140),
          child: new Text(
            'On progress',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        this._buildOnProgressList()
      ],
    );
  }

  Widget _buildAlmostDueList() {
    return new Container(
        margin: EdgeInsets.symmetric(vertical: 21.0),
        padding: EdgeInsets.symmetric(horizontal: 21.0),
        height: 230.0,
        child: Column(
            children:
                List.generate(2, (i) => new AnimatedListItem(i, card()))));
  }

  Widget card() {
    return Container(
      height: 100,
      margin: EdgeInsets.only(bottom: 10.0),
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new ListTile(
                leading: Transform.scale(
                  scale: 1.5,
                  child: Radio(
                    value: 0,
                    activeColor: Color(0xffFFBD11),
                  ),
                ),
                title: Text(
                  'Make and article',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        margin: EdgeInsets.only(right: 10.0),
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text(
                        'Networking',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Expanded(child: Text('9h 2m', textAlign: TextAlign.right))
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOnProgressList() {
    return new Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      height: 100.0,
      child: ListView(
          padding: EdgeInsets.only(left: 21.0),
          scrollDirection: Axis.horizontal,
          children: List.generate(
              5,
              (i) => new AnimatedListItem(
                  i,
                  new CircularProgresItem(
                    text: 'Algoritm',
                    progressValue: i * 20,
                  )))),
    );
  }
}
