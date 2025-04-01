Add-Type @"
using System;
using System.Runtime.InteropServices;
public class IdleTime {
    [DllImport("user32.dll")]
    public static extern bool GetLastInputInfo(ref LASTINPUTINFO plii);

    public struct LASTINPUTINFO {
        public uint cbSize;
        public uint dwTime;
    }

    public static uint GetIdleTime() {
        LASTINPUTINFO lii = new LASTINPUTINFO();
        lii.cbSize = (uint)Marshal.SizeOf(lii);
        GetLastInputInfo(ref lii);
        return ((uint)Environment.TickCount - lii.dwTime) / 1000;
    }
}
"@

$limite = 3600  # Tiempo límite en segundos (1 hora)

while ($true) {
    $idleTime = [IdleTime]::GetIdleTime()
    $tiempoRestante = $limite - $idleTime

    if ($tiempoRestante -le 0) {
        Write-Host "`nApagando equipo por inactividad..." -ForegroundColor Red
        shutdown /s /f /t 0
        break
    }

    $min = [int]($tiempoRestante / 60)
    $sec = $tiempoRestante % 60

    Write-Host ("Tiempo inactivo: $idleTime segundos | Apagado en: {0:D2}:{1:D2}" -f $min, $sec) -ForegroundColor Yellow
    Start-Sleep -Seconds 1
}
