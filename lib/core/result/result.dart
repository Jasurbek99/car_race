import '../error/failure.dart' as core_failure;

sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is ResultFailure<T>;

  T? get data => switch (this) {
        Success(value: final data) => data,
        _ => null,
      };

  core_failure.Failure? get error => switch (this) {
        ResultFailure(failure: final error) => error,
        _ => null,
      };

  R when<R>({
    required R Function(T data) success,
    required R Function(core_failure.Failure failure) failure,
  }) {
    return switch (this) {
      Success(value: final data) => success(data),
      ResultFailure(failure: final error) => failure(error),
    };
  }
}

class Success<T> extends Result<T> {
  final T value;

  const Success(this.value);

  @override
  String toString() => 'Success($value)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Success<T> &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

class ResultFailure<T> extends Result<T> {
  final core_failure.Failure failure;

  const ResultFailure(this.failure);

  @override
  String toString() => 'Failure($failure)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultFailure<T> &&
          runtimeType == other.runtimeType &&
          failure == other.failure;

  @override
  int get hashCode => failure.hashCode;
}
