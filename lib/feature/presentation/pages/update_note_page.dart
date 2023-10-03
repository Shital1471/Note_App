import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_notbook/feature/domain/entities/note_entitie.dart';
import 'package:my_notbook/feature/presentation/cubit/note/note_cubit.dart';

class UpdateNotePage extends StatefulWidget {
  final NoteEntity noteEntity;
  const UpdateNotePage({Key? key,required this.noteEntity}) : super(key: key);

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {

  TextEditingController? _noteTextController;

  void initState()
  {
    _noteTextController=TextEditingController(
      text: widget.noteEntity.note
    );
    _noteTextController!.addListener(() { setState(() {

    });});
    super.initState();
  }

  void dispose()
  {
    _noteTextController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Note"
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${DateFormat("dd MM hh:mm a").format(DateTime.now())} | ${_noteTextController!.text.length} Characters",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black.withOpacity(0.5)
              ),
            ),
            Expanded(
                child:Scrollbar(
                  child: TextFormField(
                    controller: _noteTextController,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "start your note"
                    ),
                  ),
                ),
            ),
             InkWell(
               onTap: _submitUpdateNote,
               child: Container(
                 height: 45,
                 width: double.infinity,
                 alignment: Alignment.center,
                 decoration: BoxDecoration(
                   color: Color(0xFFE65C4F),
                   borderRadius: BorderRadius.circular(8)
                 ),
                 child: Text(
                   "Update",
                   style: TextStyle(
                     fontSize: 18,
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

  void _submitUpdateNote()
  {
    BlocProvider.of<NoteCubit>(context).updateNote(note:NoteEntity(
      note:_noteTextController!.text,
      noteId: widget.noteEntity.noteId,
      time: Timestamp.now(),
      uid:widget.noteEntity.uid,
    ),);

    Future.delayed(Duration(seconds: 1),(){
      Navigator.pop(context);
    });
  }
}
