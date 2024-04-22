#!/bin/bash
cd ../
#rm -fr ~/.pub-cache/
dart pub cache repair
flutter clean
rm -f pubspec.lock
flutter pub get
