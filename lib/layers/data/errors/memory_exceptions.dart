/// Le catalogue local ne contient aucun niveau pour cet identifiant.
///
/// Reste confinee a la couche `data` : le repository la convertit en `Failure`
/// avant de repasser la frontiere.
class LevelNotFoundException implements Exception {
  const LevelNotFoundException(this.id);

  final String id;

  @override
  String toString() => 'LevelNotFoundException(id: $id)';
}
