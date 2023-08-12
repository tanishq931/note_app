


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:note_app/TextStyles.dart';
import 'package:note_app/database/Note.dart';
import 'Add_Notes.dart';
class Show_DB extends StatefulWidget {
  const Show_DB({Key? key}) : super(key: key);

  @override
  State<Show_DB> createState() => _Show_DBState();
}

class _Show_DBState extends State<Show_DB> {
  final fireStore = FirebaseFirestore.instance.collection('Notes').snapshots();
  final ref = FirebaseFirestore.instance.collection('Notes');

  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes App'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: fireStore,
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return CircularProgressIndicator();
          }

            if(snapshot.data!.docs.length!=0){
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    String s = snapshot.data!.docs[index]['id'].toString();
                    return Padding(
                      padding: const EdgeInsets.all(10.0),

                      child: InkWell(onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder:
                                (context)=>Full_Note(snapshot.data!.docs[index])));
                      },
                        child: Slidable(
                          startActionPane: start(s),
                          endActionPane: end(s),
                          child: Container(

                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Text(
                                    snapshot.data!.docs[index]['title'],
                                    style: title(),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                   snapshot.data!.docs[index]['desc'],
                                    style: desc(),
                                    maxLines: 2,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
            else{
              return const Center(
                child: Text(
                    'Nothing To Show Please Add Some Notes'
                ),
              );
            }


        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context)=>const ADD_DB()));
        },
        child: const Icon(Icons.add,),
      ),
    );
  }
  dynamic end(String s){
    return  ActionPane(
      motion: const DrawerMotion(),
      children: [
        SlidableAction(onPressed: (context){
          delete(context, s);
        },
          icon: Icons.delete,
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          label: 'Delete',
        )
      ],
    );
  }
  dynamic start(String s){
    return ActionPane(
      motion: const DrawerMotion(),
      children: [
        SlidableAction(onPressed: (context){
          edit(context,s);
        },
          icon: Icons.edit,
          backgroundColor: const Color(0xFF21B7CA),
          foregroundColor: Colors.white,
          label: 'Edit',
        )
      ],
    );
  }
  dynamic edit(BuildContext context,String s) {
    var _title = TextEditingController();
    var _desc = TextEditingController();
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text('Edit'),
        content: Container(
          height: 190,
          child: Column(

            children: [
              TextField(
                controller: _title,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.blueGrey,
                          width: 2

                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Color(0xff330063),
                          width: 2

                      ),
                    ),
                    hintText: 'Enter Title'


                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _desc,
                maxLines: 4,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.blueGrey,
                          width: 2

                      ),
                    ),
                    hintText: 'Enter Description',
                    focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: Color(0xff330063),
                    width: 2

                ),
              ),


                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                setState(() {
                  ref.doc(s).update({
                    'title': _title.text.toString(),
                    'desc': _desc.text.toString(),
                  });
                  Navigator.pop(context);
                });
              },
              child: const Text('Confirm'))

        ],

      );
    });
  }
  dynamic delete(BuildContext context,String s){

    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text('Delete'),
        content: const Text('Do you want to delete'),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text('Cancel')),
          TextButton(onPressed: (){
            setState(() {
              ref.doc(s).delete();
            });

            Navigator.pop(context);

          },
              child: const Text('Confirm'))

        ],

      );
    });
  }
}
