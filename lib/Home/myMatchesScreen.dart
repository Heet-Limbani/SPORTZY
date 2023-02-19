import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyMatchesScreen extends StatefulWidget {
  const MyMatchesScreen({super.key});
  @override
  State<MyMatchesScreen> createState() => _MyMatchesScreenState();
}

class _MyMatchesScreenState extends State<MyMatchesScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    _tabController = new TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                height: 50,
                child: Text(
                  "Standalone-Match",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Tab(
                height: 50,
                child: Text(
                  "Tournament",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('sport')
                      .doc('badminton')
                      .collection('doubles')
                      .snapshots()
                      .where(
                    (event) {
                      return event.docs.where(
                        (element) {
                          return element['createdBy'] == _auth.currentUser!.uid;
                        },
                      ).isNotEmpty;
                    },
                  ),
                  builder: (ctx2, snapshot2) {
                    if (snapshot2.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot2.data!.docs.length,
                        itemBuilder: (ctx, index) {
                          return ListTile(
                            title:
                                Text(snapshot2.data!.docs[index]['match_name']),
                          );
                        },
                      ),
                    );
                  },
                ),
                Center(
                  child: Text(
                    "Tournament",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
