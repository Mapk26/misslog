# MissLog

A log printer for Flutter.

## Getting Started

Include MissLog in you pubspec:

```yaml
misslog: ^1.0.0
```

## Usage

Simply call the MissLog static functions:

```dart
MissLog.d('Your debug message', tag: '$runtimeType',);
MissLog.i('Your info message', tag: '$runtimeType',);
MissLog.e('Your error message', tag: '$runtimeType',);
MissLog.w('Your warning message', tag: '$runtimeType',);
```

Where on place of runtimeType you can use whatever tag you prefer.
Using runtimType the classname will be used.
