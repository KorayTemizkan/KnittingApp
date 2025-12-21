import 'package:url_launcher/url_launcher.dart';

Future<void> openYoutubeVideo(String videoId) async {
  final Uri appUrl = Uri.parse('vnd.youtube:$videoId');
  final Uri webUrl = Uri.parse('https://www.youtube.com/watch?v=$videoId');

  if (await canLaunchUrl(appUrl)) {
    await launchUrl(appUrl);
  } else {
    await launchUrl(webUrl, mode: LaunchMode.externalApplication);
  }
}
