import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_notbook/feature/domain/entities/note_entitie.dart';
import 'package:my_notbook/feature/presentation/cubit/note/note_cubit.dart';
import 'package:my_notbook/feature/presentation/widgets/common.dart';

class AddNewNotePage extends StatefulWidget {
  final String uid;
  const AddNewNotePage({Key? key,required this.uid}) : super(key: key);

  @override
  State<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {
  TextEditingController _noteTextController=TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldStateKey=GlobalKey<ScaffoldState>();

  void initState()
  {
    _noteTextController.addListener(() {setState(() {

    }); });
    super.initState();
  }

  void dispose()
  {
    _noteTextController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldStateKey,
      appBar: AppBar(title: Text("Note"),),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${DateFormat("dd MMM hh:mm a").format(DateTime.now())} | ${_noteTextController.text.length} Characters",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            Expanded(
                child: Scrollbar(
                  child:TextFormField(
                    controller: _noteTextController,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "start typing....."
                    ),
                  ),

                ),
            ),
            InkWell(
              onTap: _submitNewNote,
              child: Container(
                height: 45,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFFE65C4F),
                  borderRadius:BorderRadius.circular(8)
                ),
                child: Text(
                  "Save",
                  style: TextStyle(
                    fontSize:18,
                    color: Colors.white
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void _submitNewNote()
  {
    if(_noteTextController.text.isEmpty){
      snackBarError(scaffoldState:_scaffoldStateKey,msg:"type something");
      return;
    }
    BlocProvider.of<NoteCubit>(context).addNote(note: NoteEntity(
      note:_noteTextController.text,
      time: Timestamp.now(),
      uid: widget.uid,
    ),);
    Future.delayed(Duration(seconds: 1),(){
      Navigator.pop(context);
    });
  }
}
