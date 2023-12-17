import 'package:flutter/material.dart';
import 'package:web3/notes_services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    var notesServices = context.watch<NotesServices>();
    return Stack(children: <Widget>[
      Image.asset(
        "assets/Untitleddesign.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            backgroundColor: Color.fromRGBO(48, 73, 217, 1),
            leading: IconButton(
              icon: Image.asset(
                  'assets/Modern_Elegant_Certificate_of_Appreciation__1_-removebg-preview.png'),
              onPressed: () {},
            ),
            title: Center(
              child: const Text(
                'HealUp',
                style: TextStyle(
                  //using ARGB (Alpha Red Green Blue)
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Image.asset(
                    'assets/Modern_Elegant_Certificate_of_Appreciation__1_-removebg-preview.png'),
                onPressed: () {},
              ),
            ]),
        body: notesServices.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () async {},
                child: 
                Column(
                  children: [
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 20),
                        child: Text(
                          'List Of Patients',
                          style: TextStyle(
                              color: Colors.blueGrey,fontWeight: FontWeight.bold, fontSize: 23),
                        ),
                      )
                    ],
                  )
                  ,  Expanded(
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                        itemCount: notesServices.notes.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Color.fromRGBO( 92, 233, 255,0.5),
                            child: ListTile(
                            
                            title: Text(
                              notesServices.notes[index].title,
                              style: TextStyle(color: Color.fromARGB(255, 1, 34, 101)
                              ,fontSize: 25,),
                            ),
                            subtitle: Text(
                              notesServices.notes[index].description,
                              style: TextStyle(
                                color: Color.fromARGB(255, 107, 117, 138),
                                fontSize: 20,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Color.fromARGB(255, 16, 133, 20),
                              ),  
                              onPressed: () {
                                notesServices
                                    .deleteNote(notesServices.notes[index].id);
                              },
                            ),
                          ));
                        },
                      ),
                    ),
                  ],
                ),
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(48, 73, 217, 1),
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('New Patient'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          hintText: 'Enter Patient Name',
                        ),
                      ),
                      TextField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          hintText: 'Enter Patient Lastname ',
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        notesServices.addNote(
                          titleController.text,
                          descriptionController.text,
                        );
                        Navigator.pop(context);
                      },
                      child: const Text('Add'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      )
    ]);
  }
}
