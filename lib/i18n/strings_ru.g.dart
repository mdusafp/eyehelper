///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsRu extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsRu({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ru,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ru>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsRu _root = this; // ignore: unused_field

	@override 
	TranslationsRu $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsRu(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$common$ru common = _Translations$common$ru._(_root);
	@override late final _Translations$exercises$ru exercises = _Translations$exercises$ru._(_root);
	@override late final _Translations$training$ru training = _Translations$training$ru._(_root);
	@override late final _Translations$notifications$ru notifications = _Translations$notifications$ru._(_root);
	@override late final _Translations$frequency$ru frequency = _Translations$frequency$ru._(_root);
	@override late final _Translations$schedule$ru schedule = _Translations$schedule$ru._(_root);
	@override late final _Translations$statistics$ru statistics = _Translations$statistics$ru._(_root);
	@override late final _Translations$finish$ru finish = _Translations$finish$ru._(_root);
	@override late final _Translations$onboarding$ru onboarding = _Translations$onboarding$ru._(_root);
	@override late final _Translations$about$ru about = _Translations$about$ru._(_root);
	@override late final _Translations$learnMore$ru learnMore = _Translations$learnMore$ru._(_root);
	@override late final _Translations$permissions$ru permissions = _Translations$permissions$ru._(_root);
	@override late final _Translations$ads$ru ads = _Translations$ads$ru._(_root);
	@override late final _Translations$errors$ru errors = _Translations$errors$ru._(_root);
}

// Path: common
class _Translations$common$ru extends Translations$common$en {
	_Translations$common$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get statistics => 'Статистика';
	@override String get exercises => 'Упражнения';
	@override String get notifications => 'Уведомления';
	@override String get ok => 'Ок';
	@override String get close => 'Закрыть';
	@override String get cancel => 'Отмена';
	@override String get add => 'Добавить';
	@override String get delete => 'Удалить';
	@override String get save => 'Сохранить';
	@override String get change => 'Изменить';
	@override String get continueButton => 'Продолжить';
}

// Path: exercises
class _Translations$exercises$ru extends Translations$exercises$en {
	_Translations$exercises$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get verticalMovements => 'Вертикальные движения';
	@override String get horizontalMovements => 'Горизонтальные движения';
	@override String get screwUpMovements => 'Зажмуривания';
	@override String get blinkingMovements => 'Моргание';
	@override String get focusMovements => 'Фокусировка';
	@override String get palmingMovements => 'Пальминг';
	@override String get turnEyesUpDown => 'Поводите глазами снизу вверх и наоборот.';
	@override String get turnEyesLeftRight => 'Поводите глазами слева направо и наоборот.';
	@override String get screwUpYourEyes => 'Крепко зажмурьте глаза на 10 секунд, не открывая глаза расслабьте мышцы на 10 секунд';
	@override String get focusFor10Sec => 'Сфокусируйтесь сначала на ближнем предмете (10 сек), потом на дальнем (10 сек).';
	@override String get blinkFast => 'Быстро поморгайте';
	@override String get rubHandsAndAttach => 'Потрите руки друг о друга до появления тепла. Приложите руки к глазам на 15 секунд (не давить). Подумайте о своей мечте.';
	@override String reps({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ru'))(n,
		one: '${n} повтор',
		few: '${n} повтора',
		many: '${n} повторов',
		other: '${n} повторов',
	);
	@override String repsOf({required Object done, required Object total}) => '${done} из ${total}';
	@override String get beginButton => 'Начать';
}

// Path: training
class _Translations$training$ru extends Translations$training$en {
	_Translations$training$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get watchUp => 'Смотрите\n вверх';
	@override String get watchDown => 'Смотрите\n вниз';
	@override String get watchLeft => 'Смотрите\n влево';
	@override String get watchRight => 'Смотрите\n вправо';
	@override String get screwUp => 'Зажмурьте глаза';
	@override String get relaxEyes => 'Расслабьте глаза';
	@override String get fastBlink => 'Быстро моргайте';
	@override String get watchFar => 'Смотрите вдаль';
	@override String get watchNear => 'Смотрите на телефон';
	@override String get rubHands => 'Разогрейте руки';
	@override String get applyToEyes => 'Приложите руки к глазам';
	@override String get getReady => 'Приготовьтесь';
}

// Path: notifications
class _Translations$notifications$ru extends Translations$notifications$en {
	_Translations$notifications$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get chooseWorkInterval => 'Выберите интервал, в который вы находитесь на работе';
	@override String get enableButton => 'Включить Уведомления';
	@override String get addTime => 'Добавить время';
	@override String get setupButton => 'Настроить уведомления';
	@override String get reminderTitle => 'Напоминание';
	@override String get reminderBody => 'Пора делать зарядку!';
	@override String get modeAuto => 'По расписанию';
	@override String get modeManual => 'Своё время';
	@override String get remindersPerDay => 'Напоминаний в день';
	@override String todayIs({required Object day}) => 'Сегодня, ${day}';
	@override String get todayDayOff => 'Сегодня выходной — напоминаний не будет';
	@override String get workingDays => 'Рабочие дни';
	@override String get workingHours => 'Рабочие часы';
	@override String workingHoursFor({required Object day}) => 'Рабочие часы · ${day}';
	@override String get hoursDiffer => 'Есть отличия';
	@override String get hoursVary => 'часы разные';
	@override String get perDaySetup => 'Настроить по дням';
	@override String get collapse => 'Свернуть';
	@override String get noWorkingDays => 'Выберите хотя бы один рабочий день';
	@override String willRemindAt({required Object times}) => 'Напомним в ${times}';
	@override String get applyToAllWorking => 'Применить ко всем рабочим дням';
	@override String get reminder => 'Напоминание';
	@override String get newReminder => 'Новое напоминание';
	@override String get weekdays => 'Будни';
	@override String get everyDay => 'Каждый день';
	@override String get weekendDays => 'Выходные';
	@override String get weekdaysShort => 'будни';
	@override String get everyDayShort => 'каждый день';
	@override String get weekendShort => 'выходные';
	@override String get dayOffShort => 'выходной';
	@override String get enableDay => 'Включить';
	@override String get deleteReminder => 'Удалить напоминание';
	@override String get pickAtLeastOneDay => 'Выберите хотя бы один день';
	@override String get manualHint => 'Нажмите на строку, чтобы изменить время или дни. Смахните влево, чтобы удалить.';
	@override String get offShort => 'Выключены';
	@override String get offTitle => 'Глаза устают незаметно';
	@override String get offText => 'Включите напоминания — приложение подскажет, когда сделать паузу, пока вы за компьютером.';
	@override String summaryPerDay({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ru'))(n,
		one: '${n} напоминание в день',
		few: '${n} напоминания в день',
		many: '${n} напоминаний в день',
		other: '${n} напоминаний в день',
	);
	@override String everyDayExcept({required Object days}) => 'Каждый день, кроме ${days}';
	@override String get daysAnd => 'и';
	@override String get deleteConfirmTitle => 'Удалить напоминание?';
	@override String deleteConfirmText({required Object time, required Object days}) => '${time} · ${days}';
	@override String summaryCustom({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ru'))(n,
		one: '${n} своё время',
		few: '${n} своих времени',
		many: '${n} своих времён',
		other: '${n} своих времён',
	);
	@override String nextToday({required Object time}) => 'следующее сегодня в ${time}';
	@override String nextOn({required Object day, required Object time}) => 'следующее — ${day}, ${time}';
	@override String get noneScheduled => 'напоминаний нет';
}

// Path: frequency
class _Translations$frequency$ru extends Translations$frequency$en {
	_Translations$frequency$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get dayOne => 'день';
}

// Path: schedule
class _Translations$schedule$ru extends Translations$schedule$en {
	_Translations$schedule$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get mondayShort => 'Пн';
	@override String get tuesdayShort => 'Вт';
	@override String get wednesdayShort => 'Ср';
	@override String get thursdayShort => 'Чт';
	@override String get fridayShort => 'Пт';
	@override String get saturdayShort => 'Сб';
	@override String get sundayShort => 'Вс';
	@override String get monday => 'Понедельник';
	@override String get tuesday => 'Вторник';
	@override String get wednesday => 'Среда';
	@override String get thursday => 'Четверг';
	@override String get friday => 'Пятница';
	@override String get saturday => 'Суббота';
	@override String get sunday => 'Воскресенье';
	@override String get weekShort => 'Нед';
	@override String get exerciseShort => 'Упр';
	@override String get times => 'Раз';
	@override String get workingTime => 'Рабочее время';
	@override String get weekend => 'Выходной день';
	@override String get from => 'с';
	@override String get to => 'по';
}

// Path: statistics
class _Translations$statistics$ru extends Translations$statistics$en {
	_Translations$statistics$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get streak => 'Серия';
	@override String daysInARow({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ru'))(n,
		one: 'день подряд',
		few: 'дня подряд',
		many: 'дней подряд',
		other: 'дней подряд',
	);
	@override String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ru'))(n,
		one: '${n} день',
		few: '${n} дня',
		many: '${n} дней',
		other: '${n} дней',
	);
	@override String bestStreak({required Object days}) => 'Лучшая — ${days}';
	@override String get noStreakYet => 'Сделайте полный подход, чтобы начать серию';
	@override String get today => 'Сегодня';
	@override String setsOfPlan({required num n, required Object done}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ru'))(n,
		one: '${done} из ${n} подхода по плану',
		few: '${done} из ${n} подходов по плану',
		many: '${done} из ${n} подходов по плану',
		other: '${done} из ${n} подходов по плану',
	);
	@override String remaining({required Object names, required Object time}) => 'Осталось: ${names} · ${time}';
	@override String get allDone => 'Все шесть сделаны — глаза отдохнули';
	@override String setsAndTime({required num n, required Object time}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ru'))(n,
		one: '${n} подход · ${time}',
		few: '${n} подхода · ${time}',
		many: '${n} подходов · ${time}',
		other: '${n} подходов · ${time}',
	);
	@override String get legendMax => '3+ подхода';
	@override String get thisWeek => 'Эта неделя';
	@override String get minutesForEyes => 'мин для глаз';
	@override String lastWeek({required Object time}) => 'Прошлая — ${time}';
	@override String get hoursShort => 'ч';
	@override String get minutesShort => 'мин';
	@override String get secondsShort => 'с';
}

// Path: finish
class _Translations$finish$ru extends Translations$finish$en {
	_Translations$finish$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get goodJob => 'Отлично!';
	@override String get youDoneExercises => 'Вы выполнили упражнения. Повторяйте чаще и ваши глаза скажут вам спасибо!';
	@override String shareText({required Object url}) => 'Есть крутое приложение для тренировки глаз. Советую скачать! ${url}';
	@override String get likeQuestion => 'Нравится приложение?  ❤️';
	@override String get likeYes => 'Да!';
	@override String get likeNo => 'Не очень';
	@override String get feedbackTitle => 'Что можно улучшить?';
	@override String get feedbackHint => 'Расскажите, что не нравится — это поможет сделать приложение лучше.';
	@override String get feedbackSend => 'Отправить';
	@override String get feedbackSkip => 'Пропустить';
	@override String get share => 'Поделиться приложением';
}

// Path: onboarding
class _Translations$onboarding$ru extends Translations$onboarding$en {
	_Translations$onboarding$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title1 => 'Твоим глазам нужен отдых!';
	@override String get title2 => 'Что за упражнения?';
	@override String get title3 => 'Мы тебе напомним!';
	@override String get subtitle1 => 'Неужели наши глаза не заслужили хоть немного отдыха в течение рабочего дня?\nДавай договоримся каждый день выполнять упражнения';
	@override String get subtitle2 => 'Мы расскажем тебе про упражнения для расслабления твоих глаз и покажем как их делать.\nТы только заглядывай иногда…)';
	@override String get subtitle3 => 'Расскажи в какое время и в какие дни работаешь за компьютером и приложение поможет тебе заботиться о своих глазах';
}

// Path: about
class _Translations$about$ru extends Translations$about$en {
	_Translations$about$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Об упражнениях';
	@override String get body1 => 'В приложении используется информация об упражнениях по системе Аветисова.';
	@override String get body2 => 'Для того чтобы получить подробную информацию, нажмите на кнопку ниже.';
	@override String get warningLabel => 'Внимание! ';
	@override String get disclaimer => 'Перед выполнением упражнений настоятельно рекомендуем вам обратиться к вашему лечащему врачу за консультацией. Разработчики не несут ответственность за любой косвенный, случайный или неумышленный вред, вызванный в связи с использованием приложения.';
	@override String get moreButton => 'Подробнее';
	@override String get gotItButton => 'Понятно';
}

// Path: learnMore
class _Translations$learnMore$ru extends Translations$learnMore$en {
	_Translations$learnMore$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Как работают эти упражнения';
	@override String get intro1 => 'У глаз тоже есть мышцы — те, что двигают взгляд, и крошечные, что переключают фокус с близкого на далёкое. Как любые мышцы, они устают и «затекают», когда часами держат одно положение, — именно это происходит при работе за экраном. Этот комплекс — простая мягкая «зарядка», которая помогает этим мышцам расслабиться, размяться и легче переключать фокус.';
	@override String get intro2 => 'Делайте раз в день около 15 минут, сидя с прямой спиной. Двигайтесь медленно и мягко, начинайте с меньшего числа повторов — лёгкая усталость поначалу нормальна и проходит.';
	@override List<dynamic> get parts => [
		_Translations$learnMore$parts$0$ru._(_root),
		_Translations$learnMore$parts$1$ru._(_root),
		_Translations$learnMore$parts$2$ru._(_root),
	];
	@override String get tips => 'Что помогает ещё сильнее: хорошее освещение, регулярные перерывы от экрана, время на улице и частый отдых для глаз.';
	@override String get warningLabel => 'Важно: ';
	@override String get disclaimer => 'Эти упражнения предназначены для общего оздоровления и расслабления. Это не лечение; они не предназначены для диагностики, лечения или профилактики каких-либо заболеваний. Перед началом проконсультируйтесь с врачом или офтальмологом, особенно при наличии заболеваний глаз. Вы используете приложение на своё усмотрение.';
}

// Path: permissions
class _Translations$permissions$ru extends Translations$permissions$en {
	_Translations$permissions$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get noPermissionTitle => 'Нет разрешения';
	@override String get noPermissionSubtitle => 'Мы не получили разрешение на отправку уведомлений, поэтому не можем настроить их сейчас. Вы можете настроить разрешения в настройках вашего устройства.';
	@override String get openSettings => 'Открыть настройки';
}

// Path: ads
class _Translations$ads$ru extends Translations$ads$en {
	_Translations$ads$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get introTitle => 'Eye Helper остаётся бесплатным';
	@override String get introSubtitle => 'Чтобы приложение оставалось бесплатным для всех, на некоторых экранах появится небольшой баннер. Упражнения и статистика останутся прежними.';
	@override String get introButton => 'Понятно';
}

// Path: errors
class _Translations$errors$ru extends Translations$errors$en {
	_Translations$errors$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get wrongWorkTime => 'Выбран неверный промежуток времени';
}

// Path: learnMore.parts.0
class _Translations$learnMore$parts$0$ru extends Translations$learnMore$parts$0$en {
	_Translations$learnMore$parts$0$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Часть 1 — Разминка и расслабление';
	@override String get subtitle => 'Улучшает кровообращение вокруг глаз и снимает напряжение.';
	@override List<dynamic> get exercises => [
		_Translations$learnMore$parts$0$exercises$0$ru._(_root),
		_Translations$learnMore$parts$0$exercises$1$ru._(_root),
		_Translations$learnMore$parts$0$exercises$2$ru._(_root),
		_Translations$learnMore$parts$0$exercises$3$ru._(_root),
		_Translations$learnMore$parts$0$exercises$4$ru._(_root),
	];
}

// Path: learnMore.parts.1
class _Translations$learnMore$parts$1$ru extends Translations$learnMore$parts$1$en {
	_Translations$learnMore$parts$1$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Часть 2 — Движение взгляда';
	@override String get subtitle => 'Разминает мышцы, которые наводят глаза. Держите голову неподвижно, двигаются только глаза.';
	@override List<dynamic> get exercises => [
		_Translations$learnMore$parts$1$exercises$0$ru._(_root),
		_Translations$learnMore$parts$1$exercises$1$ru._(_root),
		_Translations$learnMore$parts$1$exercises$2$ru._(_root),
		_Translations$learnMore$parts$1$exercises$3$ru._(_root),
	];
}

// Path: learnMore.parts.2
class _Translations$learnMore$parts$2$ru extends Translations$learnMore$parts$2$en {
	_Translations$learnMore$parts$2$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Часть 3 — Фокус вблизи и вдали';
	@override String get subtitle => 'Тренирует фокусирующую мышцу плавно менять расстояние — именно она «залипает» после долгой работы за экраном.';
	@override List<dynamic> get exercises => [
		_Translations$learnMore$parts$2$exercises$0$ru._(_root),
		_Translations$learnMore$parts$2$exercises$1$ru._(_root),
		_Translations$learnMore$parts$2$exercises$2$ru._(_root),
		_Translations$learnMore$parts$2$exercises$3$ru._(_root),
	];
}

// Path: learnMore.parts.0.exercises.0
class _Translations$learnMore$parts$0$exercises$0$ru extends Translations$learnMore$parts$0$exercises$0$en {
	_Translations$learnMore$parts$0$exercises$0$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Массаж век';
	@override String get text => 'Чистыми подушечками пальцев мягко помассируйте закрытые веки около минуты.';
}

// Path: learnMore.parts.0.exercises.1
class _Translations$learnMore$parts$0$exercises$1$ru extends Translations$learnMore$parts$0$exercises$1$en {
	_Translations$learnMore$parts$0$exercises$1$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Мягкое зажмуривание';
	@override String get text => 'Крепко закройте глаза на 3–5 секунд, затем расслабьте на 4–6 секунд. Повторите 6–8 раз.';
}

// Path: learnMore.parts.0.exercises.2
class _Translations$learnMore$parts$0$exercises$2$ru extends Translations$learnMore$parts$0$exercises$2$en {
	_Translations$learnMore$parts$0$exercises$2$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Быстрое моргание';
	@override String get text => 'Моргайте часто 15 секунд, затем отдохните, глядя прямо, 5 секунд. До 6 подходов.';
}

// Path: learnMore.parts.0.exercises.3
class _Translations$learnMore$parts$0$exercises$3$ru extends Translations$learnMore$parts$0$exercises$3$en {
	_Translations$learnMore$parts$0$exercises$3$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Лёгкое нажатие';
	@override String get text => 'С закрытыми глазами мягко положите два пальца на каждое веко на 2–3 секунды, глубоко дыша. Повторите 4–6 раз. Только лёгкое касание.';
}

// Path: learnMore.parts.0.exercises.4
class _Translations$learnMore$parts$0$exercises$4$ru extends Translations$learnMore$parts$0$exercises$4$en {
	_Translations$learnMore$parts$0$exercises$4$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Сопротивление бровям';
	@override String get text => 'Прижмите пальцы к бровям и слегка хмурьтесь и щурьтесь, преодолевая лёгкое сопротивление. До 8 раз.';
}

// Path: learnMore.parts.1.exercises.0
class _Translations$learnMore$parts$1$exercises$0$ru extends Translations$learnMore$parts$1$exercises$0$en {
	_Translations$learnMore$parts$1$exercises$0$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Вверх и вниз';
	@override String get text => 'Медленно посмотрите вверх, пауза, вниз, пауза. 8–12 раз.';
}

// Path: learnMore.parts.1.exercises.1
class _Translations$learnMore$parts$1$exercises$1$ru extends Translations$learnMore$parts$1$exercises$1$en {
	_Translations$learnMore$parts$1$exercises$1$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Из стороны в сторону';
	@override String get text => 'В том же медленном ритме, влево и вправо, насколько комфортно. 8–12 раз.';
}

// Path: learnMore.parts.1.exercises.2
class _Translations$learnMore$parts$1$exercises$2$ru extends Translations$learnMore$parts$1$exercises$2$en {
	_Translations$learnMore$parts$1$exercises$2$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'По диагонали';
	@override String get text => 'Из нижнего-левого в верхний-правый угол, 8 раз; отдых 30 секунд; затем из нижнего-правого в верхний-левый, 8 раз.';
}

// Path: learnMore.parts.1.exercises.3
class _Translations$learnMore$parts$1$exercises$3$ru extends Translations$learnMore$parts$1$exercises$3$en {
	_Translations$learnMore$parts$1$exercises$3$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Круги';
	@override String get text => 'Медленно опишите глазами полный круг, по часовой стрелке 6–8 раз, затем против часовой 6–8 раз.';
}

// Path: learnMore.parts.2.exercises.0
class _Translations$learnMore$parts$2$exercises$0$ru extends Translations$learnMore$parts$2$exercises$0$en {
	_Translations$learnMore$parts$2$exercises$0$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'От близкого к далёкому';
	@override String get text => 'Держите палец примерно в 30 см от лица, сфокусируйтесь на нём, затем переведите фокус на предмет в другом конце комнаты и обратно. 10–12 раз.';
}

// Path: learnMore.parts.2.exercises.1
class _Translations$learnMore$parts$2$exercises$1$ru extends Translations$learnMore$parts$2$exercises$1$en {
	_Translations$learnMore$parts$2$exercises$1$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Приближение';
	@override String get text => 'Не отрывая взгляда от пальца, медленно ведите его к переносице, затем отводите обратно. 10 раз.';
}

// Path: learnMore.parts.2.exercises.2
class _Translations$learnMore$parts$2$exercises$2$ru extends Translations$learnMore$parts$2$exercises$2$en {
	_Translations$learnMore$parts$2$exercises$2$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'По одному глазу';
	@override String get text => 'Закройте один глаз и сделайте переключение фокуса, затем поменяйте. По 8 раз на каждый.';
}

// Path: learnMore.parts.2.exercises.3
class _Translations$learnMore$parts$2$exercises$3$ru extends Translations$learnMore$parts$2$exercises$3$en {
	_Translations$learnMore$parts$2$exercises$3$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Точка на окне';
	@override String get text => 'Поставьте небольшую метку на окне, разглядывайте её 30 секунд, затем посмотрите на далёкий предмет на улице и обратно. 8 раз.';
}

/// The flat map containing all translations for locale <ru>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsRu {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'common.statistics' => 'Статистика',
			'common.exercises' => 'Упражнения',
			'common.notifications' => 'Уведомления',
			'common.ok' => 'Ок',
			'common.close' => 'Закрыть',
			'common.cancel' => 'Отмена',
			'common.add' => 'Добавить',
			'common.delete' => 'Удалить',
			'common.save' => 'Сохранить',
			'common.change' => 'Изменить',
			'common.continueButton' => 'Продолжить',
			'exercises.verticalMovements' => 'Вертикальные движения',
			'exercises.horizontalMovements' => 'Горизонтальные движения',
			'exercises.screwUpMovements' => 'Зажмуривания',
			'exercises.blinkingMovements' => 'Моргание',
			'exercises.focusMovements' => 'Фокусировка',
			'exercises.palmingMovements' => 'Пальминг',
			'exercises.turnEyesUpDown' => 'Поводите глазами снизу вверх и наоборот.',
			'exercises.turnEyesLeftRight' => 'Поводите глазами слева направо и наоборот.',
			'exercises.screwUpYourEyes' => 'Крепко зажмурьте глаза на 10 секунд, не открывая глаза расслабьте мышцы на 10 секунд',
			'exercises.focusFor10Sec' => 'Сфокусируйтесь сначала на ближнем предмете (10 сек), потом на дальнем (10 сек).',
			'exercises.blinkFast' => 'Быстро поморгайте',
			'exercises.rubHandsAndAttach' => 'Потрите руки друг о друга до появления тепла. Приложите руки к глазам на 15 секунд (не давить). Подумайте о своей мечте.',
			'exercises.reps' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ru'))(n, one: '${n} повтор', few: '${n} повтора', many: '${n} повторов', other: '${n} повторов', ), 
			'exercises.repsOf' => ({required Object done, required Object total}) => '${done} из ${total}',
			'exercises.beginButton' => 'Начать',
			'training.watchUp' => 'Смотрите\n вверх',
			'training.watchDown' => 'Смотрите\n вниз',
			'training.watchLeft' => 'Смотрите\n влево',
			'training.watchRight' => 'Смотрите\n вправо',
			'training.screwUp' => 'Зажмурьте глаза',
			'training.relaxEyes' => 'Расслабьте глаза',
			'training.fastBlink' => 'Быстро моргайте',
			'training.watchFar' => 'Смотрите вдаль',
			'training.watchNear' => 'Смотрите на телефон',
			'training.rubHands' => 'Разогрейте руки',
			'training.applyToEyes' => 'Приложите руки к глазам',
			'training.getReady' => 'Приготовьтесь',
			'notifications.chooseWorkInterval' => 'Выберите интервал, в который вы находитесь на работе',
			'notifications.enableButton' => 'Включить Уведомления',
			'notifications.addTime' => 'Добавить время',
			'notifications.setupButton' => 'Настроить уведомления',
			'notifications.reminderTitle' => 'Напоминание',
			'notifications.reminderBody' => 'Пора делать зарядку!',
			'notifications.modeAuto' => 'По расписанию',
			'notifications.modeManual' => 'Своё время',
			'notifications.remindersPerDay' => 'Напоминаний в день',
			'notifications.todayIs' => ({required Object day}) => 'Сегодня, ${day}',
			'notifications.todayDayOff' => 'Сегодня выходной — напоминаний не будет',
			'notifications.workingDays' => 'Рабочие дни',
			'notifications.workingHours' => 'Рабочие часы',
			'notifications.workingHoursFor' => ({required Object day}) => 'Рабочие часы · ${day}',
			'notifications.hoursDiffer' => 'Есть отличия',
			'notifications.hoursVary' => 'часы разные',
			'notifications.perDaySetup' => 'Настроить по дням',
			'notifications.collapse' => 'Свернуть',
			'notifications.noWorkingDays' => 'Выберите хотя бы один рабочий день',
			'notifications.willRemindAt' => ({required Object times}) => 'Напомним в ${times}',
			'notifications.applyToAllWorking' => 'Применить ко всем рабочим дням',
			'notifications.reminder' => 'Напоминание',
			'notifications.newReminder' => 'Новое напоминание',
			'notifications.weekdays' => 'Будни',
			'notifications.everyDay' => 'Каждый день',
			'notifications.weekendDays' => 'Выходные',
			'notifications.weekdaysShort' => 'будни',
			'notifications.everyDayShort' => 'каждый день',
			'notifications.weekendShort' => 'выходные',
			'notifications.dayOffShort' => 'выходной',
			'notifications.enableDay' => 'Включить',
			'notifications.deleteReminder' => 'Удалить напоминание',
			'notifications.pickAtLeastOneDay' => 'Выберите хотя бы один день',
			'notifications.manualHint' => 'Нажмите на строку, чтобы изменить время или дни. Смахните влево, чтобы удалить.',
			'notifications.offShort' => 'Выключены',
			'notifications.offTitle' => 'Глаза устают незаметно',
			'notifications.offText' => 'Включите напоминания — приложение подскажет, когда сделать паузу, пока вы за компьютером.',
			'notifications.summaryPerDay' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ru'))(n, one: '${n} напоминание в день', few: '${n} напоминания в день', many: '${n} напоминаний в день', other: '${n} напоминаний в день', ), 
			'notifications.everyDayExcept' => ({required Object days}) => 'Каждый день, кроме ${days}',
			'notifications.daysAnd' => 'и',
			'notifications.deleteConfirmTitle' => 'Удалить напоминание?',
			'notifications.deleteConfirmText' => ({required Object time, required Object days}) => '${time} · ${days}',
			'notifications.summaryCustom' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ru'))(n, one: '${n} своё время', few: '${n} своих времени', many: '${n} своих времён', other: '${n} своих времён', ), 
			'notifications.nextToday' => ({required Object time}) => 'следующее сегодня в ${time}',
			'notifications.nextOn' => ({required Object day, required Object time}) => 'следующее — ${day}, ${time}',
			'notifications.noneScheduled' => 'напоминаний нет',
			'frequency.dayOne' => 'день',
			'schedule.mondayShort' => 'Пн',
			'schedule.tuesdayShort' => 'Вт',
			'schedule.wednesdayShort' => 'Ср',
			'schedule.thursdayShort' => 'Чт',
			'schedule.fridayShort' => 'Пт',
			'schedule.saturdayShort' => 'Сб',
			'schedule.sundayShort' => 'Вс',
			'schedule.monday' => 'Понедельник',
			'schedule.tuesday' => 'Вторник',
			'schedule.wednesday' => 'Среда',
			'schedule.thursday' => 'Четверг',
			'schedule.friday' => 'Пятница',
			'schedule.saturday' => 'Суббота',
			'schedule.sunday' => 'Воскресенье',
			'schedule.weekShort' => 'Нед',
			'schedule.exerciseShort' => 'Упр',
			'schedule.times' => 'Раз',
			'schedule.workingTime' => 'Рабочее время',
			'schedule.weekend' => 'Выходной день',
			'schedule.from' => 'с',
			'schedule.to' => 'по',
			'statistics.streak' => 'Серия',
			'statistics.daysInARow' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ru'))(n, one: 'день подряд', few: 'дня подряд', many: 'дней подряд', other: 'дней подряд', ), 
			'statistics.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ru'))(n, one: '${n} день', few: '${n} дня', many: '${n} дней', other: '${n} дней', ), 
			'statistics.bestStreak' => ({required Object days}) => 'Лучшая — ${days}',
			'statistics.noStreakYet' => 'Сделайте полный подход, чтобы начать серию',
			'statistics.today' => 'Сегодня',
			'statistics.setsOfPlan' => ({required num n, required Object done}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ru'))(n, one: '${done} из ${n} подхода по плану', few: '${done} из ${n} подходов по плану', many: '${done} из ${n} подходов по плану', other: '${done} из ${n} подходов по плану', ), 
			'statistics.remaining' => ({required Object names, required Object time}) => 'Осталось: ${names} · ${time}',
			'statistics.allDone' => 'Все шесть сделаны — глаза отдохнули',
			'statistics.setsAndTime' => ({required num n, required Object time}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ru'))(n, one: '${n} подход · ${time}', few: '${n} подхода · ${time}', many: '${n} подходов · ${time}', other: '${n} подходов · ${time}', ), 
			'statistics.legendMax' => '3+ подхода',
			'statistics.thisWeek' => 'Эта неделя',
			'statistics.minutesForEyes' => 'мин для глаз',
			'statistics.lastWeek' => ({required Object time}) => 'Прошлая — ${time}',
			'statistics.hoursShort' => 'ч',
			'statistics.minutesShort' => 'мин',
			'statistics.secondsShort' => 'с',
			'finish.goodJob' => 'Отлично!',
			'finish.youDoneExercises' => 'Вы выполнили упражнения. Повторяйте чаще и ваши глаза скажут вам спасибо!',
			'finish.shareText' => ({required Object url}) => 'Есть крутое приложение для тренировки глаз. Советую скачать! ${url}',
			'finish.likeQuestion' => 'Нравится приложение?  ❤️',
			'finish.likeYes' => 'Да!',
			'finish.likeNo' => 'Не очень',
			'finish.feedbackTitle' => 'Что можно улучшить?',
			'finish.feedbackHint' => 'Расскажите, что не нравится — это поможет сделать приложение лучше.',
			'finish.feedbackSend' => 'Отправить',
			'finish.feedbackSkip' => 'Пропустить',
			'finish.share' => 'Поделиться приложением',
			'onboarding.title1' => 'Твоим глазам нужен отдых!',
			'onboarding.title2' => 'Что за упражнения?',
			'onboarding.title3' => 'Мы тебе напомним!',
			'onboarding.subtitle1' => 'Неужели наши глаза не заслужили хоть немного отдыха в течение рабочего дня?\nДавай договоримся каждый день выполнять упражнения',
			'onboarding.subtitle2' => 'Мы расскажем тебе про упражнения для расслабления твоих глаз и покажем как их делать.\nТы только заглядывай иногда…)',
			'onboarding.subtitle3' => 'Расскажи в какое время и в какие дни работаешь за компьютером и приложение поможет тебе заботиться о своих глазах',
			'about.title' => 'Об упражнениях',
			'about.body1' => 'В приложении используется информация об упражнениях по системе Аветисова.',
			'about.body2' => 'Для того чтобы получить подробную информацию, нажмите на кнопку ниже.',
			'about.warningLabel' => 'Внимание! ',
			'about.disclaimer' => 'Перед выполнением упражнений настоятельно рекомендуем вам обратиться к вашему лечащему врачу за консультацией. Разработчики не несут ответственность за любой косвенный, случайный или неумышленный вред, вызванный в связи с использованием приложения.',
			'about.moreButton' => 'Подробнее',
			'about.gotItButton' => 'Понятно',
			'learnMore.title' => 'Как работают эти упражнения',
			'learnMore.intro1' => 'У глаз тоже есть мышцы — те, что двигают взгляд, и крошечные, что переключают фокус с близкого на далёкое. Как любые мышцы, они устают и «затекают», когда часами держат одно положение, — именно это происходит при работе за экраном. Этот комплекс — простая мягкая «зарядка», которая помогает этим мышцам расслабиться, размяться и легче переключать фокус.',
			'learnMore.intro2' => 'Делайте раз в день около 15 минут, сидя с прямой спиной. Двигайтесь медленно и мягко, начинайте с меньшего числа повторов — лёгкая усталость поначалу нормальна и проходит.',
			'learnMore.parts.0.title' => 'Часть 1 — Разминка и расслабление',
			'learnMore.parts.0.subtitle' => 'Улучшает кровообращение вокруг глаз и снимает напряжение.',
			'learnMore.parts.0.exercises.0.name' => 'Массаж век',
			'learnMore.parts.0.exercises.0.text' => 'Чистыми подушечками пальцев мягко помассируйте закрытые веки около минуты.',
			'learnMore.parts.0.exercises.1.name' => 'Мягкое зажмуривание',
			'learnMore.parts.0.exercises.1.text' => 'Крепко закройте глаза на 3–5 секунд, затем расслабьте на 4–6 секунд. Повторите 6–8 раз.',
			'learnMore.parts.0.exercises.2.name' => 'Быстрое моргание',
			'learnMore.parts.0.exercises.2.text' => 'Моргайте часто 15 секунд, затем отдохните, глядя прямо, 5 секунд. До 6 подходов.',
			'learnMore.parts.0.exercises.3.name' => 'Лёгкое нажатие',
			'learnMore.parts.0.exercises.3.text' => 'С закрытыми глазами мягко положите два пальца на каждое веко на 2–3 секунды, глубоко дыша. Повторите 4–6 раз. Только лёгкое касание.',
			'learnMore.parts.0.exercises.4.name' => 'Сопротивление бровям',
			'learnMore.parts.0.exercises.4.text' => 'Прижмите пальцы к бровям и слегка хмурьтесь и щурьтесь, преодолевая лёгкое сопротивление. До 8 раз.',
			'learnMore.parts.1.title' => 'Часть 2 — Движение взгляда',
			'learnMore.parts.1.subtitle' => 'Разминает мышцы, которые наводят глаза. Держите голову неподвижно, двигаются только глаза.',
			'learnMore.parts.1.exercises.0.name' => 'Вверх и вниз',
			'learnMore.parts.1.exercises.0.text' => 'Медленно посмотрите вверх, пауза, вниз, пауза. 8–12 раз.',
			'learnMore.parts.1.exercises.1.name' => 'Из стороны в сторону',
			'learnMore.parts.1.exercises.1.text' => 'В том же медленном ритме, влево и вправо, насколько комфортно. 8–12 раз.',
			'learnMore.parts.1.exercises.2.name' => 'По диагонали',
			'learnMore.parts.1.exercises.2.text' => 'Из нижнего-левого в верхний-правый угол, 8 раз; отдых 30 секунд; затем из нижнего-правого в верхний-левый, 8 раз.',
			'learnMore.parts.1.exercises.3.name' => 'Круги',
			'learnMore.parts.1.exercises.3.text' => 'Медленно опишите глазами полный круг, по часовой стрелке 6–8 раз, затем против часовой 6–8 раз.',
			'learnMore.parts.2.title' => 'Часть 3 — Фокус вблизи и вдали',
			'learnMore.parts.2.subtitle' => 'Тренирует фокусирующую мышцу плавно менять расстояние — именно она «залипает» после долгой работы за экраном.',
			'learnMore.parts.2.exercises.0.name' => 'От близкого к далёкому',
			'learnMore.parts.2.exercises.0.text' => 'Держите палец примерно в 30 см от лица, сфокусируйтесь на нём, затем переведите фокус на предмет в другом конце комнаты и обратно. 10–12 раз.',
			'learnMore.parts.2.exercises.1.name' => 'Приближение',
			'learnMore.parts.2.exercises.1.text' => 'Не отрывая взгляда от пальца, медленно ведите его к переносице, затем отводите обратно. 10 раз.',
			'learnMore.parts.2.exercises.2.name' => 'По одному глазу',
			'learnMore.parts.2.exercises.2.text' => 'Закройте один глаз и сделайте переключение фокуса, затем поменяйте. По 8 раз на каждый.',
			'learnMore.parts.2.exercises.3.name' => 'Точка на окне',
			'learnMore.parts.2.exercises.3.text' => 'Поставьте небольшую метку на окне, разглядывайте её 30 секунд, затем посмотрите на далёкий предмет на улице и обратно. 8 раз.',
			'learnMore.tips' => 'Что помогает ещё сильнее: хорошее освещение, регулярные перерывы от экрана, время на улице и частый отдых для глаз.',
			'learnMore.warningLabel' => 'Важно: ',
			'learnMore.disclaimer' => 'Эти упражнения предназначены для общего оздоровления и расслабления. Это не лечение; они не предназначены для диагностики, лечения или профилактики каких-либо заболеваний. Перед началом проконсультируйтесь с врачом или офтальмологом, особенно при наличии заболеваний глаз. Вы используете приложение на своё усмотрение.',
			'permissions.noPermissionTitle' => 'Нет разрешения',
			'permissions.noPermissionSubtitle' => 'Мы не получили разрешение на отправку уведомлений, поэтому не можем настроить их сейчас. Вы можете настроить разрешения в настройках вашего устройства.',
			'permissions.openSettings' => 'Открыть настройки',
			'ads.introTitle' => 'Eye Helper остаётся бесплатным',
			'ads.introSubtitle' => 'Чтобы приложение оставалось бесплатным для всех, на некоторых экранах появится небольшой баннер. Упражнения и статистика останутся прежними.',
			'ads.introButton' => 'Понятно',
			'errors.wrongWorkTime' => 'Выбран неверный промежуток времени',
			_ => null,
		};
	}
}
