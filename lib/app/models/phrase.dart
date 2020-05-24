import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:prolang/app/helpers/add_doc_id.dart';
import 'package:prolang/app/mixins/index_mixin.dart';

part 'phrase.freezed.dart';
part 'phrase.g.dart';

@freezed
abstract class Phrase with _$Phrase, IndexMixin {
  factory Phrase({
    final String original,
    final String translated,
    final String documentId,
    final int index,
  }) = _Phrase;

  factory Phrase.fromSnapshot(DocumentSnapshot snapshot) => Phrase.fromJson(dataWithDocId(snapshot));
  factory Phrase.fromJson(Map<String, dynamic> json) => _$PhraseFromJson(json);
}
