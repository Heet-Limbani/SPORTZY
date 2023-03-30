import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sportzy/Home/Badminton/liveFilterMatchName.dart';
import 'package:sportzy/Others/firestoreFields.dart';

import 'liveFilterLocation.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});
  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  bool _isSingle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isSingle
          ? SizedBox(
              height: double.infinity,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Container(
                              margin: EdgeInsets.all(3),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 47, 153, 240),
                                ),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Text(
                                'Search by location',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              )),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LiveFilterLocation()));
                          },
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.all(3),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromARGB(255, 47, 153, 240),
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              'Search by match name',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LiveFilterMatchName()));
                          },
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('sport')
                        .doc('badminton')
                        .collection('singles')
                        .snapshots(),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final matchDocs = snapshot.data!.docs;
                      print(matchDocs.length);
                      return Expanded(
                        child: ListView.builder(
                          itemCount: matchDocs.length,
                          itemBuilder: (context, index) => Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 47, 153, 240),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    "${matchDocs[index][FireStoreFields.match_name]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Text(
                                  "Match Date : ${matchDocs[index][FireStoreFields.date]}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.005,
                                ),
                                Text(
                                  "Location : ${matchDocs[index][FireStoreFields.location]}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.005,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "${matchDocs[index][FireStoreFields.team_A_name]}",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 47, 153, 240),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.05,
                                    ),
                                    Text(
                                      "v/s",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 47, 153, 240),
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.05,
                                    ),
                                    Text(
                                      "${matchDocs[index][FireStoreFields.team_B_name]}",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 47, 153, 240),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "${matchDocs[index][FireStoreFields.team_A_player]}",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 47, 153, 240),
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                    ),
                                    Text(
                                      "${matchDocs[index][FireStoreFields.team_B_player]}",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 47, 153, 240),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color.fromARGB(255, 241, 28, 74),
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "${matchDocs[index][FireStoreFields.point_team_A]}",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 47, 153, 240),
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                            ),
                                            Text(
                                              "${matchDocs[index][FireStoreFields.point_team_B]}",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 47, 153, 240),
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color.fromARGB(255, 2, 154, 90),
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "Set 1 :",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 47, 153, 240),
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.07,
                                            ),
                                            Text(
                                              "${matchDocs[index][FireStoreFields.team_A_set_1_points]}",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 47, 153, 240),
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                            ),
                                            Text(
                                              "-",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 47, 153, 240),
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                            ),
                                            Text(
                                              "${matchDocs[index][FireStoreFields.team_B_set_1_points]}",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 47, 153, 240),
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "Set 2 :",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 47, 153, 240),
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.07,
                                            ),
                                            Text(
                                              "${matchDocs[index][FireStoreFields.team_A_set_2_points]}",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 47, 153, 240),
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                            ),
                                            Text(
                                              "-",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 47, 153, 240),
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                            ),
                                            Text(
                                              "${matchDocs[index][FireStoreFields.team_B_set_2_points]}",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 47, 153, 240),
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "Set 3 :",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 47, 153, 240),
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.07,
                                            ),
                                            Text(
                                              "${matchDocs[index][FireStoreFields.team_A_set_3_points]}",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 47, 153, 240),
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                            ),
                                            Text(
                                              "-",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 47, 153, 240),
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                            ),
                                            Text(
                                              "${matchDocs[index][FireStoreFields.team_B_set_3_points]}",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 47, 153, 240),
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          : SizedBox(
              height: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Container(
                              margin: EdgeInsets.all(3),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 47, 153, 240),
                                ),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Text(
                                'Search by location',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              )),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LiveFilterLocation()));
                          },
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.all(3),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromARGB(255, 47, 153, 240),
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              'Search by match name',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LiveFilterMatchName()));
                          },
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('sport')
                        .doc('badminton')
                        .collection('doubles')
                        .snapshots(),
                    builder: (ctx2, snapshot2) {
                      if (snapshot2.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final matchDocs2 = snapshot2.data!.docs;
                      print(matchDocs2.length);
                      return Expanded(
                        child: ListView.builder(
                          itemCount: matchDocs2.length,
                          itemBuilder: (context, index) => Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 47, 153, 240),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    "${matchDocs2[index][FireStoreFields.match_name]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Text(
                                  "Match Date : ${matchDocs2[index][FireStoreFields.date]}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.005,
                                ),
                                Text(
                                  "Location : ${matchDocs2[index][FireStoreFields.location]}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.005,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "${matchDocs2[index][FireStoreFields.team_A_name]}",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 47, 153, 240),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.05,
                                    ),
                                    Text(
                                      "v/s",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 47, 153, 240),
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.05,
                                    ),
                                    Text(
                                      "${matchDocs2[index][FireStoreFields.team_B_name]}",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 47, 153, 240),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "${matchDocs2[index][FireStoreFields.team_A_player1]}",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 47, 153, 240),
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                    ),
                                    Text(
                                      "${matchDocs2[index][FireStoreFields.team_B_player1]}",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 47, 153, 240),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "${matchDocs2[index][FireStoreFields.team_A_player2]}",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 47, 153, 240),
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                    ),
                                    Text(
                                      "${matchDocs2[index][FireStoreFields.team_B_player2]}",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 47, 153, 240),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color.fromARGB(255, 241, 28, 74),
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "${matchDocs2[index][FireStoreFields.point_team_A]}",
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 47, 153, 240),
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                        ),
                                        Text(
                                          "${matchDocs2[index][FireStoreFields.point_team_B]}",
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 47, 153, 240),
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color.fromARGB(255, 2, 154, 90),
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "Set 1 :",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 47, 153, 240),
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.07,
                                            ),
                                            Text(
                                              "${matchDocs2[index][FireStoreFields.team_A_set_1_points]}",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 47, 153, 240),
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                            ),
                                            Text(
                                              "-",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 47, 153, 240),
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                            ),
                                            Text(
                                              "${matchDocs2[index][FireStoreFields.team_B_set_1_points]}",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 47, 153, 240),
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "Set 2 :",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 47, 153, 240),
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.07,
                                            ),
                                            Text(
                                              "${matchDocs2[index][FireStoreFields.team_A_set_2_points]}",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 47, 153, 240),
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                            ),
                                            Text(
                                              "-",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 47, 153, 240),
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                            ),
                                            Text(
                                              "${matchDocs2[index][FireStoreFields.team_B_set_2_points]}",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 47, 153, 240),
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "Set 3 :",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 47, 153, 240),
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.07,
                                            ),
                                            Text(
                                              "${matchDocs2[index][FireStoreFields.team_A_set_3_points]}",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 47, 153, 240),
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                            ),
                                            Text(
                                              "-",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 47, 153, 240),
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                            ),
                                            Text(
                                              "${matchDocs2[index][FireStoreFields.team_B_set_3_points]}",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 47, 153, 240),
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_isSingle ? Icons.person : Icons.people),
        onPressed: () {
          setState(() {
            _isSingle = !_isSingle;
          });
        },
      ),
    );
  }
}
