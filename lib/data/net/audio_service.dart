import 'package:audioplayers/audioplayers.dart';
import 'utils/service_route.dart';

class AudioService {
  final AudioPlayer player = AudioPlayer();

  Future<bool> onPlayAudio({String name}) async =>
      await player.play(
        "${RouteService.baseUrl}download/audio/$name",
        isLocal: true,
      ) ==
      1;

  Future<bool> onPlayAudioWithUrl({String audioUrl}) async =>
      await player.play(audioUrl, isLocal: true) == 1;
}
