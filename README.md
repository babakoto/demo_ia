# demo

Jeu de memoire Flutter (Android / iOS).

## Architecture

Le code suit une clean architecture en couches, les dependances pointant
toujours vers l'interieur.

```
lib/
  core/                     # transverse, aucune logique metier
    constants/              # durees, libelles
    di/                     # get_it + injectable (di.config.dart genere)
    errors/                 # Failure partagees entre couches
    extensions/             # safeCall : exception -> Failure
    utils/                  # BlocStatus
  layers/
    domain/                 # Dart pur : entites freezed + regles du jeu
      entities/             # MemoryCardEntity, MemoryLevelEntity, MemoryBoardEntity
      repositories/         # contrats, renvoient Success<T> (= Future<Fos<Failure, T>>)
    data/                   # implemente le domaine
      dto/ errors/ repositories/ sources/locals/
    application/            # un bloc par feature
      memory_game/          # bloc + events + state freezed
    presentation/           # UI
      app.dart components/ pages/ themes/ utils/
```

| Couche       | N'importe jamais                                 |
|--------------|--------------------------------------------------|
| domain       | data, application, presentation, Flutter         |
| data         | application, presentation, Flutter               |
| application  | data, presentation                               |
| presentation | data                                             |
| core         | presentation                                     |

Ces regles sont verifiees par `test/architecture_boundaries_test.dart`
(`architecture_linter` n'est pas utilisable : sa contrainte `analyzer <7.0.0`
est incompatible avec freezed).

Les regles du jeu vivent dans `MemoryBoardEntity` sous forme de transitions
pures ; le bloc les enchaine et porte le seul effet de bord, le delai avant de
recacher une paire ratee. Les blocs ne sont pas injectables : ils sont crees
dans `presentation/components/bloc_register.dart` et tirent leurs dependances
de `getIt`.

## Commandes

```bash
flutter pub get
dart run build_runner build          # freezed + injectable
flutter analyze
flutter test                         # domaine, bloc, frontieres de couches
flutter test integration_test -d <device-id>
```
