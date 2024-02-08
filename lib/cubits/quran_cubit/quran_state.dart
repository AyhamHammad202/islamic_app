part of 'quran_cubit.dart';

@immutable
sealed class QuranState {}

final class QuranInitial extends QuranState {}

final class QuranLoading extends QuranState {}

final class QuranDone extends QuranState {}
final class QuranPageChanged extends QuranState {}
final class QuranPageChangedDone extends QuranState {}

final class QuranFailure extends QuranState {
  final Exception exception;

  QuranFailure({required this.exception});
}

final class QuranSearch extends QuranState {}

final class LastRead extends QuranState {}
