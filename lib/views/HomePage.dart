import 'package:app14/views/post.dart';
import 'package:app14/wp-api.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Blogging'),
        ),
        body: Container(
            child: FutureBuilder(
                future: fetchWpPosts(),
                builder: (contex, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map wppost = snapshot.data[index];
                          return Text(wppost["title"]["rendered"]);
                        });
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                })));
  }
}

class PostTile extends StatefulWidget {
  final String imageApiUrl, title, desc, excerpt;
  PostTile({this.imageApiUrl, this.title, this.desc, this.excerpt});

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (imageUrl != "") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PostPage(
                        title: widget.title,
                        imageUrl: imageUrl,
                        desc: widget.desc,
                      )));
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                future: fetchWpPostImageUrl(widget.imageApiUrl),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    imageUrl = snapshot.data["guid"]["rendered"];
                    return Image.network(imageUrl);
                  }
                  return Center(child: CircularProgressIndicator());
                }),
            SizedBox(height: 8),
            Text(
              widget.title,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(widget.excerpt)
          ],
        ),
      ),
    );
  }
}
