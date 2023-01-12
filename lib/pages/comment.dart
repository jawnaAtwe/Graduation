import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/pages/fetchdata.dart';
import 'package:untitled/models/usercomment.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
DateTime now = DateTime.now();
String formattedDate = DateFormat.yMMMEd().format(now);

final berlinWallFell = DateTime.utc(1989, 11, 9);
fetchdata fetchn=new fetchdata();
 List<usercomment> filedata = [];
class TestMe extends StatefulWidget {
  @override
  _TestMeState createState() => _TestMeState();
}

class _TestMeState extends State<TestMe> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  void getuser()async{
  filedata = await fetchn.comment();
  commentChild(filedata);
  }

  void insertcomment (String A,String B)async{
    print(B);
    final prefs = await SharedPreferences.getInstance();
    String A1=prefs.get("namename").toString() ;
try {
      http.Response res = await http.get(
          Uri.parse(fetchdata.apiUrl+'insertcomment?name=' +
              A1+'&&message='+A+'&&date='+B),
          headers: {'Content-Type': 'application/json'});

    } catch (e) {
      print("no filld");
    }
getuser();
  }
  // [
  //   {
  //     'name': 'Chuks Okwuenu',
  //     'pic': 'assets/images/user.png',
  //     'message': 'I love to code',
  //     'date': '2021-01-01 12:00:00'
  //   },
  //   {
  //     'name': 'Biggi Man',
  //     'pic': 'https://www.adeleyeayodeji.com/img/IMG_20200522_121756_834_2.jpg',
  //     'message': 'Very cool',
  //     'date': '2021-01-01 12:00:00'
  //   },
  //   {
  //     'name': 'Tunde Martins',
  //     'pic': 'assets/images/user.png',
  //     'message': 'Very cool',
  //     'date': '2021-01-01 12:00:00'
  //   },
  //   {
  //     'name': 'Biggi Man',
  //     'pic': 'https://picsum.photos/300/30',
  //     'message': 'Very cool',
  //     'date': '2021-01-01 12:00:00'
  //   },
  // ];

  Widget commentChild(data) {
    return ListView(
      children: [
       
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                    
                backgroundImage: AssetImage('assets/images/user.png'),
              
                          
                          ),
                ),
              ),
              title: Text(
            data[i].name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(  data[i].message),
              trailing: Text(   data[i].date, style: TextStyle(fontSize: 10)),
            ),
          )
      ],
    );
 }

  @override
  Widget build(BuildContext context) {
    initState(){
      getuser();
    }
     getuser();
    return Scaffold(
      appBar: AppBar(
        
        title: Text("Comment Page"),
        backgroundColor:Color.fromARGB(255, 172, 190, 90),
      ),
      body: Container(
        child: CommentBox(
          userImage: CommentBox.commentImageParser(
              imageURLorPath: "assets/images/user.png"),
          child: commentChild(filedata),
          labelText: 'Write a comment...',
          errorText: 'Comment cannot be blank',
          withBorder: false,
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              print(commentController.text);
              setState(() {
                
                // var value = {
                //   'name': 'New User',
                //   'pic':
                //       'assets/images/user.png',
                //   'message': commentController.text,
                //   'date': '2021-01-01 12:00:00'
                // };
                // filedata.insert(0, value);

               insertcomment(commentController.text,formattedDate);

                getuser();
                 commentChild(filedata);
              });
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Color.fromARGB(255, 172, 190, 90),
          textColor: Colors.white,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
        ),
      ),
    );
  }
}