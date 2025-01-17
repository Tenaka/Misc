<#
This value determines whether the system uses automatic proxy detection.
Proxy auto-detection is based on the Web Proxy Auto-Discovery Protocol (WPAD). WPAD allows a system to discover a proxy server using methods like DHCP or DNS to locate a WPAD configuration file.
Data: 0

A value of 0 (disabled) means the system will not attempt to automatically detect proxy settings.
This disables the automatic retrieval of proxy configuration scripts via WPAD.
If the user or an administrator has explicitly configured a proxy server or PAC file, that configuration will still be used.


0 to disable automatic proxy detection.
1 to enable automatic proxy detection.
#>

$regPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\"
$regName = "AutoDetect"
$regValue = "0"

try
    {
        $gtEnableProxyRes = Get-ItemPropertyValue $regPath -name $regName -ErrorAction Stop

    }
catch
    {
        New-ItemProperty $regPath  -name $regName -Value $regValue -Force
    }


$gtEnableProxyRes = Get-ItemPropertyValue $regPath -name $regName -ErrorAction Stop


if (!($gtEnableProxyRes -eq $regValue))
    {
       New-ItemProperty $regPath  -name $regName -Value $regValue -Force
    }


    