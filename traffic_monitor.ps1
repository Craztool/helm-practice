Write-Host "Starting traffic radar..." -ForegroundColor Cyan
Write-Host "Legend: " -NoNewline
Write-Host "B " -ForegroundColor Blue -NoNewline
Write-Host "= Version Blue (old), " -NoNewline
Write-Host "G " -ForegroundColor Green -NoNewline
Write-Host "= Version Green (new), " -NoNewline
Write-Host ". " -ForegroundColor Gray -NoNewline
Write-Host "= Unknown version, " -NoNewline
Write-Host "X " -ForegroundColor Red -NoNewline
Write-Host "= Connection Error"

$counter = 0

while ($true) {
    try {
        $response = (Invoke-WebRequest -Uri "http://helm.local" -UseBasicParsing -TimeoutSec 2 -ErrorAction Stop).Content
        
        if ($response -match "Blue") {
            Write-Host "B " -ForegroundColor Blue -NoNewline
        } elseif ($response -match "Green") {
            Write-Host "G " -ForegroundColor Green -NoNewline
        } else {
            Write-Host ". " -ForegroundColor Gray -NoNewline
        }
    } catch {
        Write-Host "X " -ForegroundColor Red -NoNewline
    }

    $counter++
    if ($counter -ge 40) {
        Write-Host "" # Перенос строки
        $counter = 0
    }
    
    Start-Sleep -Milliseconds 150
}
