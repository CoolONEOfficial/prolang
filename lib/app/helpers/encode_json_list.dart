
List<Map<String, dynamic>> encodeJsonList(List<dynamic> list) {
  return list.map<Map<String, dynamic>>((section) => section.toJson()).toList();
}