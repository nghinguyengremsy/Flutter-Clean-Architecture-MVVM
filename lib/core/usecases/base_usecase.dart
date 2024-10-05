import 'dart:async';

abstract class BaseUsecase<Input, Output> {
  FutureOr<Output> call(Input input);
}
