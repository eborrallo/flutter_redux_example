import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/application/notifier/AppNotifier.dart';
import 'package:flutter_redux_boilerplate/presentation/widgets/circular_progress_item.dart';

class ProfileTab extends StatelessWidget {
  final AppNotifier appNotifier;

  ProfileTab({Key key, this.appNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: EdgeInsets.only(top: 20),
        color: Color.fromRGBO(245, 245, 245, 1),
        child: ListView(
          //physics: NeverScrollableScrollPhysics(),
          children: [
           /*  Container(
                height: 150,
                width: 150,
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    'AH',
                    style: TextStyle(fontSize: 50),
                  ),
                )),
            new Center(
                child: Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'adam',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )),
            new Center(
                child: Container(
              child: Text('adam.b@email.com'),
            )), */
            new ClipPath(
              clipper: new CustomHalfCircleClipper(),
              child: Container(
                margin: EdgeInsets.only(top: 20),
                height: 470,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListTile(
                        title: Center(
                      child: Text(
                        'Weekly Stat',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            flex: 1,
                            child: CircularProgresItem(
                              text: 'Completation Rate',
                              progressValue: appNotifier.weekCompletation ?? 0,
                              radius: 80,
                            )),
                        Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    child: Text(
                                  appNotifier.totalTasksThisWeek ?? 0,
                                  style: TextStyle(fontSize: 40),
                                )),
                                Container(
                                    child: Text('Total Task',
                                        textAlign: TextAlign.center,
                                        style: new TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17.0,
                                        )))
                              ],
                            ))
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30, top: 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 30,
                              width: 30,
                              margin: EdgeInsets.only(right: 40),
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                Icons.lightbulb_outline,
                                color: Colors.white,
                                size: 20,
                              )),
                          Column(
                            children: [
                              Container(
                                  width: 250,
                                  child: Text(
                                    'Insight',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.purple,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17.0,
                                    ),
                                  )),
                              Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width: 250,
                                  child: Text(
                                    'You can raise your completation rate by finish your task ontime',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class CustomHalfCircleClipper extends CustomClipper<Path> {
  double radius;
  double radiusLite;
  double arc;
  double arcLite;
  CustomHalfCircleClipper(
      {this.radius = 33, this.radiusLite, this.arc = 1.25, this.arcLite = 1.4});

  @override
  Path getClip(Size size) {
    double radius = this.radius;
    double radiusLite = this.radiusLite ?? radius / 3;
    Path path = Path() // Start from (0,0)
      ..lineTo(size.width, 0)
      ..lineTo(
        size.width,
        size.height,
      )
      ..lineTo((size.width / 2) + radius + radiusLite, size.height)
      ..arcToPoint(Offset((size.width / 2) + radius, size.height - radiusLite),
          radius: Radius.circular(radiusLite * this.arcLite))
      ..arcToPoint(Offset((size.width / 2) - radius, size.height - radiusLite),
          radius: Radius.circular(radius * this.arc), clockwise: false)
      ..arcToPoint(Offset((size.width / 2) - radius - radiusLite, size.height),
          radius: Radius.circular(radiusLite * this.arcLite))
      ..lineTo(0, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
