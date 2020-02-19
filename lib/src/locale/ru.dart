import 'dart:io';

import 'package:eyehelper/app_id.dart';

enum LocaleId {
  statistic,
  excercises,
  notifications,

  vertical_movements,
  horizontal_movements,
  screw_up_movements,
  blinking_movements,
  focus_movements,
  palming_movements,

  turn_eyes_up_down,
  turn_eyes_left_right,
  screw_up_your_eyes,
  focus_for_10_sec,
  blink_fast_20_times,
  rub_hands_and_attach_to_eyes,

  retry_three_times,
  retry_one_time,
  retry_twenty_five_time,

  begin_btn_txt,
  continue_btn_txt,

  // texts for training
  watch_up,
  watch_down,
  watch_left,
  watch_right,
  screw_up,
  relax_eyes,
  fast_blink,
  watch_far,
  watch_near,
  rub_hands,
  apply_to_eyes,

  // texts for notifications
  notifications_on,
  choose_time,
  apply_to_all,
  exercise_frequency,
  times_per,
  hour,
  minute,
  save,
  we_will_notify,
  change,

  // texts for schedule and statistics
  monday_short,
  tuesday_short,
  wednesday_short,
  thursday_short,
  friday_short,
  saturday_short,
  sunday_short,

  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,

  week_short,
  excercise_short,

  times,
  working_time,
  weekend,

  // texts for statistics
  exercise_frequency_per_day,
  exercise_per_month,
  responses_on_push,
  current_week,
  current_day,
  current_month,

  //texts for finish
  good_job,
  you_done_excercises,
  set_mark,
  continue_btn_text,
  want_to_set_mark,
  there_is_app,
  value,
  not_now,
  not_enough_data,

  // texts for notification frequency
  zero_hours,
  one_hour,
  two_hours,
  few_hours,
  many_hours,
  from,
  to,

  // texts for exercise reminder notification
  notification_reminder_exercise_title,
  notification_reminder_excercise_body,

  // other
  ok,
}

Map<LocaleId, String> localeRu = {
  LocaleId.statistic: "Статистика",
  LocaleId.excercises: "Упражнения",
  LocaleId.notifications: "Уведомления",

  LocaleId.vertical_movements: "1. Вертикальные движения",
  LocaleId.horizontal_movements: "2. Горизонтальные движения",
  LocaleId.screw_up_movements: "3. Зажмуривания",
  LocaleId.blinking_movements: "4. Моргание",
  LocaleId.focus_movements: "5. Фокусировка",
  LocaleId.palming_movements: "6. Пальминг",

  LocaleId.turn_eyes_up_down: "Поводите глазами снизу вверх и наоборот.",
  LocaleId.turn_eyes_left_right: "Поводите глазами слева направо и наоборот.",
  LocaleId.screw_up_your_eyes: "Крепко зажмрурьте глаза на 10 секунд, не открывая глаза расслабьте мышцы на 10 секунд",
  LocaleId.focus_for_10_sec: "Сфокусируйтесь сначала на ближнем предмете (10 сек), потом на дальнем (10 сек).",
  LocaleId.blink_fast_20_times: "Быстро поморгайте",
  LocaleId.rub_hands_and_attach_to_eyes:
      "Потрите руки друг о друга до появления тепла. Приложите руки к глазам на 15 секунд (не давить). Подумайте о своей мечте.",

  LocaleId.retry_three_times: "Повторить: 3 раза.",
  LocaleId.retry_one_time: "Повторить: 1 раз.",
  LocaleId.retry_twenty_five_time: "Повторить: 25 раз.",

  LocaleId.begin_btn_txt: "Начать",
  LocaleId.continue_btn_txt: "Продолжить",

  // texts for training
  LocaleId.watch_up: "Смотрите\n вверх",
  LocaleId.watch_down: "Смотрите\n вниз",
  LocaleId.watch_left: "Смотрите\n влево",
  LocaleId.watch_right: "Смотрите\n вправо",
  LocaleId.screw_up: "Зажмурьте глаза",
  LocaleId.relax_eyes: "Расслабьте глаза",
  LocaleId.fast_blink: "Быстро моргайте",
  LocaleId.watch_far: "Смотрите вдаль",
  LocaleId.watch_near: "Смотрите на телефон",
  LocaleId.rub_hands: "Разогрейте руки",
  LocaleId.apply_to_eyes: "Приложите руки к глазам",

  // texts for notifications
  LocaleId.notifications_on: "Напоминания включены",
  LocaleId.choose_time:
      "Выберите время, в которое вы находитесь за компьютером, приложение будет напоминать вам делать упражнения.",
  LocaleId.apply_to_all: "Применить ко всем",
  LocaleId.exercise_frequency: "Как часто вы хотите, чтобы приложение напоминало вам сделать упражнения?",
  LocaleId.times_per: "Раз в",
  LocaleId.hour: "ч",
  LocaleId.minute: "мин",
  LocaleId.save: "Сохранить",
  LocaleId.we_will_notify: "Мы будем напоминать вам делать упражнения",
  LocaleId.change: "Изменить",

  // texts for schedule and statistics
  LocaleId.monday_short: "Пн",
  LocaleId.tuesday_short: "Вт",
  LocaleId.wednesday_short: "Ср",
  LocaleId.thursday_short: "Чт",
  LocaleId.friday_short: "Пт",
  LocaleId.saturday_short: "Сб",
  LocaleId.sunday_short: "Вс",

  LocaleId.monday: "Понедельник",
  LocaleId.tuesday: "Вторник",
  LocaleId.wednesday: "Среда",
  LocaleId.thursday: "Четверг",
  LocaleId.friday: "Пятница",
  LocaleId.saturday: "Суббота",
  LocaleId.sunday: "Воскресенье",

  LocaleId.week_short: "Нед",
  LocaleId.excercise_short: "Упр",

  LocaleId.times: "Раз",
  LocaleId.working_time: "Рабочее время",
  LocaleId.weekend: "Выходной день",

  // texts for statistics
  LocaleId.exercise_frequency_per_day: "Частота выполнения упражнений в течении дня",
  LocaleId.exercise_per_month: "Упражнений за этот месяц",
  LocaleId.responses_on_push: "Откликов на уведомления",
  LocaleId.current_week: "Текущая неделя",
  LocaleId.current_day: "Текущий день",
  LocaleId.current_month: "Текущий месяц",

  // texts for finish
  LocaleId.good_job: "Отлично!",
  LocaleId.you_done_excercises: "Вы выполнили упражнения. Повторяйте чаще и ваши глаза скажут вам спасибо!",
  LocaleId.set_mark: "Оценить приложение",
  LocaleId.continue_btn_text: "Продолжить",
  LocaleId.want_to_set_mark: "Желаете оценить нас в ${Platform.isAndroid ? 'Google Play' : 'App Store'}?",
  LocaleId.there_is_app: "'Есть крутое приложение для тренировки глаз. Советую скачать! ${getAppUrl()}'",
  LocaleId.value: "Оценить",
  LocaleId.not_now: "Не сейчас",

  LocaleId.not_enough_data: "Недостаточно данных для отображения",

  // texts for notification frequency
  LocaleId.zero_hours: "часов",
  LocaleId.one_hour: "час",
  LocaleId.two_hours: "часа",
  LocaleId.few_hours: "часов",
  LocaleId.many_hours: "часов",
  LocaleId.from: "с",
  LocaleId.to: "по",

  // texts for exercise reminder notification
  LocaleId.notification_reminder_exercise_title: "Напоминание",
  LocaleId.notification_reminder_excercise_body: "Пора делать зарядку!",

  // others
  LocaleId.ok: 'Ок',
};
