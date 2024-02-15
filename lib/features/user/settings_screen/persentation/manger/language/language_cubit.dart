import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_state.dart';

enum Language { english, arabic }

class LanguageCubit extends Cubit<Language> {
  LanguageCubit() : super(Language.english) {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedLanguage = prefs.getString('language');
    if (savedLanguage != null) {
      emit(Language.values
          .firstWhere((lang) => lang.toString() == savedLanguage));
    }
  }

  Future<void> toggleLanguage(Language language) async {
    emit(language);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language.toString());
  }
}
