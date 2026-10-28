class Item {
  const Item({required this.id, required this.title, required this.subtitle, required this.image, this.tags=const [], this.price='가격 문의', this.kind='market', this.status='판매 중', this.location='연세대학교 근처'});
  final int id; final String title; final String subtitle; final String image; final List<String> tags;
  final String price; final String kind; final String status; final String location;
  static Item? fromJson(Object? json) => switch(json) {
    {'id': int id, 'title': String title, 'subtitle': String subtitle, 'image': String image} => Item(
      id:id,title:title,subtitle:subtitle,image:image,
      tags: switch(json['tags']) { List<Object?> t => t.whereType<String>().toList(), _ => const [] },
      price: json['price'] is String ? json['price'] as String : '가격 문의',
      kind: json['kind'] is String ? json['kind'] as String : 'market',
      status: json['status'] is String ? json['status'] as String : '판매 중',
      location: json['location'] is String ? json['location'] as String : '연세대학교 근처',
    ), _ => null,
  };
}
class Note {
  const Note({required this.id,required this.itemId,required this.text,required this.date});
  final int id; final int itemId; final String text; final String date;
  static Note? fromJson(Object? json) => switch(json) { {'id':int id,'itemId':int itemId,'text':String text,'date':String date} => Note(id:id,itemId:itemId,text:text,date:date), _=>null };
}
