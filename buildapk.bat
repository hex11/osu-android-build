@echo off

set KEY_PATH=key.keystore
set KEY_ALIAS=hex11
set KEY_PASS=

echo Build and sign apk...
echo.

nuget restore "osu\osu.Android.sln" || exit 10

msbuild /t:SignAndroidPackage /p:Configuration=Release /p:Platform=AnyCPU /p:AndroidKeyStore=true /p:AndroidSigningKeyAlias=%KEY_ALIAS% /p:AndroidSigningKeyPass=%KEY_PASS% /p:AndroidSigningKeyStore=%KEY_PATH% /p:AndroidSigningStorePass=%KEY_PASS% "osu\osu.Android\osu.Android.csproj" || exit 30

copy "osu\osu.Android\bin\Release\ppy.osu.lazer-Signed.apk" ".\ppy.osu.lazer.apk" || exit 40
:: copy "osu\osu.Android\bin\Release\ppy.osu.lazer.apk" ".\ppy.osu.lazer-Unsigned.apk" || exit 41
