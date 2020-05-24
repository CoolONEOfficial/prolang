import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:prolang/app/models/phrase.dart';

import 'phrase_entry.dart';

class PhraseList extends StatefulWidget {
  final CollectionReference lessonRef;

  const PhraseList({Key key, this.lessonRef}) : super(key: key);

  @override
  _PhraseListState createState() => _PhraseListState();
}

class _PhraseListState extends State<PhraseList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.lessonRef.snapshots(),
      builder: (context, snapshot) => PaginateFirestore(
        key: Key(snapshot.data.documents.length.toString()),
        separator: SizedBox(height: 16.0),
        itemBuilder: (context, documentSnapshot) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: PhraseEntry(Phrase.fromSnapshot(documentSnapshot)),
        ),
        query: widget.lessonRef.orderBy('index'),
      ),
    );
  }
}
