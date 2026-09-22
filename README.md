# demo

A new Flutter project.

## Langues

L'application est traduite en francais, anglais et chinois. Elle suit la langue
du systeme au demarrage ; le selecteur de la barre superieure permet d'en
choisir une autre.

Les textes vivent dans `lib/l10n/app_<langue>.arb` (`app_fr.arb` fait office de
modele). Apres modification d'un fichier ARB :

```bash
flutter gen-l10n
```

Pour ajouter une langue : creer `lib/l10n/app_<code>.arb`, relancer la commande
ci-dessus, ajouter le nom de la langue dans `LanguageMenu.displayName` et le
code dans `CFBundleLocalizations` (`ios/Runner/Info.plist`).

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
