
param(
  [string]$ProjectRoot = (Get-Location).Path
)

Write-Host "Project root: $ProjectRoot"

$manifestPath = Join-Path $ProjectRoot "android\app\src\main\AndroidManifest.xml"
$xmlDir = Join-Path $ProjectRoot "android\app\src\main\res\xml"

# Ensure xml directory exists
if (-not (Test-Path $xmlDir)) {
    New-Item -ItemType Directory -Path $xmlDir -Force | Out-Null
    Write-Host "Created: $xmlDir"
} else {
    Write-Host "Exists: $xmlDir"
}

# Backup existing AndroidManifest.xml
if (Test-Path $manifestPath) {
  $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
  $backupPath = "$manifestPath.bak.$timestamp"
  Copy-Item $manifestPath $backupPath -Force
  Write-Host "Backup created: $backupPath"
} else {
  Write-Host "No existing AndroidManifest.xml found; will create new one."
}

# Write new AndroidManifest.xml
@@'
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <!-- Permissions لازم -->
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" android:maxSdkVersion="32" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" android:maxSdkVersion="32" />
    <uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
    <uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />
    <uses-permission android:name="android.permission.READ_MEDIA_AUDIO" />
    <uses-permission android:name="android.permission.INTERNET"/>

    <application
        android:label="Tablo"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
        android:requestLegacyExternalStorage="true">

        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|screenSize|locale|layoutDirection|fontScale|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">

            <meta-data
                android:name="io.flutter.embedding.android.NormalTheme"
                android:resource="@style/NormalTheme" />

            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>

        <provider
            android:name="androidx.core.content.FileProvider"
            android:authorities="${applicationId}.fileprovider"
            android:exported="false"
            android:grantUriPermissions="true">
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                android:resource="@xml/file_paths" />
        </provider>
    </application>
</manifest>
'@ | Set-Content -Path $manifestPath -Encoding UTF8
Write-Host "Wrote: $manifestPath"

# Write xml files
$filePaths = Join-Path $xmlDir "file_paths.xml"
$backupRules = Join-Path $xmlDir "backup_rules.xml"
$dataExtraction = Join-Path $xmlDir "data_extraction_rules.xml"

@@'
<?xml version="1.0" encoding="utf-8"?>
<paths xmlns:android="http://schemas.android.com/apk/res/android">
    <cache-path name="cache" path="." />
    <external-path name="external" path="." />
    <files-path name="files" path="." />
    <external-cache-path name="external_cache" path="." />
</paths>
'@ | Set-Content -Path $filePaths -Encoding UTF8
Write-Host "Wrote: $filePaths"

@@'
<?xml version="1.0" encoding="utf-8"?>
<full-backup-content>
    <include domain="file" path="." />
    <include domain="database" path="." />
    <include domain="sharedpref" path="." />
</full-backup-content>
'@ | Set-Content -Path $backupRules -Encoding UTF8
Write-Host "Wrote: $backupRules"

@@'
<?xml version="1.0" encoding="utf-8"?>
<data-extraction-rules>
    <cloud-backup>
        <include domain="file" path="." />
        <include domain="database" path="." />
    </cloud-backup>
    <device-transfer>
        <include domain="file" path="." />
        <include domain="database" path="." />
    </device-transfer>
</data-extraction-rules>
'@ | Set-Content -Path $dataExtraction -Encoding UTF8
Write-Host "Wrote: $dataExtraction"

Write-Host "`nDone. Next steps:"
Write-Host "  1) Verify android/app/build.gradle defaultConfig (applicationId, minSdk, targetSdk)."
Write-Host "  2) Run: flutter clean && flutter pub get"
Write-Host "  3) Run on device: flutter run -d RZ8M93GN6NT"
