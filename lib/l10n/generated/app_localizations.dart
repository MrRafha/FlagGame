import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In pt, this message translates to:
  /// **'Flag Game'**
  String get appTitle;

  /// No description provided for @startGame.
  ///
  /// In pt, this message translates to:
  /// **'Começar'**
  String get startGame;

  /// No description provided for @mapReady.
  ///
  /// In pt, this message translates to:
  /// **'O mapa está pronto para ganhar cores.'**
  String get mapReady;

  /// No description provided for @randomMode.
  ///
  /// In pt, this message translates to:
  /// **'Modo aleatório'**
  String get randomMode;

  /// No description provided for @localRanking.
  ///
  /// In pt, this message translates to:
  /// **'Ranking local'**
  String get localRanking;

  /// No description provided for @settings.
  ///
  /// In pt, this message translates to:
  /// **'Configurações'**
  String get settings;

  /// No description provided for @chooseContinent.
  ///
  /// In pt, this message translates to:
  /// **'Escolha um continente'**
  String get chooseContinent;

  /// No description provided for @configureGame.
  ///
  /// In pt, this message translates to:
  /// **'Configurar partida'**
  String get configureGame;

  /// No description provided for @gameMode.
  ///
  /// In pt, this message translates to:
  /// **'Modo'**
  String get gameMode;

  /// No description provided for @random.
  ///
  /// In pt, this message translates to:
  /// **'Aleatório'**
  String get random;

  /// No description provided for @byContinent.
  ///
  /// In pt, this message translates to:
  /// **'Por continente'**
  String get byContinent;

  /// No description provided for @continent.
  ///
  /// In pt, this message translates to:
  /// **'Continente'**
  String get continent;

  /// No description provided for @difficulty.
  ///
  /// In pt, this message translates to:
  /// **'Dificuldade'**
  String get difficulty;

  /// No description provided for @easy.
  ///
  /// In pt, this message translates to:
  /// **'Fácil'**
  String get easy;

  /// No description provided for @hard.
  ///
  /// In pt, this message translates to:
  /// **'Difícil'**
  String get hard;

  /// No description provided for @duration.
  ///
  /// In pt, this message translates to:
  /// **'Duração'**
  String get duration;

  /// No description provided for @seconds30.
  ///
  /// In pt, this message translates to:
  /// **'30 segundos'**
  String get seconds30;

  /// No description provided for @seconds60.
  ///
  /// In pt, this message translates to:
  /// **'60 segundos'**
  String get seconds60;

  /// No description provided for @minutes3.
  ///
  /// In pt, this message translates to:
  /// **'3 minutos'**
  String get minutes3;

  /// No description provided for @minutes5.
  ///
  /// In pt, this message translates to:
  /// **'5 minutos'**
  String get minutes5;

  /// No description provided for @startMatch.
  ///
  /// In pt, this message translates to:
  /// **'Iniciar partida'**
  String get startMatch;

  /// No description provided for @game.
  ///
  /// In pt, this message translates to:
  /// **'Partida'**
  String get game;

  /// No description provided for @dragInstruction.
  ///
  /// In pt, this message translates to:
  /// **'Arraste a bandeira até o território correspondente.'**
  String get dragInstruction;

  /// No description provided for @correct.
  ///
  /// In pt, this message translates to:
  /// **'Acerto!'**
  String get correct;

  /// No description provided for @tryAgain.
  ///
  /// In pt, this message translates to:
  /// **'Tente novamente.'**
  String get tryAgain;

  /// No description provided for @results.
  ///
  /// In pt, this message translates to:
  /// **'Resultados'**
  String get results;

  /// No description provided for @score.
  ///
  /// In pt, this message translates to:
  /// **'Pontuação'**
  String get score;

  /// No description provided for @presentedFlags.
  ///
  /// In pt, this message translates to:
  /// **'Bandeiras apresentadas'**
  String get presentedFlags;

  /// No description provided for @correctAnswers.
  ///
  /// In pt, this message translates to:
  /// **'Acertos'**
  String get correctAnswers;

  /// No description provided for @incorrectAttempts.
  ///
  /// In pt, this message translates to:
  /// **'Erros'**
  String get incorrectAttempts;

  /// No description provided for @accuracy.
  ///
  /// In pt, this message translates to:
  /// **'Precisão'**
  String get accuracy;

  /// No description provided for @playAgain.
  ///
  /// In pt, this message translates to:
  /// **'Jogar novamente'**
  String get playAgain;

  /// No description provided for @viewRanking.
  ///
  /// In pt, this message translates to:
  /// **'Ver ranking'**
  String get viewRanking;

  /// No description provided for @backToMenu.
  ///
  /// In pt, this message translates to:
  /// **'Voltar ao menu'**
  String get backToMenu;

  /// No description provided for @noResults.
  ///
  /// In pt, this message translates to:
  /// **'Ainda não há resultados.'**
  String get noResults;

  /// No description provided for @language.
  ///
  /// In pt, this message translates to:
  /// **'Idioma'**
  String get language;

  /// No description provided for @portuguese.
  ///
  /// In pt, this message translates to:
  /// **'Português'**
  String get portuguese;

  /// No description provided for @english.
  ///
  /// In pt, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @spanish.
  ///
  /// In pt, this message translates to:
  /// **'Español'**
  String get spanish;

  /// No description provided for @mapLoadError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível carregar o mapa.'**
  String get mapLoadError;

  /// No description provided for @africa.
  ///
  /// In pt, this message translates to:
  /// **'África'**
  String get africa;

  /// No description provided for @america.
  ///
  /// In pt, this message translates to:
  /// **'América'**
  String get america;

  /// No description provided for @asia.
  ///
  /// In pt, this message translates to:
  /// **'Ásia'**
  String get asia;

  /// No description provided for @europe.
  ///
  /// In pt, this message translates to:
  /// **'Europa'**
  String get europe;

  /// No description provided for @oceania.
  ///
  /// In pt, this message translates to:
  /// **'Oceania'**
  String get oceania;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
