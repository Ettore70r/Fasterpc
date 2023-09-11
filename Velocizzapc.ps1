# Ottimizzazione del sistema operativo per le prestazioni

# Disattiva effetti visivi non essenziali
[SystemProperties]::SetVisualFXSetting(2, 0)

# Abilita l'avvio rapido
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackProgs /t REG_DWORD /d 1 /f

# Disattiva servizi non essenziali
Get-Service | Where-Object {($_.StartType -eq "Automatic") -and ($_.Name -notin @("WinDefend", "wuauserv", "wudfsvc"))} | Stop-Service -Force

# Esegui la pulizia del disco
Start-Process -FilePath "cleanmgr.exe" -ArgumentList "/sagerun:1" -Wait

# Esegui la deframmentazione del disco
Defrag C: -V

# Esegui il controllo degli errori del disco
chkdsk C: /f

# Svuota la cache DNS
ipconfig /flushdns

# Svuota il file di paging
Clear-PageFileAtShutDown

# Riavvia il computer
Restart-Computer
