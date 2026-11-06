import 'package:http/http.dart' as http;
import 'http_client_factory_stub.dart'
    if (dart.library.io) 'http_client_factory_io.dart'
    if (dart.library.js_interop) 'http_client_factory_web.dart';

/// Crea una instancia de [http.Client] adaptada a la plataforma.
/// En plataformas nativas (IO), tolera certificados intermedios de antivirus (Avast, AVG)
/// para el dominio vous.bossux.com.
http.Client createPlatformHttpClient() => getPlatformHttpClient();
