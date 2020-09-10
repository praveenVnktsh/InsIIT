import 'package:flutter/material.dart';

class MiscPage extends StatefulWidget {
  @override
  _MiscPageState createState() => _MiscPageState();
}

class _MiscPageState extends State<MiscPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 100),
            Container(
              height: 300,
              child: Image.asset('assets/images/slide_7.png'),
            ),
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20, left: 60, right: 60),
              // height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /*(beta)Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: FlatButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/RoomBooking'),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(40.0),
                          side: BorderSide(
                            color: Colors.black12,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          child: Text(
                            "Facility Booking",
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),*/
                  SizedBox(
                    height: 22,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: FlatButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/importantcontacts'),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(40.0),
                          side: BorderSide(
                            color: Colors.black12,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          child: Text(
                            "Important Contacts",
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: FlatButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/Quicklinks'),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(40.0),
                          side: BorderSide(
                            color: Colors.black12,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          child: Text(
                            "Quick Links",
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: FlatButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/developers'),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(40.0),
                          side: BorderSide(
                            color: Colors.black12,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          child: Text(
                            "Developers",
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
