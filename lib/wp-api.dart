import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> fetchWpPosts() async {
  var uri = Uri.parse('http://regularcoins.com/index.php/wp-json/wp/v2/posts');
  final response = await http.get(uri, headers: {"Accept": "application/json"});

  var convertDatatoJson = jsonDecode(response.body);

  return convertDatatoJson;
}

fetchWpPostImageUrl(href) async {
  final response =
      await http.get(href, headers: {"Accept": "application/json"});
  var convertDatatoJson = jsonDecode(response.body);
  return convertDatatoJson;
}
