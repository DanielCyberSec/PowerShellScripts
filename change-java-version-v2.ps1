#################################################
#	DanielCyberSec PowerShell Scripts	#
#################################################
# Encoding UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Función para establecer variables de entorno con manejo de errores
function Set-EnvironmentVariable {
    param (
        [string]$variable,
        [string]$value
    )
    
    try {
        [Environment]::SetEnvironmentVariable($variable, $value, "Machine")
        Write-Host "Se estableció $variable a $value correctamente."
    } catch {
        Write-Host "Error: No se pudo establecer $variable. Acceso denegado, se requieren permisos de administrador." -ForegroundColor Red
        exit 1
    }
}

# Función para actualizar el PATH sin sobrescribir las rutas existentes
function Update-Path {
    # Obtener el valor actual de PATH
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
    
    # Verificar si el PATH ya contiene la ruta de Java %JAVA_HOME%\bin para evitar duplicados
    if ($currentPath -notlike "*%JAVA_HOME%\bin*") {
        # Añadir %JAVA_HOME%\bin al principio del PATH, conservando el valor anterior
        $updatedPath = "%JAVA_HOME%\bin;$currentPath"
        Set-EnvironmentVariable "Path" $updatedPath
    } else {
        Write-Host "El PATH ya contiene la ruta de %JAVA_HOME%\bin"
    }
}

# Aquí se enlistan las rutas de las versiones que tienes instaladas de Java
$java1_8 = "C:\Program Files\Java\jdk-1.8"
$java17 = "C:\Program Files\Java\jdk-17"

# Pedir al usuario que elija la versión de Java
Write-Host "Seleccione la versión de Java que desea usar:"
Write-Host "1) Java 1.8"
Write-Host "2) Java 17"
$choice = Read-Host "Ingrese el número de su elección"

# Cambiar JAVA_HOME y actualizar el PATH según la elección
if ($choice -eq 1) {
    Set-EnvironmentVariable "JAVA_HOME" $java1_8
    Update-Path
    Write-Host "JAVA_HOME se ha cambiado a Java 1.8, Cierre y vuelva a abrir la terminal o el IDE."
} elseif ($choice -eq 2) {
    Set-EnvironmentVariable "JAVA_HOME" $java17
    Update-Path
    Write-Host "JAVA_HOME se ha cambiado a Java 17, Cierre y vuelva a abrir la terminal o el IDE."
} else {
    Write-Host "Opción inválida. No se realizó ningún cambio." -ForegroundColor Red
}
