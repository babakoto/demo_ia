import 'package:fos/fos.dart';

/// Execute [run] et convertit toute erreur inattendue en [Failure].
///
/// C'est le seul endroit ou une exception est rattrapee : au-dela de la couche
/// `data`, un echec circule sous forme de valeur (`Fos.failure`), jamais d'un
/// `throw`.
Future<Fos<Failure, T>> safeCall<T>(Future<Fos<Failure, T>> Function() run) async {
  try {
    return await run();
  } on FormatException catch (e) {
    return Fos<Failure, T>.failure(SerializationFailure(message: e.message));
  } on TypeError catch (e) {
    return Fos<Failure, T>.failure(SerializationFailure(message: e.toString()));
  } catch (e) {
    return Fos<Failure, T>.failure(UnknownFailure(message: e.toString()));
  }
}
