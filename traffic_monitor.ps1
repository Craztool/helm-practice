Write-Host "Запуск радара трафика..." -ForegroundColor Cyan
Write-Host "Легенда: " -NoNewline
Write-Host "B " -ForegroundColor Blue -NoNewline
Write-Host "= Версия Blue (старая), " -NoNewline
Write-Host "G " -ForegroundColor Green -NoNewline
Write-Host "= Версия Green (новая), " -NoNewline
Write-Host ". " -ForegroundColor Gray -NoNewline
Write-Host "= Неизвестная версия, " -NoNewline
Write-Host "X " -ForegroundColor Red -NoNewline
Write-Host "= Ошибка подключения"

$counter = 0

while ($true) {
    try {
        $response = Invoke-RestMethod -Uri "http://helm.local" -TimeoutSec 2 -ErrorAction Stop
        
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
