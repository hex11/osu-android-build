@echo off
echo Build and sign apk...
echo.

nuget restore "osu\osu.Android.sln" || exit 10

set KEY_PATH=key.keystore

appveyor-tools\secure-file -decrypt %KEY_PATH%.enc -secret %apksign_keystore_secret% -out %KEY_PATH% || exit 20

msbuild /t:SignAndroidPackage /p:Configuration=Release /p:AndroidKeyStore=true /p:AndroidSigningKeyAlias=hex11 /p:AndroidSigningKeyPass=%apksign_keystore_pass% /p:AndroidSigningKeyStore="%CD%\%KEY_PATH%" /p:AndroidSigningStorePass=%apksign_keystore_pass% "osu\osu.Android\osu.Android.csproj" || exit 30

copy "osu\osu.Android\bin\Release\ppy.osu.lazer-Signed.apk" ".\ppy.osu.lazer.apk" || exit 40
