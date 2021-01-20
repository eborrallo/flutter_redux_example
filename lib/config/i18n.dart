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
        "es_es": "Exp. desde ",
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
      } +
      {
        "en_us": "save",
        "es_es": "guardar",
      } +
      {
        "en_us": "Add Task",
        "es_es": "Añadir tarea",
      } +
      {
        "en_us": "Add Subject",
        "es_es": "Añadir asignatura",
      } +
      {
        "en_us": "title",
        "es_es": "título",
      } +
      {
        "en_us": "description",
        "es_es": "descripción",
      } +
      {
        "en_us": "Write some ",
        "es_es": "Escribe algun"
            .modifier(Gender.male, "Escribe algun ")
            .modifier(Gender.female, "Escribe alguna "),
      } +
      {
        "en_us": "Please enter some",
        "es_es": "Porfavor escribe"
            .modifier(Gender.male, "Porfavor escribe el ")
            .modifier(Gender.female, "Porfavor escribe la "),
      } +
      {
        "en_us": "Please select a %s.",
        "es_es": "Porfavor selecciona una %s.",
      } +
      {
        "en_us": 'subject',
        "es_es": "asignatura",
      } +
      {
        "en_us": 'attachment',
        "es_es": "adjunto",
      } +
      {
        "en_us": 'time',
        "es_es": "tiempo",
      } +
      {
        "en_us": 'date',
        "es_es": "fecha",
      } +
      {
        "en_us": 'from',
        "es_es": "desde",
      } +
      {
        "en_us": 'to',
        "es_es": "hasta",
      } +
      {
        "en_us": 'Total',
        "es_es": "Totales",
      } +
      {
        "en_us": 'Total Task',
        "es_es": "Tareas totales",
      } +
      {
        "en_us": 'tasks',
        "es_es": "tareas",
      } +
      {
        "en_us": 'Insight',
        "es_es": "Consejo",
      } +
      {
        "en_us": 'Weekly',
        "es_es": "Semanales",
      } +
      {
        "en_us": 'Completation Rate',
        "es_es": "Porcentaje completado",
      } +
      {
        "en_us":
            'You can raise your completation rate by finish your task ontime',
        "es_es":
            "Puedes aumentar tu ratio de porcentaje completado si completas tus tarea a tiempo",
      } +
      {"en_us": 'analytics', "es_es": 'estadísticas'} +
      {
        "en_us": 'Date & Time',
        "es_es": 'Fecha & Hora',
      };

  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(int value) => localizePlural(value, this, _t);

  String version(Object modifier) => localizeVersion(modifier, this, _t);

  Map<String, String> allVersions() => localizeAllVersions(this, _t);
  String gender(Gender gnd) => localizeVersion(gnd, this, _t);

  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach =>
      this.split(" ").map((String str) => str.toUpperCase()).join(" ");
}

enum Gender { they, female, male }
