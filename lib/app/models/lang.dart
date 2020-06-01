import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:prolang/app/helpers/add_doc_id.dart';
import 'package:prolang/app/mixins/index_mixin.dart';

part 'lang.freezed.dart';
part 'lang.g.dart';

@freezed
abstract class Lang with _$Lang, IndexMixin {
  factory Lang({
    final String title,
    final String flag,
    final String color,
    final String documentId,
    final String teacher,
    final String adminId,
    final int avatarBytes,
    final int headerBytes,
    final int index,
  }) = _Lang;

  factory Lang.fromSnapshot(DocumentSnapshot snapshot) =>
      Lang.fromJson(dataWithDocId(snapshot));
  factory Lang.fromJson(Map<String, dynamic> json) => _$LangFromJson(json);
}
