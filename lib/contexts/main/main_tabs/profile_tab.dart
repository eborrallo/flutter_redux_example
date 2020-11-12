import 'package:flutter/material.dart';
import 'package:flutter_redux_boilerplate/contexts/main/widgets/circular_progress_item.dart';

class ProfileTab extends StatelessWidget {
  ProfileTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: EdgeInsets.only(top: 20),
        color: Color.fromRGBO(245, 245, 245, 1),
        child: Column(
          children: [
            Container(
                height: 150,
                width: 150,
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    'AH',
                    style: TextStyle(fontSize: 50),
                  ),
                )),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'Adam Blue',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Text('adam.b@email.com'),
            ),
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
                        Container(
                            width: 150,
                            child: CircularProgresItem(
                              text: 'Completation Rate',
                              progressValue: 80,
                              radius: 80,
                            )),
                        Container(
                            width: 60,
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    child: Text(
                                  '38',
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
  @override
  Path getClip(Size size) {
    double radius = 33;
    double radiusLite = 10;
    Path path = Path() // Start from (0,0)
      ..lineTo(size.width, 0)
      ..lineTo(
        size.width,
        size.height,
      )
      ..lineTo((size.width / 2) + radius + radiusLite, size.height)
      ..arcToPoint(Offset((size.width / 2) + radius, size.height - radiusLite),
          radius: Radius.circular(radiusLite * 1.4))
      ..arcToPoint(Offset((size.width / 2) - radius, size.height - radiusLite),
          radius: Radius.circular(radius * 1.25), clockwise: false)
      ..arcToPoint(Offset((size.width / 2) - radius - radiusLite, size.height),
          radius: Radius.circular(radiusLite * 1.4))
      ..lineTo(0, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
