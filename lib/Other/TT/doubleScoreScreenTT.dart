// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sportzy/Other/doublesResult.dart';

import 'doublesResultTT.dart';
class DoubleScoreScreenTT extends StatefulWidget {
  var p1,
      p2,
      p3,
      p4,
      t1,
      t2,
      docRef,
      doublesDocRef,
      pointTA,
      pointTB,
      setTA,
      setTB,
      setNum,
      match_name;
  DoubleScoreScreenTT({
    Key? mykey,
    required this.p1,
    required this.p2,
    required this.p3,
    required this.p4,
    required this.t1,
    required this.t2,
    required this.doublesDocRef,
    required this.match_name,
    required this.pointTA,
    required this.pointTB,
    required this.setNum,
    required this.setTA,
    required this.setTB,
  }) : super(key: mykey);
  @override
  State<DoubleScoreScreenTT> createState() => _DoubleScoreScreenTTState();
}

class _DoubleScoreScreenTTState extends State<DoubleScoreScreenTT> {
  void _decrementCountP1() {
    setState(() {
      if (widget.pointTA < 1) {
        return;
      }
      widget.pointTA--;
    });
    postPointDetailsToFirestore();
  }

  void _decrementCountP2() {
    setState(() {
      if (widget.pointTB < 1) {
        return;
      }
      widget.pointTB--;
    });
    postPointDetailsToFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.033,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromARGB(255, 15, 136, 236),
                  ),
                  child: Center(
                    child: Text(
                      '${widget.p1}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromARGB(255, 15, 136, 236),
                  ),
                  child: Center(
                    child: Text(
                      '${widget.p3}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.033,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromARGB(255, 15, 136, 236),
                  ),
                  child: Center(
                    child: Text(
                      '${widget.p2}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromARGB(255, 15, 136, 236),
                  ),
                  child: Center(
                    child: Text(
                      '${widget.p4}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.025,
                ),
                GestureDetector(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.27,
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color.fromARGB(255, 15, 136, 236),
                    ),
                    child: Center(
                      child: Text(
                        ("${widget.pointTA}"),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      widget.pointTA++;
                      if (widget.pointTA == 21) {
                        if (widget.setNum == 1) {
                          set_1_points();
                        } else if (widget.setNum == 2) {
                          set_2_points();
                        } else if (widget.setNum == 3) {
                          set_3_points();
                        }
                        widget.pointTA = 0;
                        widget.pointTB = 0;
                        widget.setTA++;
                        setDetailsTeam_A();
                        widget.setNum++;
                      }
                      if (widget.setTA == 2 || widget.setTB == 2) {
                        if (widget.setTA == 2) {
                          winningTeam_A();
                        } else if (widget.setTB == 2) {
                          winningTeam_B();
                        }
                        completeMatchDetails();
                        widget.setTA = 0;
                        widget.setTB = 0;
                        widget.setNum = 1;
                      }
                    });
                    postPointDetailsToFirestore();
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                GestureDetector(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.27,
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color.fromARGB(255, 15, 136, 236),
                    ),
                    child: Center(
                      child: Text(
                        ("${widget.pointTB}"),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      widget.pointTB++;
                      if (widget.pointTB == 21) {
                        if (widget.setNum == 1) {
                          set_1_points();
                        } else if (widget.setNum == 2) {
                          set_2_points();
                        } else if (widget.setNum == 3) {
                          set_3_points();
                        }
                        widget.pointTA = 0;
                        widget.pointTB = 0;
                        widget.setTB++;
                        setDetailsTeam_B();
                        widget.setNum++;
                      }
                      if (widget.setTA == 2 || widget.setTB == 2) {
                        if (widget.setTA == 2) {
                          winningTeam_A();
                        } else if (widget.setTB == 2) {
                          winningTeam_B();
                        }
                        completeMatchDetails();
                        widget.setTA = 0;
                        widget.setTB = 0;
                        widget.setNum = 1;
                      }
                    });
                    postPointDetailsToFirestore();
                  },
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.001,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: 65,
                    ),
                    onPressed: _decrementCountP1,
                    color: Color.fromARGB(255, 15, 136, 236),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.001,
                ),
                Text(
                  "Set " + "${widget.setNum}",
                  style: TextStyle(fontSize: 26),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: 65,
                    ),
                    color: Color.fromARGB(255, 15, 136, 236),
                    onPressed: _decrementCountP2,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.27,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.21,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromARGB(255, 15, 136, 236),
                  ),
                  child: Center(
                    child: Text(
                      ("${widget.setTA}"),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.21,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromARGB(255, 15, 136, 236),
                  ),
                  child: Center(
                    child: Text(
                      ("${widget.setTB}"),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  completeMatchDetails() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var snapshot = await firebaseFirestore
        .collection('sport')
        .doc('TT')
        .collection('doubles')
        .doc(widget.doublesDocRef)
        .get();
    var match_name = snapshot['match_name'];
    var team_A_name = snapshot['team_A_name'];
    var team_B_name = snapshot['team_B_name'];
    var team_A_player1 = snapshot['team_A_player1'];
    var team_B_player1 = snapshot['team_B_player1'];
    var team_A_player2 = snapshot['team_A_player2'];
    var team_B_player2 = snapshot['team_B_player2'];
    var team_A_set = snapshot['team_A_set'];

    var team_A_set_1_points = snapshot['team_A_set_1_points'];
    var team_A_set_2_points = snapshot['team_A_set_2_points'];
    var team_A_set_3_points = snapshot['team_A_set_3_points'];
    var team_B_set_1_points = snapshot['team_B_set_1_points'];
    var team_B_set_2_points = snapshot['team_B_set_2_points'];
    var team_B_set_3_points = snapshot['team_B_set_3_points'];
    var date = snapshot['date'];
    var winner_team;
    if (team_A_set == 2) {
      winner_team = widget.t1;
    } else {
      winner_team = widget.t2;
    }

    await firebaseFirestore
        .collection('sport')
        .doc('TT')
        .collection('completed_doubles')
        .add({
      'match_name': match_name,
      'team_A_name': team_A_name,
      'team_B_name': team_B_name,
      'team_A_player1': team_A_player1,
      'team_B_player1': team_B_player1,
      'team_A_player2': team_A_player2,
      'team_B_player2': team_B_player2,
      'team_A_set_1_points': team_A_set_1_points,
      'team_A_set_2_points': team_A_set_2_points,
      'team_A_set_3_points': team_A_set_3_points,
      'team_B_set_1_points': team_B_set_1_points,
      'team_B_set_2_points': team_B_set_2_points,
      'team_B_set_3_points': team_B_set_3_points,
      'winner_team': winner_team,
      'date': date,
    });
  }

  postPointDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore
        .collection('sport')
        .doc('TT')
        .collection('doubles')
        .doc(widget.doublesDocRef)
        .update({
      'point_team_A': widget.pointTA,
      'point_team_B': widget.pointTB,
    });
  }

  set_1_points() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore
        .collection('sport')
        .doc('TT')
        .collection('doubles')
        .doc(widget.doublesDocRef)
        .update({
      'team_A_set_1_points': widget.pointTA,
      'team_B_set_1_points': widget.pointTB,
    });
  }

  set_2_points() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore
        .collection('sport')
        .doc('TT')
        .collection('doubles')
        .doc(widget.doublesDocRef)
        .update({
      'team_A_set_2_points': widget.pointTA,
      'team_B_set_2_points': widget.pointTB,
    });
  }

  set_3_points() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore
        .collection('sport')
        .doc('TT')
        .collection('doubles')
        .doc(widget.doublesDocRef)
        .update({
      'team_A_set_3_points': widget.pointTA,
      'team_B_set_3_points': widget.pointTB,
    });
  }

  setDetailsTeam_A() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore
        .collection('sport')
        .doc('TT')
        .collection('doubles')
        .doc(widget.doublesDocRef)
        .update({
      'team_A_set': widget.setTA,
    });
  }

  setDetailsTeam_B() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore
        .collection('sport')
        .doc('TT')
        .collection('doubles')
        .doc(widget.doublesDocRef)
        .update({
      'team_B_set': widget.setTB,
    });
  }

  winningTeam_A() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore
        .collection('sport')
        .doc('TT')
        .collection('doubles')
        .doc(widget.doublesDocRef)
        .update({
      'winner_team ': widget.t1.toString(),
    });
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => DoublesResultTT(
          winner: widget.t1.toString(),
          doublesDocRef: widget.doublesDocRef,
        ),
      ),
    );
  }

  winningTeam_B() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore
        .collection('sport')
        .doc('TT')
        .collection('doubles')
        .doc(widget.doublesDocRef)
        .update({
      'winner_team ': widget.t2.toString(),
    });
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => DoublesResultTT(
          winner: widget.t2.toString(),
          doublesDocRef: widget.doublesDocRef,
        ),
      ),
    );
  }
}
