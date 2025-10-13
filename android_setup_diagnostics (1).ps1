
param(
  [string]$ProjectRoot = (Get-Location).Path
)

Write-Host "=== Android Setup Diagnostics for Flutter Project ==="
Write-Host "Project root: $ProjectRoot"
Write-Host ""

function Test-Path-Report($path, $desc) {
  if (Test-Path $path) {
    Write-Host "[OK] $desc: $path"
  } else {
    Write-Host "[MISSING] $desc NOT FOUND: $path"
  }
}

# Key paths
$manifestPath      = Join-Path $ProjectRoot "android\app\src\main\AndroidManifest.xml"
$xmlDir            = Join-Path $ProjectRoot "android\app\src\main\res\xml"
$filePaths         = Join-Path $xmlDir "file_paths.xml"
$backupRules       = Join-Path $xmlDir "backup_rules.xml"
$dataExtraction    = Join-Path $xmlDir "data_extraction_rules.xml"
$appBuildGradle    = Join-Path $ProjectRoot "android\app\build.gradle"
$rootBuildGradle   = Join-Path $ProjectRoot "android\build.gradle"

# Check existence
Test-Path-Report $manifestPath "AndroidManifest.xml"
Test-Path-Report $xmlDir "res\xml folder"
Test-Path-Report $filePaths "file_paths.xml"
Test-Path-Report $backupRules "backup_rules.xml"
Test-Path-Report $dataExtraction "data_extraction_rules.xml"
Test-Path-Report $appBuildGradle "android\app\build.gradle"
Test-Path-Report $rootBuildGradle "android\build.gradle"

Write-Host ""
Write-Host "=== Extract applicationId from android\app\build.gradle ==="
if (Test-Path $appBuildGradle) {
  $gradle = Get-Content $appBuildGradle -Raw
  $appIdMatch = [regex]::Match($gradle, 'applicationId\s+\"([^\"]+)\"')
  if ($appIdMatch.Success) {
    $applicationId = $appIdMatch.Groups[1].Value
    Write-Host "applicationId: $applicationId"
  } else {
    Write-Host "applicationId NOT found in app/build.gradle"
  }
} else {
  Write-Host "app/build.gradle not found."
}

Write-Host ""
Write-Host "=== Check AndroidManifest package and FileProvider authorities ==="
if (Test-Path $manifestPath) {
  $manifest = Get-Content $manifestPath -Raw
  $pkgMatch = [regex]::Match($manifest, '<manifest[^>]*\s+package\s*=\s*\"([^\"]+)\"')
  if ($pkgMatch.Success) {
    $manifestPkg = $pkgMatch.Groups[1].Value
    Write-Host "manifest package: $manifestPkg"
  } else {
    Write-Host "No 'package' attribute found on <manifest>. (Flutter can work without it, but ensure provider authorities use \${applicationId})"
  }

  $authMatch = [regex]::Match($manifest, 'android:authorities\s*=\s*\"([^\"]+)\"')
  if ($authMatch.Success) {
    Write-Host "FileProvider authorities: " $authMatch.Groups[1].Value
  } else {
    Write-Host "No FileProvider authorities found."
  }
}

Write-Host ""
Write-Host "=== Locate MainActivity.kt and package path ==="
$kotlinRoot = Join-Path $ProjectRoot "android\app\src\main\kotlin"
if (Test-Path $kotlinRoot) {
  $mainActivity = Get-ChildItem -Path $kotlinRoot -Recurse -Filter "MainActivity.kt" | Select-Object -First 1
  if ($mainActivity) {
    Write-Host "MainActivity.kt: " $mainActivity.FullName
    $mainContent = Get-Content $mainActivity.FullName -Raw
    $pkgDecl = [regex]::Match($mainContent, 'package\s+([A-Za-z0-9_.]+)')
    if ($pkgDecl.Success) {
      $mainPkg = $pkgDecl.Groups[1].Value
      Write-Host "MainActivity package: $mainPkg"
    } else {
      Write-Host "No package declaration found in MainActivity.kt"
    }
  } else {
    Write-Host "MainActivity.kt not found under kotlin/"
  }
} else {
  Write-Host "kotlin/ source folder not found."
}

Write-Host ""
Write-Host "=== Version checks ==="
try {
  flutter --version
} catch {
  Write-Host "flutter command not found in PATH."
}

try {
  & "$ProjectRoot\android\gradlew.bat" -v
} catch {
  Write-Host "gradlew not runnable (try from android/ folder)."
}

try {
  java -version
} catch {
  Write-Host "java not found in PATH."
}

Write-Host ""
Write-Host "=== Suggested next steps ==="
Write-Host "1) If applicationId != MainActivity package, fix one of them to match (recommended: set applicationId and ensure MainActivity path aligns)."
Write-Host "2) Ensure FileProvider authorities are \${applicationId}.fileprovider"
Write-Host "3) Run: flutter clean && flutter pub get"
Write-Host "4) Run on device: flutter run -d RZ8M93GN6NT -v (for verbose logs)"
Write-Host "5) If build fails, check compileSdk/targetSdk in android/build.gradle (compileSdkVersion 34 recommended)."
