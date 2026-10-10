///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$common$en common = Translations$common$en.internal(_root);
	late final Translations$exercises$en exercises = Translations$exercises$en.internal(_root);
	late final Translations$training$en training = Translations$training$en.internal(_root);
	late final Translations$notifications$en notifications = Translations$notifications$en.internal(_root);
	late final Translations$frequency$en frequency = Translations$frequency$en.internal(_root);
	late final Translations$schedule$en schedule = Translations$schedule$en.internal(_root);
	late final Translations$statistics$en statistics = Translations$statistics$en.internal(_root);
	late final Translations$finish$en finish = Translations$finish$en.internal(_root);
	late final Translations$onboarding$en onboarding = Translations$onboarding$en.internal(_root);
	late final Translations$about$en about = Translations$about$en.internal(_root);
	late final Translations$learnMore$en learnMore = Translations$learnMore$en.internal(_root);
	late final Translations$permissions$en permissions = Translations$permissions$en.internal(_root);
	late final Translations$ads$en ads = Translations$ads$en.internal(_root);
	late final Translations$errors$en errors = Translations$errors$en.internal(_root);
}

// Path: common
class Translations$common$en {
	Translations$common$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Statistics'
	String get statistics => 'Statistics';

	/// en: 'Exercises'
	String get exercises => 'Exercises';

	/// en: 'Notifications'
	String get notifications => 'Notifications';

	/// en: 'OK'
	String get ok => 'OK';

	/// en: 'Close'
	String get close => 'Close';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Add'
	String get add => 'Add';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Change'
	String get change => 'Change';

	/// en: 'Continue'
	String get continueButton => 'Continue';
}

// Path: exercises
class Translations$exercises$en {
	Translations$exercises$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Vertical movements'
	String get verticalMovements => 'Vertical movements';

	/// en: 'Horizontal movements'
	String get horizontalMovements => 'Horizontal movements';

	/// en: 'Eye squeezing'
	String get screwUpMovements => 'Eye squeezing';

	/// en: 'Blinking'
	String get blinkingMovements => 'Blinking';

	/// en: 'Focusing'
	String get focusMovements => 'Focusing';

	/// en: 'Palming'
	String get palmingMovements => 'Palming';

	/// en: 'Move your eyes up and down and back.'
	String get turnEyesUpDown => 'Move your eyes up and down and back.';

	/// en: 'Move your eyes left and right and back.'
	String get turnEyesLeftRight => 'Move your eyes left and right and back.';

	/// en: 'Squeeze your eyes shut tightly for 10 seconds, then relax the muscles for 10 seconds without opening your eyes.'
	String get screwUpYourEyes => 'Squeeze your eyes shut tightly for 10 seconds, then relax the muscles for 10 seconds without opening your eyes.';

	/// en: 'Focus on a near object first (10 sec), then on a far one (10 sec).'
	String get focusFor10Sec => 'Focus on a near object first (10 sec), then on a far one (10 sec).';

	/// en: 'Blink quickly.'
	String get blinkFast => 'Blink quickly.';

	/// en: 'Rub your hands together until they feel warm. Place them over your eyes for 15 seconds (without pressing). Think about your dream.'
	String get rubHandsAndAttach => 'Rub your hands together until they feel warm. Place them over your eyes for 15 seconds (without pressing). Think about your dream.';

	/// en: '(one) {{n} rep} (other) {{n} reps}'
	String reps({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} rep',
		other: '${n} reps',
	);

	/// en: '{done} of {total}'
	String repsOf({required Object done, required Object total}) => '${done} of ${total}';

	/// en: 'Start'
	String get beginButton => 'Start';
}

// Path: training
class Translations$training$en {
	Translations$training$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Look up'
	String get watchUp => 'Look\n up';

	/// en: 'Look down'
	String get watchDown => 'Look\n down';

	/// en: 'Look left'
	String get watchLeft => 'Look\n left';

	/// en: 'Look right'
	String get watchRight => 'Look\n right';

	/// en: 'Squeeze your eyes shut'
	String get screwUp => 'Squeeze your eyes shut';

	/// en: 'Relax your eyes'
	String get relaxEyes => 'Relax your eyes';

	/// en: 'Blink quickly'
	String get fastBlink => 'Blink quickly';

	/// en: 'Look into the distance'
	String get watchFar => 'Look into the distance';

	/// en: 'Look at your phone'
	String get watchNear => 'Look at your phone';

	/// en: 'Warm up your hands'
	String get rubHands => 'Warm up your hands';

	/// en: 'Place your hands over your eyes'
	String get applyToEyes => 'Place your hands over your eyes';

	/// en: 'Get ready'
	String get getReady => 'Get ready';
}

// Path: notifications
class Translations$notifications$en {
	Translations$notifications$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Choose the interval when you're at work'
	String get chooseWorkInterval => 'Choose the interval when you\'re at work';

	/// en: 'Enable notifications'
	String get enableButton => 'Enable notifications';

	/// en: 'Add time'
	String get addTime => 'Add time';

	/// en: 'Set up notifications'
	String get setupButton => 'Set up notifications';

	/// en: 'Reminder'
	String get reminderTitle => 'Reminder';

	/// en: 'Time to do your eye exercises!'
	String get reminderBody => 'Time to do your eye exercises!';

	/// en: 'By schedule'
	String get modeAuto => 'By schedule';

	/// en: 'Custom times'
	String get modeManual => 'Custom times';

	/// en: 'Reminders per day'
	String get remindersPerDay => 'Reminders per day';

	/// en: 'Today, {day}'
	String todayIs({required Object day}) => 'Today, ${day}';

	/// en: 'Today is a day off — no reminders'
	String get todayDayOff => 'Today is a day off — no reminders';

	/// en: 'Working days'
	String get workingDays => 'Working days';

	/// en: 'Working hours'
	String get workingHours => 'Working hours';

	/// en: 'Working hours · {day}'
	String workingHoursFor({required Object day}) => 'Working hours · ${day}';

	/// en: 'Some differ'
	String get hoursDiffer => 'Some differ';

	/// en: 'hours vary'
	String get hoursVary => 'hours vary';

	/// en: 'Set per day'
	String get perDaySetup => 'Set per day';

	/// en: 'Collapse'
	String get collapse => 'Collapse';

	/// en: 'Pick at least one working day'
	String get noWorkingDays => 'Pick at least one working day';

	/// en: 'We'll remind you at {times}'
	String willRemindAt({required Object times}) => 'We\'ll remind you at ${times}';

	/// en: 'Apply to all working days'
	String get applyToAllWorking => 'Apply to all working days';

	/// en: 'Reminder'
	String get reminder => 'Reminder';

	/// en: 'New reminder'
	String get newReminder => 'New reminder';

	/// en: 'Weekdays'
	String get weekdays => 'Weekdays';

	/// en: 'Every day'
	String get everyDay => 'Every day';

	/// en: 'Weekend'
	String get weekendDays => 'Weekend';

	/// en: 'weekdays'
	String get weekdaysShort => 'weekdays';

	/// en: 'every day'
	String get everyDayShort => 'every day';

	/// en: 'weekend'
	String get weekendShort => 'weekend';

	/// en: 'day off'
	String get dayOffShort => 'day off';

	/// en: 'Enable'
	String get enableDay => 'Enable';

	/// en: 'Delete reminder'
	String get deleteReminder => 'Delete reminder';

	/// en: 'Pick at least one day'
	String get pickAtLeastOneDay => 'Pick at least one day';

	/// en: 'Tap a row to change its time or days. Swipe left to delete.'
	String get manualHint => 'Tap a row to change its time or days. Swipe left to delete.';

	/// en: 'Off'
	String get offShort => 'Off';

	/// en: 'Eyes tire without you noticing'
	String get offTitle => 'Eyes tire without you noticing';

	/// en: 'Turn reminders on and the app will tell you when to take a break while you're at the computer.'
	String get offText => 'Turn reminders on and the app will tell you when to take a break while you\'re at the computer.';

	/// en: '(one) {{n} reminder a day} (other) {{n} reminders a day}'
	String summaryPerDay({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} reminder a day',
		other: '${n} reminders a day',
	);

	/// en: 'Every day except {days}'
	String everyDayExcept({required Object days}) => 'Every day except ${days}';

	/// en: 'and'
	String get daysAnd => 'and';

	/// en: 'Delete this reminder?'
	String get deleteConfirmTitle => 'Delete this reminder?';

	/// en: '{time} · {days}'
	String deleteConfirmText({required Object time, required Object days}) => '${time} · ${days}';

	/// en: '(one) {{n} custom time} (other) {{n} custom times}'
	String summaryCustom({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} custom time',
		other: '${n} custom times',
	);

	/// en: 'next today at {time}'
	String nextToday({required Object time}) => 'next today at ${time}';

	/// en: 'next — {day}, {time}'
	String nextOn({required Object day, required Object time}) => 'next — ${day}, ${time}';

	/// en: 'no reminders scheduled'
	String get noneScheduled => 'no reminders scheduled';
}

// Path: frequency
class Translations$frequency$en {
	Translations$frequency$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'day'
	String get dayOne => 'day';
}

// Path: schedule
class Translations$schedule$en {
	Translations$schedule$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Mon'
	String get mondayShort => 'Mon';

	/// en: 'Tue'
	String get tuesdayShort => 'Tue';

	/// en: 'Wed'
	String get wednesdayShort => 'Wed';

	/// en: 'Thu'
	String get thursdayShort => 'Thu';

	/// en: 'Fri'
	String get fridayShort => 'Fri';

	/// en: 'Sat'
	String get saturdayShort => 'Sat';

	/// en: 'Sun'
	String get sundayShort => 'Sun';

	/// en: 'Monday'
	String get monday => 'Monday';

	/// en: 'Tuesday'
	String get tuesday => 'Tuesday';

	/// en: 'Wednesday'
	String get wednesday => 'Wednesday';

	/// en: 'Thursday'
	String get thursday => 'Thursday';

	/// en: 'Friday'
	String get friday => 'Friday';

	/// en: 'Saturday'
	String get saturday => 'Saturday';

	/// en: 'Sunday'
	String get sunday => 'Sunday';

	/// en: 'Wk'
	String get weekShort => 'Wk';

	/// en: 'Ex'
	String get exerciseShort => 'Ex';

	/// en: 'Times'
	String get times => 'Times';

	/// en: 'Working hours'
	String get workingTime => 'Working hours';

	/// en: 'Day off'
	String get weekend => 'Day off';

	/// en: 'from'
	String get from => 'from';

	/// en: 'to'
	String get to => 'to';
}

// Path: statistics
class Translations$statistics$en {
	Translations$statistics$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Streak'
	String get streak => 'Streak';

	/// en: '(one) {day in a row} (other) {days in a row}'
	String daysInARow({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'day in a row',
		other: 'days in a row',
	);

	/// en: '(one) {{n} day} (other) {{n} days}'
	String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} day',
		other: '${n} days',
	);

	/// en: 'Best — {days}'
	String bestStreak({required Object days}) => 'Best — ${days}';

	/// en: 'Finish a full set to start a streak'
	String get noStreakYet => 'Finish a full set to start a streak';

	/// en: 'Today'
	String get today => 'Today';

	/// en: '(one) {{done} of {n} set planned} (other) {{done} of {n} sets planned}'
	String setsOfPlan({required num n, required Object done}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${done} of ${n} set planned',
		other: '${done} of ${n} sets planned',
	);

	/// en: 'Left: {names} · {time}'
	String remaining({required Object names, required Object time}) => 'Left: ${names} · ${time}';

	/// en: 'All six done — your eyes had their rest'
	String get allDone => 'All six done — your eyes had their rest';

	/// en: '(one) {{n} set · {time}} (other) {{n} sets · {time}}'
	String setsAndTime({required num n, required Object time}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} set · ${time}',
		other: '${n} sets · ${time}',
	);

	/// en: '3+ sets'
	String get legendMax => '3+ sets';

	/// en: 'This week'
	String get thisWeek => 'This week';

	/// en: 'min for your eyes'
	String get minutesForEyes => 'min for your eyes';

	/// en: 'Last week — {time}'
	String lastWeek({required Object time}) => 'Last week — ${time}';

	/// en: 'h'
	String get hoursShort => 'h';

	/// en: 'min'
	String get minutesShort => 'min';

	/// en: 's'
	String get secondsShort => 's';
}

// Path: finish
class Translations$finish$en {
	Translations$finish$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Great job!'
	String get goodJob => 'Great job!';

	/// en: 'You've completed the exercises. Do them more often and your eyes will thank you!'
	String get youDoneExercises => 'You\'ve completed the exercises. Do them more often and your eyes will thank you!';

	/// en: 'There's a cool app for eye training. I recommend downloading it! {url}'
	String shareText({required Object url}) => 'There\'s a cool app for eye training. I recommend downloading it! ${url}';

	/// en: 'Do you like the app? ❤️'
	String get likeQuestion => 'Do you like the app?  ❤️';

	/// en: 'Yes!'
	String get likeYes => 'Yes!';

	/// en: 'Not really'
	String get likeNo => 'Not really';

	/// en: 'What could be better?'
	String get feedbackTitle => 'What could be better?';

	/// en: 'Tell us what you don't like — it helps us make the app better.'
	String get feedbackHint => 'Tell us what you don\'t like — it helps us make the app better.';

	/// en: 'Send'
	String get feedbackSend => 'Send';

	/// en: 'Skip'
	String get feedbackSkip => 'Skip';

	/// en: 'Thank you — got it!'
	String get feedbackThanks => 'Thank you — got it!';

	/// en: 'Share the app'
	String get share => 'Share the app';
}

// Path: onboarding
class Translations$onboarding$en {
	Translations$onboarding$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your eyes need a rest!'
	String get title1 => 'Your eyes need a rest!';

	/// en: 'What exercises?'
	String get title2 => 'What exercises?';

	/// en: 'We'll remind you!'
	String get title3 => 'We\'ll remind you!';

	/// en: 'Don't our eyes deserve a little rest during the workday? Let's agree to do the exercises every day.'
	String get subtitle1 => 'Don\'t our eyes deserve a little rest during the workday?\nLet\'s agree to do the exercises every day.';

	/// en: 'We'll tell you about exercises to relax your eyes and show you how to do them. Just check in every now and then… )'
	String get subtitle2 => 'We\'ll tell you about exercises to relax your eyes and show you how to do them.\nJust check in every now and then… )';

	/// en: 'Tell us when and on which days you work at the computer, and the app will help you take care of your eyes.'
	String get subtitle3 => 'Tell us when and on which days you work at the computer, and the app will help you take care of your eyes.';
}

// Path: about
class Translations$about$en {
	Translations$about$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'About the exercises'
	String get title => 'About the exercises';

	/// en: 'This app offers a set of guided eye exercises designed to help relax your eyes and ease strain.'
	String get body1 => 'This app offers a set of guided eye exercises designed to help relax your eyes and ease strain.';

	/// en: 'Tap the button below to learn more about how they work.'
	String get body2 => 'Tap the button below to learn more about how they work.';

	/// en: 'Important: '
	String get warningLabel => 'Important: ';

	/// en: 'These exercises are for general wellness and are not intended to diagnose, treat, cure, or prevent any medical condition. Please consult a doctor or eye-care professional before starting, especially if you have an existing eye condition. Use of this app is at your own risk, and the developers are not liable for any injury, loss, or damage arising from its use.'
	String get disclaimer => 'These exercises are for general wellness and are not intended to diagnose, treat, cure, or prevent any medical condition. Please consult a doctor or eye-care professional before starting, especially if you have an existing eye condition. Use of this app is at your own risk, and the developers are not liable for any injury, loss, or damage arising from its use.';

	/// en: 'Learn more'
	String get moreButton => 'Learn more';

	/// en: 'Got it'
	String get gotItButton => 'Got it';
}

// Path: learnMore
class Translations$learnMore$en {
	Translations$learnMore$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'How these exercises work'
	String get title => 'How these exercises work';

	/// en: 'Your eyes have muscles too — the ones that move your gaze and the tiny ones that shift your focus between near and far. Like any muscle, they get tired and stiff when they hold one position for hours, which is exactly what happens when you stare at a screen. This routine is a simple, guided workout to help those muscles relax, loosen up, and switch focus more comfortably.'
	String get intro1 => 'Your eyes have muscles too — the ones that move your gaze and the tiny ones that shift your focus between near and far. Like any muscle, they get tired and stiff when they hold one position for hours, which is exactly what happens when you stare at a screen. This routine is a simple, guided workout to help those muscles relax, loosen up, and switch focus more comfortably.';

	/// en: 'Do it once a day, about 15 minutes, sitting up straight. Move slowly and gently, and start with fewer repetitions — a little fatigue at first is normal and eases as you go.'
	String get intro2 => 'Do it once a day, about 15 minutes, sitting up straight. Move slowly and gently, and start with fewer repetitions — a little fatigue at first is normal and eases as you go.';

	List<dynamic> get parts => [
		Translations$learnMore$parts$0$en.internal(_root),
		Translations$learnMore$parts$1$en.internal(_root),
		Translations$learnMore$parts$2$en.internal(_root),
	];

	/// en: 'A few things that help even more: good lighting, regular screen breaks, time outdoors, and letting your eyes rest often.'
	String get tips => 'A few things that help even more: good lighting, regular screen breaks, time outdoors, and letting your eyes rest often.';

	/// en: 'Important: '
	String get warningLabel => 'Important: ';

	/// en: 'These exercises are for general wellness and relaxation. They are not a treatment and are not intended to diagnose, cure, or prevent any medical condition. Please check with a doctor or eye-care professional before starting, especially if you have an existing eye condition. Use this app at your own discretion.'
	String get disclaimer => 'These exercises are for general wellness and relaxation. They are not a treatment and are not intended to diagnose, cure, or prevent any medical condition. Please check with a doctor or eye-care professional before starting, especially if you have an existing eye condition. Use this app at your own discretion.';
}

// Path: permissions
class Translations$permissions$en {
	Translations$permissions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No permission'
	String get noPermissionTitle => 'No permission';

	/// en: 'We didn't get permission to send notifications, so we can't set them up right now. You can configure permissions in your device settings.'
	String get noPermissionSubtitle => 'We didn\'t get permission to send notifications, so we can\'t set them up right now. You can configure permissions in your device settings.';

	/// en: 'Open settings'
	String get openSettings => 'Open settings';
}

// Path: ads
class Translations$ads$en {
	Translations$ads$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Eye Helper stays free'
	String get introTitle => 'Eye Helper stays free';

	/// en: 'To keep the app free for everyone, a small banner will start appearing on some screens. Your exercises and statistics are not affected.'
	String get introSubtitle => 'To keep the app free for everyone, a small banner will start appearing on some screens. Your exercises and statistics are not affected.';

	/// en: 'Got it'
	String get introButton => 'Got it';
}

// Path: errors
class Translations$errors$en {
	Translations$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Invalid time range selected'
	String get wrongWorkTime => 'Invalid time range selected';
}

// Path: learnMore.parts.0
class Translations$learnMore$parts$0$en {
	Translations$learnMore$parts$0$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Part 1 — Warm up & refresh'
	String get title => 'Part 1 — Warm up & refresh';

	/// en: 'Gets circulation going around your eyes and eases tension.'
	String get subtitle => 'Gets circulation going around your eyes and eases tension.';

	List<dynamic> get exercises => [
		Translations$learnMore$parts$0$exercises$0$en.internal(_root),
		Translations$learnMore$parts$0$exercises$1$en.internal(_root),
		Translations$learnMore$parts$0$exercises$2$en.internal(_root),
		Translations$learnMore$parts$0$exercises$3$en.internal(_root),
		Translations$learnMore$parts$0$exercises$4$en.internal(_root),
	];
}

// Path: learnMore.parts.1
class Translations$learnMore$parts$1$en {
	Translations$learnMore$parts$1$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Part 2 — Move your gaze'
	String get title => 'Part 2 — Move your gaze';

	/// en: 'Loosens the muscles that aim your eyes. Keep your head still and let only your eyes move.'
	String get subtitle => 'Loosens the muscles that aim your eyes. Keep your head still and let only your eyes move.';

	List<dynamic> get exercises => [
		Translations$learnMore$parts$1$exercises$0$en.internal(_root),
		Translations$learnMore$parts$1$exercises$1$en.internal(_root),
		Translations$learnMore$parts$1$exercises$2$en.internal(_root),
		Translations$learnMore$parts$1$exercises$3$en.internal(_root),
	];
}

// Path: learnMore.parts.2
class Translations$learnMore$parts$2$en {
	Translations$learnMore$parts$2$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Part 3 — Near & far focus'
	String get title => 'Part 3 — Near & far focus';

	/// en: 'Trains the focusing muscle to switch distances smoothly — the part that gets stuck after a long screen session.'
	String get subtitle => 'Trains the focusing muscle to switch distances smoothly — the part that gets stuck after a long screen session.';

	List<dynamic> get exercises => [
		Translations$learnMore$parts$2$exercises$0$en.internal(_root),
		Translations$learnMore$parts$2$exercises$1$en.internal(_root),
		Translations$learnMore$parts$2$exercises$2$en.internal(_root),
		Translations$learnMore$parts$2$exercises$3$en.internal(_root),
	];
}

// Path: learnMore.parts.0.exercises.0
class Translations$learnMore$parts$0$exercises$0$en {
	Translations$learnMore$parts$0$exercises$0$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Eyelid massage'
	String get name => 'Eyelid massage';

	/// en: 'With clean fingertips, gently massage your closed eyelids for about a minute.'
	String get text => 'With clean fingertips, gently massage your closed eyelids for about a minute.';
}

// Path: learnMore.parts.0.exercises.1
class Translations$learnMore$parts$0$exercises$1$en {
	Translations$learnMore$parts$0$exercises$1$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Gentle squeeze'
	String get name => 'Gentle squeeze';

	/// en: 'Shut your eyes tightly for 3–5 seconds, then relax for 4–6 seconds. Repeat 6–8 times.'
	String get text => 'Shut your eyes tightly for 3–5 seconds, then relax for 4–6 seconds. Repeat 6–8 times.';
}

// Path: learnMore.parts.0.exercises.2
class Translations$learnMore$parts$0$exercises$2$en {
	Translations$learnMore$parts$0$exercises$2$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Quick blinks'
	String get name => 'Quick blinks';

	/// en: 'Blink rapidly for 15 seconds, then rest your gaze forward for 5 seconds. Up to 6 rounds.'
	String get text => 'Blink rapidly for 15 seconds, then rest your gaze forward for 5 seconds. Up to 6 rounds.';
}

// Path: learnMore.parts.0.exercises.3
class Translations$learnMore$parts$0$exercises$3$en {
	Translations$learnMore$parts$0$exercises$3$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Light pressure'
	String get name => 'Light pressure';

	/// en: 'With eyes closed, rest two fingers very gently on each eyelid for 2–3 seconds while you breathe deeply. Repeat 4–6 times. Light touch only.'
	String get text => 'With eyes closed, rest two fingers very gently on each eyelid for 2–3 seconds while you breathe deeply. Repeat 4–6 times. Light touch only.';
}

// Path: learnMore.parts.0.exercises.4
class Translations$learnMore$parts$0$exercises$4$en {
	Translations$learnMore$parts$0$exercises$4$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Brow resistance'
	String get name => 'Brow resistance';

	/// en: 'Press your fingers to your eyebrows and gently frown and squint against that light resistance. Up to 8 times.'
	String get text => 'Press your fingers to your eyebrows and gently frown and squint against that light resistance. Up to 8 times.';
}

// Path: learnMore.parts.1.exercises.0
class Translations$learnMore$parts$1$exercises$0$en {
	Translations$learnMore$parts$1$exercises$0$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Up & down'
	String get name => 'Up & down';

	/// en: 'Slowly look up, pause, look down, pause. 8–12 times.'
	String get text => 'Slowly look up, pause, look down, pause. 8–12 times.';
}

// Path: learnMore.parts.1.exercises.1
class Translations$learnMore$parts$1$exercises$1$en {
	Translations$learnMore$parts$1$exercises$1$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Side to side'
	String get name => 'Side to side';

	/// en: 'The same slow rhythm, left and right, as far as is comfortable. 8–12 times.'
	String get text => 'The same slow rhythm, left and right, as far as is comfortable. 8–12 times.';
}

// Path: learnMore.parts.1.exercises.2
class Translations$learnMore$parts$1$exercises$2$en {
	Translations$learnMore$parts$1$exercises$2$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Diagonals'
	String get name => 'Diagonals';

	/// en: 'Lower-left to upper-right, 8 times; rest 30 seconds; then lower-right to upper-left, 8 times.'
	String get text => 'Lower-left to upper-right, 8 times; rest 30 seconds; then lower-right to upper-left, 8 times.';
}

// Path: learnMore.parts.1.exercises.3
class Translations$learnMore$parts$1$exercises$3$en {
	Translations$learnMore$parts$1$exercises$3$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Circles'
	String get name => 'Circles';

	/// en: 'Trace a full slow circle with your eyes, clockwise 6–8 times, then counter-clockwise 6–8 times.'
	String get text => 'Trace a full slow circle with your eyes, clockwise 6–8 times, then counter-clockwise 6–8 times.';
}

// Path: learnMore.parts.2.exercises.0
class Translations$learnMore$parts$2$exercises$0$en {
	Translations$learnMore$parts$2$exercises$0$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Near to far'
	String get name => 'Near to far';

	/// en: 'Hold a finger about a foot from your face, focus on it, then shift focus to something across the room, then back. 10–12 times.'
	String get text => 'Hold a finger about a foot from your face, focus on it, then shift focus to something across the room, then back. 10–12 times.';
}

// Path: learnMore.parts.2.exercises.1
class Translations$learnMore$parts$2$exercises$1$en {
	Translations$learnMore$parts$2$exercises$1$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Coming closer'
	String get name => 'Coming closer';

	/// en: 'Keep looking at your finger as you slowly bring it toward the bridge of your nose, then move it back out. 10 times.'
	String get text => 'Keep looking at your finger as you slowly bring it toward the bridge of your nose, then move it back out. 10 times.';
}

// Path: learnMore.parts.2.exercises.2
class Translations$learnMore$parts$2$exercises$2$en {
	Translations$learnMore$parts$2$exercises$2$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'One eye at a time'
	String get name => 'One eye at a time';

	/// en: 'Cover one eye and do the near-to-far shift, then switch. 8 times each.'
	String get text => 'Cover one eye and do the near-to-far shift, then switch. 8 times each.';
}

// Path: learnMore.parts.2.exercises.3
class Translations$learnMore$parts$2$exercises$3$en {
	Translations$learnMore$parts$2$exercises$3$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Window spot'
	String get name => 'Window spot';

	/// en: 'Put a small mark on a window, study it for 30 seconds, then look at something far outside, and back. 8 times.'
	String get text => 'Put a small mark on a window, study it for 30 seconds, then look at something far outside, and back. 8 times.';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'common.statistics' => 'Statistics',
			'common.exercises' => 'Exercises',
			'common.notifications' => 'Notifications',
			'common.ok' => 'OK',
			'common.close' => 'Close',
			'common.cancel' => 'Cancel',
			'common.add' => 'Add',
			'common.delete' => 'Delete',
			'common.save' => 'Save',
			'common.change' => 'Change',
			'common.continueButton' => 'Continue',
			'exercises.verticalMovements' => 'Vertical movements',
			'exercises.horizontalMovements' => 'Horizontal movements',
			'exercises.screwUpMovements' => 'Eye squeezing',
			'exercises.blinkingMovements' => 'Blinking',
			'exercises.focusMovements' => 'Focusing',
			'exercises.palmingMovements' => 'Palming',
			'exercises.turnEyesUpDown' => 'Move your eyes up and down and back.',
			'exercises.turnEyesLeftRight' => 'Move your eyes left and right and back.',
			'exercises.screwUpYourEyes' => 'Squeeze your eyes shut tightly for 10 seconds, then relax the muscles for 10 seconds without opening your eyes.',
			'exercises.focusFor10Sec' => 'Focus on a near object first (10 sec), then on a far one (10 sec).',
			'exercises.blinkFast' => 'Blink quickly.',
			'exercises.rubHandsAndAttach' => 'Rub your hands together until they feel warm. Place them over your eyes for 15 seconds (without pressing). Think about your dream.',
			'exercises.reps' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} rep', other: '${n} reps', ), 
			'exercises.repsOf' => ({required Object done, required Object total}) => '${done} of ${total}',
			'exercises.beginButton' => 'Start',
			'training.watchUp' => 'Look\n up',
			'training.watchDown' => 'Look\n down',
			'training.watchLeft' => 'Look\n left',
			'training.watchRight' => 'Look\n right',
			'training.screwUp' => 'Squeeze your eyes shut',
			'training.relaxEyes' => 'Relax your eyes',
			'training.fastBlink' => 'Blink quickly',
			'training.watchFar' => 'Look into the distance',
			'training.watchNear' => 'Look at your phone',
			'training.rubHands' => 'Warm up your hands',
			'training.applyToEyes' => 'Place your hands over your eyes',
			'training.getReady' => 'Get ready',
			'notifications.chooseWorkInterval' => 'Choose the interval when you\'re at work',
			'notifications.enableButton' => 'Enable notifications',
			'notifications.addTime' => 'Add time',
			'notifications.setupButton' => 'Set up notifications',
			'notifications.reminderTitle' => 'Reminder',
			'notifications.reminderBody' => 'Time to do your eye exercises!',
			'notifications.modeAuto' => 'By schedule',
			'notifications.modeManual' => 'Custom times',
			'notifications.remindersPerDay' => 'Reminders per day',
			'notifications.todayIs' => ({required Object day}) => 'Today, ${day}',
			'notifications.todayDayOff' => 'Today is a day off — no reminders',
			'notifications.workingDays' => 'Working days',
			'notifications.workingHours' => 'Working hours',
			'notifications.workingHoursFor' => ({required Object day}) => 'Working hours · ${day}',
			'notifications.hoursDiffer' => 'Some differ',
			'notifications.hoursVary' => 'hours vary',
			'notifications.perDaySetup' => 'Set per day',
			'notifications.collapse' => 'Collapse',
			'notifications.noWorkingDays' => 'Pick at least one working day',
			'notifications.willRemindAt' => ({required Object times}) => 'We\'ll remind you at ${times}',
			'notifications.applyToAllWorking' => 'Apply to all working days',
			'notifications.reminder' => 'Reminder',
			'notifications.newReminder' => 'New reminder',
			'notifications.weekdays' => 'Weekdays',
			'notifications.everyDay' => 'Every day',
			'notifications.weekendDays' => 'Weekend',
			'notifications.weekdaysShort' => 'weekdays',
			'notifications.everyDayShort' => 'every day',
			'notifications.weekendShort' => 'weekend',
			'notifications.dayOffShort' => 'day off',
			'notifications.enableDay' => 'Enable',
			'notifications.deleteReminder' => 'Delete reminder',
			'notifications.pickAtLeastOneDay' => 'Pick at least one day',
			'notifications.manualHint' => 'Tap a row to change its time or days. Swipe left to delete.',
			'notifications.offShort' => 'Off',
			'notifications.offTitle' => 'Eyes tire without you noticing',
			'notifications.offText' => 'Turn reminders on and the app will tell you when to take a break while you\'re at the computer.',
			'notifications.summaryPerDay' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} reminder a day', other: '${n} reminders a day', ), 
			'notifications.everyDayExcept' => ({required Object days}) => 'Every day except ${days}',
			'notifications.daysAnd' => 'and',
			'notifications.deleteConfirmTitle' => 'Delete this reminder?',
			'notifications.deleteConfirmText' => ({required Object time, required Object days}) => '${time} · ${days}',
			'notifications.summaryCustom' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} custom time', other: '${n} custom times', ), 
			'notifications.nextToday' => ({required Object time}) => 'next today at ${time}',
			'notifications.nextOn' => ({required Object day, required Object time}) => 'next — ${day}, ${time}',
			'notifications.noneScheduled' => 'no reminders scheduled',
			'frequency.dayOne' => 'day',
			'schedule.mondayShort' => 'Mon',
			'schedule.tuesdayShort' => 'Tue',
			'schedule.wednesdayShort' => 'Wed',
			'schedule.thursdayShort' => 'Thu',
			'schedule.fridayShort' => 'Fri',
			'schedule.saturdayShort' => 'Sat',
			'schedule.sundayShort' => 'Sun',
			'schedule.monday' => 'Monday',
			'schedule.tuesday' => 'Tuesday',
			'schedule.wednesday' => 'Wednesday',
			'schedule.thursday' => 'Thursday',
			'schedule.friday' => 'Friday',
			'schedule.saturday' => 'Saturday',
			'schedule.sunday' => 'Sunday',
			'schedule.weekShort' => 'Wk',
			'schedule.exerciseShort' => 'Ex',
			'schedule.times' => 'Times',
			'schedule.workingTime' => 'Working hours',
			'schedule.weekend' => 'Day off',
			'schedule.from' => 'from',
			'schedule.to' => 'to',
			'statistics.streak' => 'Streak',
			'statistics.daysInARow' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'day in a row', other: 'days in a row', ), 
			'statistics.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} day', other: '${n} days', ), 
			'statistics.bestStreak' => ({required Object days}) => 'Best — ${days}',
			'statistics.noStreakYet' => 'Finish a full set to start a streak',
			'statistics.today' => 'Today',
			'statistics.setsOfPlan' => ({required num n, required Object done}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${done} of ${n} set planned', other: '${done} of ${n} sets planned', ), 
			'statistics.remaining' => ({required Object names, required Object time}) => 'Left: ${names} · ${time}',
			'statistics.allDone' => 'All six done — your eyes had their rest',
			'statistics.setsAndTime' => ({required num n, required Object time}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} set · ${time}', other: '${n} sets · ${time}', ), 
			'statistics.legendMax' => '3+ sets',
			'statistics.thisWeek' => 'This week',
			'statistics.minutesForEyes' => 'min for your eyes',
			'statistics.lastWeek' => ({required Object time}) => 'Last week — ${time}',
			'statistics.hoursShort' => 'h',
			'statistics.minutesShort' => 'min',
			'statistics.secondsShort' => 's',
			'finish.goodJob' => 'Great job!',
			'finish.youDoneExercises' => 'You\'ve completed the exercises. Do them more often and your eyes will thank you!',
			'finish.shareText' => ({required Object url}) => 'There\'s a cool app for eye training. I recommend downloading it! ${url}',
			'finish.likeQuestion' => 'Do you like the app?  ❤️',
			'finish.likeYes' => 'Yes!',
			'finish.likeNo' => 'Not really',
			'finish.feedbackTitle' => 'What could be better?',
			'finish.feedbackHint' => 'Tell us what you don\'t like — it helps us make the app better.',
			'finish.feedbackSend' => 'Send',
			'finish.feedbackSkip' => 'Skip',
			'finish.feedbackThanks' => 'Thank you — got it!',
			'finish.share' => 'Share the app',
			'onboarding.title1' => 'Your eyes need a rest!',
			'onboarding.title2' => 'What exercises?',
			'onboarding.title3' => 'We\'ll remind you!',
			'onboarding.subtitle1' => 'Don\'t our eyes deserve a little rest during the workday?\nLet\'s agree to do the exercises every day.',
			'onboarding.subtitle2' => 'We\'ll tell you about exercises to relax your eyes and show you how to do them.\nJust check in every now and then… )',
			'onboarding.subtitle3' => 'Tell us when and on which days you work at the computer, and the app will help you take care of your eyes.',
			'about.title' => 'About the exercises',
			'about.body1' => 'This app offers a set of guided eye exercises designed to help relax your eyes and ease strain.',
			'about.body2' => 'Tap the button below to learn more about how they work.',
			'about.warningLabel' => 'Important: ',
			'about.disclaimer' => 'These exercises are for general wellness and are not intended to diagnose, treat, cure, or prevent any medical condition. Please consult a doctor or eye-care professional before starting, especially if you have an existing eye condition. Use of this app is at your own risk, and the developers are not liable for any injury, loss, or damage arising from its use.',
			'about.moreButton' => 'Learn more',
			'about.gotItButton' => 'Got it',
			'learnMore.title' => 'How these exercises work',
			'learnMore.intro1' => 'Your eyes have muscles too — the ones that move your gaze and the tiny ones that shift your focus between near and far. Like any muscle, they get tired and stiff when they hold one position for hours, which is exactly what happens when you stare at a screen. This routine is a simple, guided workout to help those muscles relax, loosen up, and switch focus more comfortably.',
			'learnMore.intro2' => 'Do it once a day, about 15 minutes, sitting up straight. Move slowly and gently, and start with fewer repetitions — a little fatigue at first is normal and eases as you go.',
			'learnMore.parts.0.title' => 'Part 1 — Warm up & refresh',
			'learnMore.parts.0.subtitle' => 'Gets circulation going around your eyes and eases tension.',
			'learnMore.parts.0.exercises.0.name' => 'Eyelid massage',
			'learnMore.parts.0.exercises.0.text' => 'With clean fingertips, gently massage your closed eyelids for about a minute.',
			'learnMore.parts.0.exercises.1.name' => 'Gentle squeeze',
			'learnMore.parts.0.exercises.1.text' => 'Shut your eyes tightly for 3–5 seconds, then relax for 4–6 seconds. Repeat 6–8 times.',
			'learnMore.parts.0.exercises.2.name' => 'Quick blinks',
			'learnMore.parts.0.exercises.2.text' => 'Blink rapidly for 15 seconds, then rest your gaze forward for 5 seconds. Up to 6 rounds.',
			'learnMore.parts.0.exercises.3.name' => 'Light pressure',
			'learnMore.parts.0.exercises.3.text' => 'With eyes closed, rest two fingers very gently on each eyelid for 2–3 seconds while you breathe deeply. Repeat 4–6 times. Light touch only.',
			'learnMore.parts.0.exercises.4.name' => 'Brow resistance',
			'learnMore.parts.0.exercises.4.text' => 'Press your fingers to your eyebrows and gently frown and squint against that light resistance. Up to 8 times.',
			'learnMore.parts.1.title' => 'Part 2 — Move your gaze',
			'learnMore.parts.1.subtitle' => 'Loosens the muscles that aim your eyes. Keep your head still and let only your eyes move.',
			'learnMore.parts.1.exercises.0.name' => 'Up & down',
			'learnMore.parts.1.exercises.0.text' => 'Slowly look up, pause, look down, pause. 8–12 times.',
			'learnMore.parts.1.exercises.1.name' => 'Side to side',
			'learnMore.parts.1.exercises.1.text' => 'The same slow rhythm, left and right, as far as is comfortable. 8–12 times.',
			'learnMore.parts.1.exercises.2.name' => 'Diagonals',
			'learnMore.parts.1.exercises.2.text' => 'Lower-left to upper-right, 8 times; rest 30 seconds; then lower-right to upper-left, 8 times.',
			'learnMore.parts.1.exercises.3.name' => 'Circles',
			'learnMore.parts.1.exercises.3.text' => 'Trace a full slow circle with your eyes, clockwise 6–8 times, then counter-clockwise 6–8 times.',
			'learnMore.parts.2.title' => 'Part 3 — Near & far focus',
			'learnMore.parts.2.subtitle' => 'Trains the focusing muscle to switch distances smoothly — the part that gets stuck after a long screen session.',
			'learnMore.parts.2.exercises.0.name' => 'Near to far',
			'learnMore.parts.2.exercises.0.text' => 'Hold a finger about a foot from your face, focus on it, then shift focus to something across the room, then back. 10–12 times.',
			'learnMore.parts.2.exercises.1.name' => 'Coming closer',
			'learnMore.parts.2.exercises.1.text' => 'Keep looking at your finger as you slowly bring it toward the bridge of your nose, then move it back out. 10 times.',
			'learnMore.parts.2.exercises.2.name' => 'One eye at a time',
			'learnMore.parts.2.exercises.2.text' => 'Cover one eye and do the near-to-far shift, then switch. 8 times each.',
			'learnMore.parts.2.exercises.3.name' => 'Window spot',
			'learnMore.parts.2.exercises.3.text' => 'Put a small mark on a window, study it for 30 seconds, then look at something far outside, and back. 8 times.',
			'learnMore.tips' => 'A few things that help even more: good lighting, regular screen breaks, time outdoors, and letting your eyes rest often.',
			'learnMore.warningLabel' => 'Important: ',
			'learnMore.disclaimer' => 'These exercises are for general wellness and relaxation. They are not a treatment and are not intended to diagnose, cure, or prevent any medical condition. Please check with a doctor or eye-care professional before starting, especially if you have an existing eye condition. Use this app at your own discretion.',
			'permissions.noPermissionTitle' => 'No permission',
			'permissions.noPermissionSubtitle' => 'We didn\'t get permission to send notifications, so we can\'t set them up right now. You can configure permissions in your device settings.',
			'permissions.openSettings' => 'Open settings',
			'ads.introTitle' => 'Eye Helper stays free',
			'ads.introSubtitle' => 'To keep the app free for everyone, a small banner will start appearing on some screens. Your exercises and statistics are not affected.',
			'ads.introButton' => 'Got it',
			'errors.wrongWorkTime' => 'Invalid time range selected',
			_ => null,
		};
	}
}
