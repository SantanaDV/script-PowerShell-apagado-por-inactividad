# PowerShell Auto Shutdown por Inactividad

Este script de PowerShell monitorea el tiempo de inactividad del usuario en el sistema y apaga automáticamente el equipo si se supera un tiempo límite especificado (por defecto, 1 hora).

##  Descripción

El script utiliza funciones de la API de Windows (`user32.dll`) para obtener el tiempo transcurrido desde la última interacción del usuario (teclado o ratón). Si el usuario permanece inactivo durante más tiempo del configurado, el sistema se apagará automáticamente.

##  Cómo funciona

1. Se define una clase `IdleTime` en C# embebida dentro del script, que utiliza la función `GetLastInputInfo` de la API de Windows.
2. Se calcula el tiempo de inactividad en segundos.
3. Si el tiempo de inactividad excede el límite definido (por defecto `3600` segundos), el script ejecuta un apagado inmediato del sistema.
4. Mientras tanto, muestra cada segundo el tiempo actual de inactividad y el tiempo restante antes del apagado.

##  Configuración

Puedes cambiar el tiempo de inactividad máximo antes del apagado modificando el valor de la variable `$limite` (en segundos):

```powershell
$limite = 3600  # 1 hora

$limite = 1800 # 30 minutos
```

## Requisitos

* PowerShell (v5.1 o superior recomendado)

* Permisos de administrador para ejecutar shutdown

## Ejecución

Guarda el script con extensión .ps1 y ejecútalo desde PowerShell con permisos elevados:

```powershell
powershell -ExecutionPolicy Bypass -File ruta\al\script.ps1

```

## Crear un acceso directo en el escritorio

Si deseas ejecutar este script fácilmente desde un icono, sigue estos pasos:

1. Guarda el script en una ubicación fija, por ejemplo: C:\Scripts\AutoShutdown.ps1.

2. Haz clic derecho en el escritorio y selecciona Nuevo → Acceso directo.

3. En la ubicación del acceso directo, escribe lo siguiente, reemplazando la ruta por la ruta de tu script:
```arduino
powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File "C:\Scripts\AutoShutdown.ps1"

```
4. Haz clic en Siguiente y ponle un nombre al acceso directo, por ejemplo: Apagado por inactividad.

5. (Opcional) Haz clic derecho sobre el acceso directo → Propiedades → pestaña Acceso directo → botón Cambiar icono para personalizar el icono.

6. (Opcional) Puedes configurarlo para que se ejecute como administrador desde la pestaña Compatibilidad marcando "Ejecutar este programa como administrador".

## ⚠️ Advertencia: 
Este script forzará el apagado del sistema (shutdown /s /f /t 0), cerrando todas las aplicaciones sin guardar el trabajo. Úsalo con precaución.