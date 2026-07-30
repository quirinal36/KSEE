# ─────────────────────────────────────────────────────────────
# KSEE 로컬 실행 스크립트 (Windows PowerShell)
#   - Temurin JDK 8 + Maven + cargo(Tomcat 9) 조합으로 로컬 구동
#   - 사용법:  pwsh -File run-local.ps1
#   - 접속:    http://localhost:8080/
#   - 종료:    Ctrl + C
# ─────────────────────────────────────────────────────────────

$ErrorActionPreference = "Stop"

# JDK 8 (Temurin) 경로 자동 탐지
$jdk = Get-ChildItem "C:\Program Files\Eclipse Adoptium" -Directory -ErrorAction SilentlyContinue |
       Where-Object { $_.Name -like "jdk-8*" } | Select-Object -First 1
if (-not $jdk) { throw "JDK 8(Temurin)을 찾을 수 없습니다. 설치를 확인하세요." }
$env:JAVA_HOME = $jdk.FullName
$env:Path = "$($jdk.FullName)\bin;" + [Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [Environment]::GetEnvironmentVariable("Path","User")

Write-Host "JAVA_HOME = $env:JAVA_HOME" -ForegroundColor Cyan
Set-Location $PSScriptRoot

# 프로젝트 루트 .env를 Tomcat 자식 프로세스에 전달한다.
# 값 자체는 로그에 출력하지 않는다.
$envFilePath = Join-Path $PSScriptRoot ".env"
if (Test-Path -LiteralPath $envFilePath) {
    foreach ($envEntry in Get-Content -LiteralPath $envFilePath) {
        if ($envEntry -match '^\s*(?:export\s+)?([A-Za-z_][A-Za-z0-9_]*)\s*=\s*(.*)\s*$') {
            $envName = $matches[1]
            $envValue = $matches[2].Trim()
            if (($envValue.StartsWith('"') -and $envValue.EndsWith('"')) -or
                ($envValue.StartsWith("'") -and $envValue.EndsWith("'"))) {
                $envValue = $envValue.Substring(1, $envValue.Length - 2)
            }
            Set-Item -Path ("Env:" + $envName) -Value $envValue
        }
    }
    if ($env:OPENROUTER_API_KEY) {
        Write-Host "OPENROUTER_API_KEY loaded from .env" -ForegroundColor Green
    }
}

# 빌드 후 Tomcat 9 자동 다운로드 → WAR를 ROOT(/)로 배포 → 구동
mvn clean package -DskipTests cargo:run
