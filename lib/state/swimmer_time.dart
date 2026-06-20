import 'package:bloc/bloc.dart';

const maxDisplayMinutes = 9;
const maxDisplaySeconds = 59;

class SwimmerTimeState {
  final int minutes;
  final int seconds;

  const SwimmerTimeState(this.minutes, this.seconds);

  int getTotalSeconds() => (minutes * 60) + seconds;

  SwimmerTimeState copyWith({int? minutes, int? seconds}) {
    return SwimmerTimeState(minutes ?? this.minutes, seconds ?? this.seconds);
  }
}

class SwimmerTimeCubit extends Cubit<SwimmerTimeState> {
  SwimmerTimeCubit() : super(SwimmerTimeState(0, 0));

  void updateTime(int minutes, int seconds) {
    emit(state.copyWith(minutes: minutes, seconds: seconds));
  }

  void updateMinutes(int minutes) {
    emit(state.copyWith(minutes: minutes, seconds: state.seconds));
  }

  void updateSeconds(int seconds) {
    emit(state.copyWith(minutes: state.minutes, seconds: seconds));
  }

  void incrementMinutes() {
    if (state.minutes < maxDisplayMinutes) {
      emit(state.copyWith(minutes: state.minutes + 1, seconds: state.seconds));
    }
  }

  void decrementMinutes() {
    if (state.minutes > 0) {
      emit(state.copyWith(minutes: state.minutes - 1, seconds: state.seconds));
    }
  }

  void incrementSeconds() {
    if (state.seconds < maxDisplaySeconds) {
      emit(state.copyWith(minutes: state.minutes, seconds: state.seconds + 1));
    } else if (state.minutes < maxDisplayMinutes) {
      emit(state.copyWith(minutes: state.minutes + 1, seconds: 0));
    }
  }

  void decrementSeconds() {
    if (state.seconds > 0) {
      emit(state.copyWith(minutes: state.minutes, seconds: state.seconds - 1));
    } else if (state.minutes > 0) {
      emit(
        state.copyWith(minutes: state.minutes - 1, seconds: maxDisplaySeconds),
      );
    }
  }
}
