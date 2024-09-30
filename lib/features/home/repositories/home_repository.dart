import 'dart:io';

import 'package:http/http.dart' as http;

class HomeRepository {
  Future<void> uploadSong(File selectedAudio, File selectedImage) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://10.0.2.2:8000/song/upload'),
    );
    request
      ..files.addAll(
        [
          await http.MultipartFile.fromPath('song', selectedAudio.path),
          await http.MultipartFile.fromPath('thumbnail', selectedImage.path),
        ],
      )
      ..fields.addAll(
        {'artist': 'Glass Animals', 'song_name': 'Enemy', 'hex_code': 'FFFFFF'},
      )
      ..headers.addAll(
        {
          'x-auth-token':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEwYWIyN2VhLWVjYTYtNDBmMS04ZTkxLWZlMjJjYWU0YTk2YSJ9.1ihd9DWb7TH0vZEalaI6-QF_ubeOgB48ZUd81lWWIGs'
        },
      );

    final res = await request.send();
    print(res);
  }
}
