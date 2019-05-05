# Gnan-G

Gnan-G GAME - Frontend

## Installation

GnanG requires Flutter SDK v1.0 to run.

Install the dependencies to run app - 

```bash
$ flutter packages get
$ flutter run
```

## For IOS

Run
```bash
$ flutter doctor 
```

and install everything that flutter doctor says

### iOS Release
1. Run
` flutter build ios --release`
2. Make sure the signing certificates and provisioning profiles are selected correctly
3. Build iOS app
4. Archive and Export

Version numbers are taken from Generated.xcconfig, so ensure it has the correct version numbers.
