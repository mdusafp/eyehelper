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
	@override late final _Translations$permissions$ru permissions = _Translations$permissions$ru._(_root);
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
	@override String get retryThreeTimes => 'Повторить: 3 раза.';
	@override String get retryOneTime => 'Повторить: 1 раз.';
	@override String get retryTwentyFiveTimes => 'Повторить: 25 раз.';
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
}

// Path: notifications
class _Translations$notifications$ru extends Translations$notifications$en {
	_Translations$notifications$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get reminderEnabled => 'Напоминания включены';
	@override String get chooseTime => 'Выберите время, в которое вы находитесь за компьютером, приложение будет напоминать вам делать упражнения в рабочее время.';
	@override String get chooseWorkInterval => 'Выберите интервал, в который вы находитесь на работе';
	@override String get applyToAll => 'Применить ко всем';
	@override String get frequencyQuestion => 'Как часто вы хотите, чтобы приложение напоминало вам сделать упражнения?';
	@override String get timesPer => 'Раз в';
	@override String get hour => 'ч';
	@override String get minute => 'мин';
	@override String get weWillNotify => 'Мы будем напоминать вам делать упражнения';
	@override String get enablePrompt => 'Включите их\nчтобы приложение подсказало вам,\nчто пора позаниматься, когда вы будете на работе.';
	@override String get enableButton => 'Включить Уведомления';
	@override String get setTimePrompt => 'Установите время, в которое вы хотите получать уведомления и приложение напомнит вам об упражнениях';
	@override String get specifyParams => 'Укажите параметры';
	@override String get paramsDefault => 'Параметры';
	@override String get addTime => 'Добавить время';
	@override String get enabledStatus => 'Уведомления включены';
	@override String get disabledStatus => 'Уведомления отключены';
	@override String get setupButton => 'Настроить уведомления';
	@override String get reminderTitle => 'Напоминание';
	@override String get reminderBody => 'Пора делать зарядку!';
}

// Path: frequency
class _Translations$frequency$ru extends Translations$frequency$en {
	_Translations$frequency$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get onceADay => '1 раз в день';
	@override String get twiceADay => '2 раза в день';
	@override String get threeADay => '3 раза в день';
	@override String get onceInTwoDays => '1 раз в два дня';
	@override String get manualSettings => 'Ручная настройка';
	@override String get hoursZero => 'часов';
	@override String get hourOne => 'час';
	@override String get hoursTwo => 'часа';
	@override String get hoursFew => 'часов';
	@override String get hoursMany => 'часов';
	@override String get dayOne => 'день';
	@override String get daysTwo => 'дня';
	@override String get daysFew => 'дней';
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
	@override String get exerciseFrequencyPerDay => 'Частота выполнения упражнений';
	@override String get exercisePerMonth => 'Упражнений за этот месяц';
	@override String get responsesOnPush => 'Откликов на уведомления';
	@override String get skippedDays => 'Пропущено дней';
	@override String get currentWeek => 'Текущая неделя';
	@override String get currentDay => 'Текущий день';
	@override String get currentMonth => 'Текущий месяц';
	@override String get notEnoughData => 'Выполняйте еще упражнения, чтобы мы могли составить статистику';
}

// Path: finish
class _Translations$finish$ru extends Translations$finish$en {
	_Translations$finish$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get goodJob => 'Отлично!';
	@override String get youDoneExercises => 'Вы выполнили упражнения. Повторяйте чаще и ваши глаза скажут вам спасибо!';
	@override String get setMark => 'Оценить приложение';
	@override String wantToSetMark({required Object store}) => 'Хотите оценить нас в ${store}?';
	@override String rateAppSubtitle({required Object store}) => 'Вы можете оценить наше приложение в ${store}, это поможет нам развиваться и становиться лучше';
	@override String shareText({required Object url}) => 'Есть крутое приложение для тренировки глаз. Советую скачать! ${url}';
	@override String get value => 'Оценить';
	@override String get notNow => 'Не сейчас';
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

// Path: errors
class _Translations$errors$ru extends Translations$errors$en {
	_Translations$errors$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get wrongWorkTime => 'Выбран неверный промежуток времени';
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
			'exercises.retryThreeTimes' => 'Повторить: 3 раза.',
			'exercises.retryOneTime' => 'Повторить: 1 раз.',
			'exercises.retryTwentyFiveTimes' => 'Повторить: 25 раз.',
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
			'notifications.reminderEnabled' => 'Напоминания включены',
			'notifications.chooseTime' => 'Выберите время, в которое вы находитесь за компьютером, приложение будет напоминать вам делать упражнения в рабочее время.',
			'notifications.chooseWorkInterval' => 'Выберите интервал, в который вы находитесь на работе',
			'notifications.applyToAll' => 'Применить ко всем',
			'notifications.frequencyQuestion' => 'Как часто вы хотите, чтобы приложение напоминало вам сделать упражнения?',
			'notifications.timesPer' => 'Раз в',
			'notifications.hour' => 'ч',
			'notifications.minute' => 'мин',
			'notifications.weWillNotify' => 'Мы будем напоминать вам делать упражнения',
			'notifications.enablePrompt' => 'Включите их\nчтобы приложение подсказало вам,\nчто пора позаниматься, когда вы будете на работе.',
			'notifications.enableButton' => 'Включить Уведомления',
			'notifications.setTimePrompt' => 'Установите время, в которое вы хотите получать уведомления и приложение напомнит вам об упражнениях',
			'notifications.specifyParams' => 'Укажите параметры',
			'notifications.paramsDefault' => 'Параметры',
			'notifications.addTime' => 'Добавить время',
			'notifications.enabledStatus' => 'Уведомления включены',
			'notifications.disabledStatus' => 'Уведомления отключены',
			'notifications.setupButton' => 'Настроить уведомления',
			'notifications.reminderTitle' => 'Напоминание',
			'notifications.reminderBody' => 'Пора делать зарядку!',
			'frequency.onceADay' => '1 раз в день',
			'frequency.twiceADay' => '2 раза в день',
			'frequency.threeADay' => '3 раза в день',
			'frequency.onceInTwoDays' => '1 раз в два дня',
			'frequency.manualSettings' => 'Ручная настройка',
			'frequency.hoursZero' => 'часов',
			'frequency.hourOne' => 'час',
			'frequency.hoursTwo' => 'часа',
			'frequency.hoursFew' => 'часов',
			'frequency.hoursMany' => 'часов',
			'frequency.dayOne' => 'день',
			'frequency.daysTwo' => 'дня',
			'frequency.daysFew' => 'дней',
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
			'statistics.exerciseFrequencyPerDay' => 'Частота выполнения упражнений',
			'statistics.exercisePerMonth' => 'Упражнений за этот месяц',
			'statistics.responsesOnPush' => 'Откликов на уведомления',
			'statistics.skippedDays' => 'Пропущено дней',
			'statistics.currentWeek' => 'Текущая неделя',
			'statistics.currentDay' => 'Текущий день',
			'statistics.currentMonth' => 'Текущий месяц',
			'statistics.notEnoughData' => 'Выполняйте еще упражнения, чтобы мы могли составить статистику',
			'finish.goodJob' => 'Отлично!',
			'finish.youDoneExercises' => 'Вы выполнили упражнения. Повторяйте чаще и ваши глаза скажут вам спасибо!',
			'finish.setMark' => 'Оценить приложение',
			'finish.wantToSetMark' => ({required Object store}) => 'Хотите оценить нас в ${store}?',
			'finish.rateAppSubtitle' => ({required Object store}) => 'Вы можете оценить наше приложение в ${store}, это поможет нам развиваться и становиться лучше',
			'finish.shareText' => ({required Object url}) => 'Есть крутое приложение для тренировки глаз. Советую скачать! ${url}',
			'finish.value' => 'Оценить',
			'finish.notNow' => 'Не сейчас',
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
			'permissions.noPermissionTitle' => 'Нет разрешения',
			'permissions.noPermissionSubtitle' => 'Мы не получили разрешение на отправку уведомлений, поэтому не можем настроить их сейчас. Вы можете настроить разрешения в настройках вашего устройства.',
			'permissions.openSettings' => 'Открыть настройки',
			'errors.wrongWorkTime' => 'Выбран неверный промежуток времени',
			_ => null,
		};
	}
}
