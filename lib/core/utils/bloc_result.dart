/// Etat d'un flux asynchrone porte par un bloc.
///
/// Toutes les features partagent ce vocabulaire : l'UI se contente de tester
/// `status.isLoading` / `isSuccess` / `isFailure`.
enum BlocStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == BlocStatus.initial;

  bool get isLoading => this == BlocStatus.loading;

  bool get isSuccess => this == BlocStatus.success;

  bool get isFailure => this == BlocStatus.failure;
}
