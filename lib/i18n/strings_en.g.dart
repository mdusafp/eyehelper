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

	/// en: 'Repeat: 3 times.'
	String get retryThreeTimes => 'Repeat: 3 times.';

	/// en: 'Repeat: 1 time.'
	String get retryOneTime => 'Repeat: 1 time.';

	/// en: 'Repeat: 25 times.'
	String get retryTwentyFiveTimes => 'Repeat: 25 times.';

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
}

// Path: notifications
class Translations$notifications$en {
	Translations$notifications$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Reminders enabled'
	String get reminderEnabled => 'Reminders enabled';

	/// en: 'Choose the times when you're at the computer, and the app will remind you to do exercises during work hours.'
	String get chooseTime => 'Choose the times when you\'re at the computer, and the app will remind you to do exercises during work hours.';

	/// en: 'Choose the interval when you're at work'
	String get chooseWorkInterval => 'Choose the interval when you\'re at work';

	/// en: 'Apply to all'
	String get applyToAll => 'Apply to all';

	/// en: 'How often do you want the app to remind you to do the exercises?'
	String get frequencyQuestion => 'How often do you want the app to remind you to do the exercises?';

	/// en: 'Once every'
	String get timesPer => 'Once every';

	/// en: 'h'
	String get hour => 'h';

	/// en: 'min'
	String get minute => 'min';

	/// en: 'We'll remind you to do the exercises'
	String get weWillNotify => 'We\'ll remind you to do the exercises';

	/// en: 'Turn them on so the app can let you know it's time to exercise while you're at work.'
	String get enablePrompt => 'Turn them on\nso the app can let you know\nit\'s time to exercise while you\'re at work.';

	/// en: 'Enable notifications'
	String get enableButton => 'Enable notifications';

	/// en: 'Set the times you'd like to receive notifications, and the app will remind you about the exercises'
	String get setTimePrompt => 'Set the times you\'d like to receive notifications, and the app will remind you about the exercises';

	/// en: 'Specify parameters'
	String get specifyParams => 'Specify parameters';

	/// en: 'Parameters'
	String get paramsDefault => 'Parameters';

	/// en: 'Add time'
	String get addTime => 'Add time';

	/// en: 'Notifications enabled'
	String get enabledStatus => 'Notifications enabled';

	/// en: 'Notifications disabled'
	String get disabledStatus => 'Notifications disabled';

	/// en: 'Set up notifications'
	String get setupButton => 'Set up notifications';

	/// en: 'Reminder'
	String get reminderTitle => 'Reminder';

	/// en: 'Time to do your eye exercises!'
	String get reminderBody => 'Time to do your eye exercises!';
}

// Path: frequency
class Translations$frequency$en {
	Translations$frequency$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Once a day'
	String get onceADay => 'Once a day';

	/// en: 'Twice a day'
	String get twiceADay => 'Twice a day';

	/// en: 'Three times a day'
	String get threeADay => 'Three times a day';

	/// en: 'Once every two days'
	String get onceInTwoDays => 'Once every two days';

	/// en: 'Manual setup'
	String get manualSettings => 'Manual setup';

	/// en: 'hours'
	String get hoursZero => 'hours';

	/// en: 'hour'
	String get hourOne => 'hour';

	/// en: 'hours'
	String get hoursTwo => 'hours';

	/// en: 'hours'
	String get hoursFew => 'hours';

	/// en: 'hours'
	String get hoursMany => 'hours';

	/// en: 'day'
	String get dayOne => 'day';

	/// en: 'days'
	String get daysTwo => 'days';

	/// en: 'days'
	String get daysFew => 'days';
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

	/// en: 'Exercise frequency'
	String get exerciseFrequencyPerDay => 'Exercise frequency';

	/// en: 'Exercises this month'
	String get exercisePerMonth => 'Exercises this month';

	/// en: 'Responses to notifications'
	String get responsesOnPush => 'Responses to notifications';

	/// en: 'Days skipped'
	String get skippedDays => 'Days skipped';

	/// en: 'Current week'
	String get currentWeek => 'Current week';

	/// en: 'Current day'
	String get currentDay => 'Current day';

	/// en: 'Current month'
	String get currentMonth => 'Current month';

	/// en: 'Do more exercises so we can build your statistics'
	String get notEnoughData => 'Do more exercises so we can build your statistics';
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

	/// en: 'Rate the app'
	String get setMark => 'Rate the app';

	/// en: 'Would you like to rate us on {store}?'
	String wantToSetMark({required Object store}) => 'Would you like to rate us on ${store}?';

	/// en: 'You can rate our app on {store}, it will help us grow and get better'
	String rateAppSubtitle({required Object store}) => 'You can rate our app on ${store}, it will help us grow and get better';

	/// en: 'There's a cool app for eye training. I recommend downloading it! {url}'
	String shareText({required Object url}) => 'There\'s a cool app for eye training. I recommend downloading it! ${url}';

	/// en: 'Rate'
	String get value => 'Rate';

	/// en: 'Not now'
	String get notNow => 'Not now';
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
			'exercises.retryThreeTimes' => 'Repeat: 3 times.',
			'exercises.retryOneTime' => 'Repeat: 1 time.',
			'exercises.retryTwentyFiveTimes' => 'Repeat: 25 times.',
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
			'notifications.reminderEnabled' => 'Reminders enabled',
			'notifications.chooseTime' => 'Choose the times when you\'re at the computer, and the app will remind you to do exercises during work hours.',
			'notifications.chooseWorkInterval' => 'Choose the interval when you\'re at work',
			'notifications.applyToAll' => 'Apply to all',
			'notifications.frequencyQuestion' => 'How often do you want the app to remind you to do the exercises?',
			'notifications.timesPer' => 'Once every',
			'notifications.hour' => 'h',
			'notifications.minute' => 'min',
			'notifications.weWillNotify' => 'We\'ll remind you to do the exercises',
			'notifications.enablePrompt' => 'Turn them on\nso the app can let you know\nit\'s time to exercise while you\'re at work.',
			'notifications.enableButton' => 'Enable notifications',
			'notifications.setTimePrompt' => 'Set the times you\'d like to receive notifications, and the app will remind you about the exercises',
			'notifications.specifyParams' => 'Specify parameters',
			'notifications.paramsDefault' => 'Parameters',
			'notifications.addTime' => 'Add time',
			'notifications.enabledStatus' => 'Notifications enabled',
			'notifications.disabledStatus' => 'Notifications disabled',
			'notifications.setupButton' => 'Set up notifications',
			'notifications.reminderTitle' => 'Reminder',
			'notifications.reminderBody' => 'Time to do your eye exercises!',
			'frequency.onceADay' => 'Once a day',
			'frequency.twiceADay' => 'Twice a day',
			'frequency.threeADay' => 'Three times a day',
			'frequency.onceInTwoDays' => 'Once every two days',
			'frequency.manualSettings' => 'Manual setup',
			'frequency.hoursZero' => 'hours',
			'frequency.hourOne' => 'hour',
			'frequency.hoursTwo' => 'hours',
			'frequency.hoursFew' => 'hours',
			'frequency.hoursMany' => 'hours',
			'frequency.dayOne' => 'day',
			'frequency.daysTwo' => 'days',
			'frequency.daysFew' => 'days',
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
			'statistics.exerciseFrequencyPerDay' => 'Exercise frequency',
			'statistics.exercisePerMonth' => 'Exercises this month',
			'statistics.responsesOnPush' => 'Responses to notifications',
			'statistics.skippedDays' => 'Days skipped',
			'statistics.currentWeek' => 'Current week',
			'statistics.currentDay' => 'Current day',
			'statistics.currentMonth' => 'Current month',
			'statistics.notEnoughData' => 'Do more exercises so we can build your statistics',
			'finish.goodJob' => 'Great job!',
			'finish.youDoneExercises' => 'You\'ve completed the exercises. Do them more often and your eyes will thank you!',
			'finish.setMark' => 'Rate the app',
			'finish.wantToSetMark' => ({required Object store}) => 'Would you like to rate us on ${store}?',
			'finish.rateAppSubtitle' => ({required Object store}) => 'You can rate our app on ${store}, it will help us grow and get better',
			'finish.shareText' => ({required Object url}) => 'There\'s a cool app for eye training. I recommend downloading it! ${url}',
			'finish.value' => 'Rate',
			'finish.notNow' => 'Not now',
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
			'errors.wrongWorkTime' => 'Invalid time range selected',
			_ => null,
		};
	}
}
