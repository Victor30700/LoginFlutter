/// Endpoints oficiales de la API de BOSSUX (https://vous.bossux.com)
class ApiEndpoints {
  const ApiEndpoints._();

  /// Dominio base del servidor de producción BOSSUX
  static const String baseUrl = 'https://vous.bossux.com';

  /// Endpoint GET para listar todos los planes de gimnasio
  static const String planesUrl = '$baseUrl/apx/lplanes';

  /// Endpoint POST para buscar productos y planes por código o nombre.
  /// Payload: `{ 'nombre': '<termino>' }`
  static const String buscarProductosUrl = '$baseUrl/appv/lproduc';

  /// Resuelve la URL completa de una foto a partir de su ruta relativa
  /// Ej: `_resources/_planes/b0d1f1fd2d6a6477d037ed1bc88475b7.jpg`
  /// Retorna: `https://vous.bossux.com/_resources/_planes/b0d1f1fd2d6a6477d037ed1bc88475b7.jpg`
  static String resolveImageUrl(String? relativePath) {
    if (relativePath == null || relativePath.trim().isEmpty) {
      return '';
    }
    final cleanPath = relativePath.trim().replaceAll(r'\/', '/');
    if (cleanPath.startsWith('http://') || cleanPath.startsWith('https://')) {
      return cleanPath;
    }
    if (cleanPath.startsWith('/')) {
      return '$baseUrl$cleanPath';
    }
    return '$baseUrl/$cleanPath';
  }
}
