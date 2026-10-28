import 'package:flutter/material.dart';
import '../api.dart';
import '../models.dart';
import '../widgets.dart';
import 'b_detail_screen.dart';

const wideBreakpoint = 600.0;
class ListScreen extends StatefulWidget {
 const ListScreen({super.key,this.load=fetchItems,this.loadNotes=fetchNotes});
 final ItemsLoader load; final NotesLoader loadNotes;
 @override State<ListScreen> createState()=>_ListScreenState();
}
class _ListScreenState extends State<ListScreen> {
 late Future<List<Item>> _future=widget.load();
 int _tab=0; String _query=''; String _category='전체';
 void _retry(){setState((){_future=widget.load();});}
 void _open(Item item)=>Navigator.of(context).push(MaterialPageRoute<void>(builder:(_)=>DetailScreen(item:item,loadNotes:widget.loadNotes)));
 String get _kind=>['market','wanted','auction'][_tab];
 @override Widget build(BuildContext context)=>Scaffold(
 
  appBar: AppBar(
    title: Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: const Color(0xFFFF6F0F),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.swap_horiz, color: Colors.white),
        ),
        const SizedBox(width: 9),
        const Text(
          'Karrot-v2',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('알림 예시 화면입니다.')),
            );
          },
          icon: const Icon(Icons.notifications_none),
        ),
      ],
    ),
  ),

  body:Column(children:[
   Padding(padding:const EdgeInsets.fromLTRB(16,4,16,10),child:TextField(decoration:InputDecoration(hintText:'학교 근처 상품 검색',prefixIcon:const Icon(Icons.search),filled:true,fillColor:Colors.white,border:OutlineInputBorder(borderRadius:BorderRadius.circular(14),borderSide:BorderSide.none),contentPadding:EdgeInsets.zero),onChanged:(v)=>setState(()=>_query=v))),
   SizedBox(height:42,child:ListView(scrollDirection:Axis.horizontal,padding:const EdgeInsets.symmetric(horizontal:12),children:[for(final c in ['전체','디지털기기','생활용품','도서','의류']) Padding(padding:const EdgeInsets.symmetric(horizontal:4),child:ChoiceChip(label:Text(c),selected:_category==c,onSelected:(_)=>setState(()=>_category=c)))])),
   Expanded(child:FutureBuilder<List<Item>>(future:_future,builder:(context,snap){if(snap.connectionState!=ConnectionState.done)return const LoadingView(label:'상품을 불러오는 중…');if(snap.hasError)return ErrorView(title:'상품을 불러오지 못했습니다.',message:'${snap.error}',onRetry:_retry);final all=snap.data??const <Item>[];final items=all.where((e)=>e.kind==_kind&&(e.title+e.subtitle+e.location+e.tags.join(' ')).toLowerCase().contains(_query.toLowerCase())&&(_category=='전체'||e.tags.contains(_category))).toList();if(items.isEmpty)return EmptyView(message:_tab==1?'아직 구해요 게시글이 없습니다.':'조건에 맞는 상품이 없습니다.');return LayoutBuilder(builder:(context,box){if(box.maxWidth>=wideBreakpoint)return GridView.builder(padding:const EdgeInsets.all(12),gridDelegate:const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent:320,mainAxisExtent:295,crossAxisSpacing:12,mainAxisSpacing:12),itemCount:items.length,itemBuilder:(context,i)=>_productCard(items[i],vertical:true));return ListView.builder(padding:const EdgeInsets.only(bottom:12),itemCount:items.length,itemBuilder:(context,i)=>_productCard(items[i]));});})),
  ]),
  floatingActionButton:FloatingActionButton.extended(backgroundColor:const Color(0xFFFF6F0F),foregroundColor:Colors.white,onPressed:()=>_showPostingGuide(context),icon:const Icon(Icons.add),label:Text(_tab==1?'구해요 작성':_tab==2?'경매 등록':'글쓰기')),
  bottomNavigationBar:NavigationBar(selectedIndex:_tab,onDestinationSelected:(i)=>setState(()=>_tab=i),destinations:const [NavigationDestination(icon:Icon(Icons.storefront_outlined),selectedIcon:Icon(Icons.storefront),label:'중고거래'),NavigationDestination(icon:Icon(Icons.search),label:'구해요'),NavigationDestination(icon:Icon(Icons.gavel),label:'경매')]),
 );
 Widget _productCard(Item item,{bool vertical=false})=>Card(margin:vertical?EdgeInsets.zero:const EdgeInsets.symmetric(horizontal:14,vertical:6),clipBehavior:Clip.antiAlias,elevation:0,color:Colors.white,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(16),side:const BorderSide(color:Color(0xFFEFEFEF))),child:InkWell(onTap:()=>_open(item),child:vertical?Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[Expanded(child:NetImage(item.image)),Padding(padding:const EdgeInsets.all(12),child:_cardInfo(item))]):Padding(padding:const EdgeInsets.all(10),child:Row(children:[ClipRRect(borderRadius:BorderRadius.circular(12),child:NetImage(item.image,width:104,height:104)),const SizedBox(width:12),Expanded(child:_cardInfo(item)),const Icon(Icons.chevron_right,color:Colors.black38)]))));
 Widget _cardInfo(Item item)=>Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisAlignment:MainAxisAlignment.center,children:[Text(item.title,style:const TextStyle(fontWeight:FontWeight.w700,fontSize:15),maxLines:1,overflow:TextOverflow.ellipsis),const SizedBox(height:5),Text(item.subtitle,style:const TextStyle(color:Colors.black54,fontSize:12),maxLines:2,overflow:TextOverflow.ellipsis),const SizedBox(height:7),Text(item.price,style:const TextStyle(fontWeight:FontWeight.w800,fontSize:15)),const SizedBox(height:4),Row(children:[const Icon(Icons.place_outlined,size:13,color:Colors.black45),Expanded(child:Text(item.location,style:const TextStyle(fontSize:11,color:Colors.black54),maxLines:1,overflow:TextOverflow.ellipsis))]),const SizedBox(height:5),Wrap(spacing:4,children:[for(final tag in item.tags.take(2))Container(padding:const EdgeInsets.symmetric(horizontal:7,vertical:3),decoration:BoxDecoration(color:const Color(0xFFFFF1E7),borderRadius:BorderRadius.circular(6)),child:Text(tag,style:const TextStyle(fontSize:10,color:Color(0xFFB84D00))))])]);
 void _showPostingGuide(BuildContext context)=>showModalBottomSheet<void>(context:context,showDragHandle:true,builder:(ctx)=>Padding(padding:const EdgeInsets.all(22),child:Column(mainAxisSize:MainAxisSize.min,crossAxisAlignment:CrossAxisAlignment.start,children:[Text(_tab==1?'구해요 게시글 작성':_tab==2?'경매 상품 등록':'중고 상품 등록',style:Theme.of(ctx).textTheme.titleLarge),const SizedBox(height:8),const Text('현재 과제 범위에서는 화면 예시만 제공합니다. 게시글 등록이나 데이터 저장은 실제로 수행하지 않습니다.'),const SizedBox(height:16),FilledButton(onPressed:()=>Navigator.pop(ctx),child:const Text('확인'))])));
}
