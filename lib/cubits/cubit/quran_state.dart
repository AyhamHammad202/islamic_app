part of 'quran_cubit.dart';

@immutable
sealed class QuranState {}

final class QuranInitial extends QuranState {}
final class QuranDone extends QuranState {}
final class QuranSearch extends QuranState {}
