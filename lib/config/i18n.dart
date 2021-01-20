import 'package:i18n_extension/i18n_extension.dart';

// For more info, see: https://pub.dartlang.org/packages/i18n_extension

extension Localization on String {
  //
  static var _t = Translations("en_us") +
      {
        "en_us": "Home",
        "es_es": "Inicio",
      } +
      {
        "en_us": "Work",
        "es_es": "Tranajo",
      } +
      {
        "en_us": "Calendar",
        "es_es": "Calendario",
      } +
      {
        "en_us": "Timeline",
        "es_es": "Horario",
      } +
      {
        "en_us": "On progress",
        "es_es": "En progresso",
      } +
      {
        "en_us": "Expired from ",
        "es_es": "Exp. desde",
      } +
      {
        "en_us": "Today Class",
        "es_es": "Classes de hoy",
      } +
      {
        "en_us": "Nexts almost Due",
        "es_es": "Casi acabadas",
      } +
      {
        "en_us": "Show all",
        "es_es": "Mostrar todo",
      } +
      {
        "en_us": "Hidde old",
        "es_es": "Ocultar antiguos",
      } +
      {
        "en_us": "Oldest",
        "es_es": "Anteriories",
      } +
      {
        "en_us": "Show old",
        "es_es": "Mostrar antiguos",
      } +
      {
        "en_us": "Today",
        "es_es": "Hoy",
      } +
      {
        "en_us": "Upcomming",
        "es_es": "Proximas",
      } +
      {
        "en_us": "Your task",
        "es_es": "Tu tarea",
      } +
      {
        "en_us": "Tomorrow",
        "es_es": "Mañana",
      } +
      {
        "en_us": "done",
        "es_es": "listo",
      } +
      {
        "en_us": "pending",
        "es_es": "pendiente",
      } +
      {
        "en_us": "Due Time",
        "es_es": "Hora",
      };

  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(int value) => localizePlural(value, this, _t);

  String version(Object modifier) => localizeVersion(modifier, this, _t);

  Map<String, String> allVersions() => localizeAllVersions(this, _t);
}
