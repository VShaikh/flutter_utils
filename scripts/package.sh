#!/bin/bash
cd ../
flutter build apk --release --split-per-abi
rm -f /home/vahid/Documents/MediaFiApp.apk
cp build/app/outputs/apk/release/app-armeabi-v7a-release.apk /home/vahid/Documents/MediaFiApp.apk
cp /home/vahid/Documents/MediaFiApp.apk /run/user/1000/gvfs/google-drive:host=gmail.com,user=meet2vah1d/0APAO6407KJdjUk9PVA/1br-LlPzDej_pI2oDGGDPdrxiPbmKh1jp
