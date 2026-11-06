import 'package:flutter/material.dart';

/// Escala de espaciados, bordes y dimensiones consistentes.
class AppSpacing {
  AppSpacing._();

  // Espaciados atómicos
  static const double xxs = 4.0;
  static const double xs = 8.0;
  static const double sm = 12.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  // Bordes redondeados
  static const double radiusSm = 8.0;
  static const double radiusMd = 14.0;
  static const double radiusLg = 22.0;
  static const double radiusBook = 28.0; // Radio del marco del libro
  static const double radiusPill = 999.0; // Botones píldora estilo Cal AI

  // Border Radii
  static const BorderRadius roundedSm = BorderRadius.all(Radius.circular(radiusSm));
  static const BorderRadius roundedMd = BorderRadius.all(Radius.circular(radiusMd));
  static const BorderRadius roundedLg = BorderRadius.all(Radius.circular(radiusLg));
  static const BorderRadius roundedBook = BorderRadius.all(Radius.circular(radiusBook));
  static const BorderRadius roundedPill = BorderRadius.all(Radius.circular(radiusPill));

  // Dimensiones del formato Libro (Pantallas grandes) y Formulario móvil
  static const double maxBookWidth = 960.0;
  static const double minBookHeight = 620.0;
  static const double maxFormWidth = 440.0;
  static const double breakpointDesktop = 860.0; // Umbral para cambiar a formato libro
}
