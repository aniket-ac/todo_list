import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'TO-DO LIST';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: SafeArea(
        child: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> with SingleTickerProviderStateMixin{
  static const List<Tab> status = [
    Tab(text: 'Pending',),
    Tab(text: 'Completed',),
  ];
  String title = MyApp._title;
  
  late TabController _tabController;
  late String givenTask;

  Future<void> _showDialog(BuildContext context){
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('What will you do?'),
          content: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Task',
            ),
            onSubmitted: (value){
              setState(() {
                givenTask = value;
              });
              listPending.add(pendingList(givenTask));
            },
          ),
        );
      }
    );
  }
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: status.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  List<Card> listPending = [];
  List<Card> listCompleted = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        bottom: TabBar(
          controller: _tabController,
          tabs: status,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView(
              padding: EdgeInsets.all(10.0),
              children: listPending
          ),
          ListView(
              padding: EdgeInsets.all(10.0),
              children: listCompleted
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showDialog(context);
          },
          child: Icon(Icons.add),
      ),
    );
  }

  Card pendingList(String givenTask) {
    final String task = givenTask;
    return Card(
              elevation: 2.0,
              margin: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      task,
                    ),
                  ),
                  TextButton(
                      onPressed: (){
                        _showDialog(context);
                        listPending.removeWhere((element) => task == givenTask);
                      },
                      child: Icon(Icons.edit_note)
                  ),
                  TextButton(
                    onPressed: (){
                      setState(() {
                        listPending.removeWhere((element) => task == givenTask);
                        listCompleted.add(completedList(givenTask));
                      });
                      print('object');
                    },
                    child: Text('Done?'),
                  ),
                ],
              ),
    );
  }
  Card completedList(String givenTask) {
    final String task = givenTask;
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
                task
            ),
          ),
          Icon(Icons.done),
        ],
      ),
    );
  }
}



// stores ExpansionPanel state information
