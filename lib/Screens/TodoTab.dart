import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class toDoTab extends StatelessWidget {
  toDoTab({Key? key}) : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Function to show the bottom sheet with task details form.
  void _showTaskForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            child: TaskForm(), // Create the TaskForm widget.
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => _showTaskForm(context),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              height: 40,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(spreadRadius: 8, color: Colors.grey, blurRadius: 15)
                ],
                color: Colors.purple.shade700,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  "Add Record",
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('todos')
                  .orderBy('timeStamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData && snapshot.data!.docs.length == 0) {
                  return Center(
                      child: Image(
                          image: AssetImage('assets/image/noTaskData.jpg')));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return TodoTile(
                      docsnap: snapshot.data!.docs[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TaskForm extends StatefulWidget {
  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  String taskName = '';
  String selectedTeamMember = 'Member 1'; // Set an initial value here
  DateTime? dueDate;

  // Function to save the task to Firestore
  void _addTask() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (taskName.isNotEmpty && _selectedUser != '' && dueDate != null) {
      FirebaseFirestore.instance.collection('todos').add({
        'id': '',
        'task': taskName,
        'atname': _selectedUser,
        'dueDate': DateFormat.yMEd().format(dueDate!).toString(),
        'done': false,
        'timeStamp': Timestamp.now(),
        'abname': FirebaseAuth.instance.currentUser!.displayName.toString(),
      }).then((value) => FirebaseFirestore.instance
          .collection('todos')
          .doc(value.id)
          .update({'id': value.id}));

      // Close the bottom sheet after saving the task
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.withOpacity(0.4),
        content: Text("Please Enter All Data"),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.3,
            right: 20,
            left: 20),
      ));
    }
  }

  List<String> _users = [];
  String? _selectedUser = '';
  String hint = 'Assign the task to ?';
  getusers() async {
    QuerySnapshot<Map<String, dynamic>> tempUsers =
        await FirebaseFirestore.instance.collection('Users').get();
    mapRecords(tempUsers);
    // return tempp;
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> recs) {
    // return recs.docs
    List<String> _list = recs.docs.map((e) => e['name'].toString()).toList();
    setState(() {
      _users = _list;
    });

    // print("Test 1 : " + listofRecs[0].uid.toString());
  }

  List<String?> suggetionsList(String query) {
    List<String> matches = [];
    matches.addAll(_users);
    matches.retainWhere(
        (element) => element.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getusers();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                taskName = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Task Name',
              border: InputBorder.none,
              prefixIcon: Icon(Icons.task),
              focusColor: Colors.purple,
            ),
          ),
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: TypeAheadField<String?>(
            textFieldConfiguration: TextFieldConfiguration(
              autofocus: true,
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(fontStyle: FontStyle.italic),
              decoration: InputDecoration(
                focusColor: Colors.purple,
                border: InputBorder.none,
                hintText: hint,
                prefixIcon: Icon(Icons.person),
              ),
            ),
            suggestionsCallback: (pattern) => suggetionsList(pattern),
            itemBuilder: (context, itemData) {
              return ListTile(
                title: Text(itemData ?? ''),
                leading: Icon(FontAwesomeIcons.user),
                // leading: CircleAvatar(
                //   backgroundImage: NetworkImage(
                //       FirebaseAuth.instance.currentUser!.photoURL.toString()),
                // ),
              );
            },
            onSuggestionSelected: (suggestion) {
              setState(() {
                _selectedUser = suggestion;
                hint = suggestion ?? '';
              });
            },
          ),
        ),
        SizedBox(height: 16),
        TextButton(
          onPressed: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2101),
            );
            if (picked != null && picked != dueDate) {
              setState(() {
                dueDate = picked;
              });
            }
          },
          child: Text(
            dueDate != null
                ? 'Due Date: ${DateFormat.yMEd().format(dueDate!)}'
                : 'Select Due Date',
            style: TextStyle(
                color: Colors.purple.shade900,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 16),
        // ElevatedButton(
        //   onPressed: _addTask,
        //   child: Text('Add Task'),
        // ),
        GestureDetector(
          onTap: _addTask,
          child: Container(
            margin: EdgeInsets.all(10),
            height: 40,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(spreadRadius: 8, color: Colors.grey, blurRadius: 15)
              ],
              color: Colors.purple.shade800,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                "Add Task",
                style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
            ),
          ),
        ),
      ],
    );
  }
}

class TodoTile extends StatefulWidget {
  DocumentSnapshot docsnap;
  TodoTile({required this.docsnap});

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(7, 7, 7, 7),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                FirebaseFirestore.instance
                    .collection('todos')
                    .doc(widget.docsnap.id)
                    .delete();
              },
              backgroundColor: Colors.red,
              icon: FontAwesomeIcons.deleteLeft,
              borderRadius:
                  const BorderRadius.horizontal(right: Radius.circular(12)),
              foregroundColor: Colors.black,
              label: 'Delete',
            )
          ],
        ),
        child: Container(
          width: screenWidth,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.purple.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(7, 7, 7, 7),
                child: Theme(
                  data: ThemeData(
                    checkboxTheme: CheckboxThemeData(
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    unselectedWidgetColor: Colors.black,
                  ),
                  child: Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                      splashRadius: 12,
                      value: widget.docsnap['done'],
                      onChanged: (value) {
                        setState(() {
                          FirebaseFirestore.instance
                              .collection('todos')
                              .doc(widget.docsnap['id'])
                              .update({'done': !widget.docsnap['done']});
                        });
                      },
                      activeColor: Colors.purple.shade400,
                      checkColor: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                width: screenWidth / 1.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      softWrap: true,
                      '${widget.docsnap['task']}',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: screenWidth / 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Assigned To : ${widget.docsnap['atname']}',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: screenWidth / 25,
                      ),
                    ),
                    Text(
                      'Assigned By :  ${widget.docsnap['abname']}',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: screenWidth / 25,
                      ),
                    ),
                    Text(
                      'Due Date :  ${widget.docsnap['dueDate']}',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: screenWidth / 25,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
