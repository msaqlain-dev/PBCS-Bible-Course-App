import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart' as audio;

import 'course_03_data.dart';

class Course03 extends StatefulWidget {
  Course03({Key? key}) : super(key: key);

  @override
  _Course03State createState() => _Course03State();
}

class _Course03State extends State<Course03> {
  late final audio.AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  final _auth = FirebaseAuth.instance;
  final _database = FirebaseDatabase.instance;
  final _storage = FirebaseStorage.instance;

  final _audioRef =
      FirebaseStorage.instance.ref().child('audio/1.2 taruf paragraph.mp3');
  final _dbRef = FirebaseDatabase.instance.ref('/Course_01');

  @override
  void initState() {
    super.initState();
    _audioPlayer = audio.AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playAudioFromFirebase() async {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _audioPlayer.play();
      } else {
        _audioPlayer.pause();
      }
    });

    try {
      final audioUrl = await _audioRef.getDownloadURL();
      await _audioPlayer.setUrl(audioUrl);
      _audioPlayer.play();
      setState(() {
        _isPlaying = true;
      });
    } catch (error) {
      print('Failed to play audio: $error');
      Fluttertoast.showToast(
        msg: 'Failed to play audio: $error',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _audioPlayer.play();
      } else {
        _audioPlayer.pause();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Course_03_data(),
            ),
          );
        },
        child: const Text(
          'اقوامِ عالم کے لئے اِلٰہی برکت',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ),
      ),
    );
  }
}
