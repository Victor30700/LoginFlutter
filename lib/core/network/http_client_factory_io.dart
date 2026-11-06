import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

http.Client getPlatformHttpClient() {
  final ioClient = HttpClient()
    ..badCertificateCallback = (X509Certificate cert, String host, int port) {
      // Tolera certificados de inspección SSL locales (como Avast / AVG Web Shield)
      // para los servidores de BOSSUX.
      if (host.contains('bossux.com')) {
        return true;
      }
      return false;
    };
  return IOClient(ioClient);
}
