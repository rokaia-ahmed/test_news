import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class NewsPage extends StatelessWidget {

  Future fetchAlbum() async {
    var response =await http.get(Uri.parse('https://newsapi.org/v2/everything?q=tesla&from=2021-08-08&sortBy=publishedAt&apiKey=d8bc302b0f0941e4be8361b807cc45ce'));
    var jsonDecoded = jsonDecode(response.body);
   // print('status from jsonDecoded ${jsonDecoded }');
    return jsonDecoded ;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder(
        future:fetchAlbum() ,
        builder:(context , snapshot){
           if (snapshot.data == null){
            return Center(
            child: CircularProgressIndicator(),
            );
          }else {
            return ListView.separated(
            itemBuilder:(context , index)=>  ListTile(
             leading:Container(
              width:10 ,
              height:10 ,
              child: Image.network(snapshot.data[index]["urlToImage"]) ,
             ) ,

              title: Text('id : ${snapshot.data[index]["id"]}'),
              subtitle: Text('Title : ${snapshot.data[index]["title"]}'),
               ) ,
               separatorBuilder: (context,index)=> Container(
                 width: double.infinity,
                color:Colors.grey ,
                 height: 1.0,
               ),
              itemCount: 15,);
          }
        }

      ) ,
    );
  }

}
