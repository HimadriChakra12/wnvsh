# Define the services and their desired startup types
$services = @(
    @{Name="p2psvc"; StartupType="Manual"},
    @{Name="perceptionsimulation"; StartupType="Manual"},
    @{Name="pla"; StartupType="Manual"},
    @{Name="seclogon"; StartupType="Manual"},
    @{Name="shpamsvc"; StartupType="Disabled"},
    @{Name="smphost"; StartupType="Manual"},
    @{Name="spectrum"; StartupType="Manual"},
    @{Name="sppsvc"; StartupType="AutomaticDelayedStart"},
    @{Name="ssh-agent"; StartupType="Disabled"},
    @{Name="svsvc"; StartupType="Manual"},
    @{Name="swprv"; StartupType="Manual"},
    @{Name="tiledatamodelsvc"; StartupType="Automatic"},
    @{Name="tzautoupdate"; StartupType="Disabled"},
    @{Name="uhssvc"; StartupType="Disabled"},
    @{Name="upnphost"; StartupType="Manual"},
    @{Name="vds"; StartupType="Manual"},
    @{Name="vm3dservice"; StartupType="Manual"},
    @{Name="vmicguestinterface"; StartupType="Manual"},
    @{Name="vmicheartbeat"; StartupType="Manual"},
    @{Name="vmickvpexchange"; StartupType="Manual"},
    @{Name="vmicrdv"; StartupType="Manual"},
    @{Name="vmicshutdown"; StartupType="Manual"},
    @{Name="vmictimesync"; StartupType="Manual"},
    @{Name="vmicvmsession"; StartupType="Manual"},
    @{Name="vmicvss"; StartupType="Manual"},
    @{Name="vmvss"; StartupType="Manual"},
    @{Name="wbengine"; StartupType="Manual"},
    @{Name="wcncsvc"; StartupType="Manual"},
    @{Name="webthreatdefsvc"; StartupType="Manual"},
    @{Name="webthreatdefusersvc_*"; StartupType="Automatic"},
    @{Name="wercplsupport"; StartupType="Manual"},
    @{Name="wisvc"; StartupType="Manual"},
    @{Name="wlidsvc"; StartupType="Manual"},
    @{Name="wlpasvc"; StartupType="Manual"},
    @{Name="wmiApSrv"; StartupType="Manual"},
    @{Name="workfolderssvc"; StartupType="Manual"},
    @{Name="wscsvc"; StartupType="AutomaticDelayedStart"},
    @{Name="wuauserv"; StartupType="Manual"},
    @{Name="wudfsvc"; StartupType="Manual"}
)

# Function to convert StartupType string to the expected Set-Service value
function Convert-StartupType {
    param($type)
    switch ($type.ToLower()) {
        "automatic"               { return "Automatic" }
        "manual"                  { return "Manual" }
        "disabled"                { return "Disabled" }
        "automaticdelayedstart"  { return "AutomaticDelayedStart" }
        default {
            Write-Warning "Invalid StartupType '$type'"
            return $null
        }
    }
}

foreach ($svc in $services) {
    $name = $svc.Name
    $startupType = Convert-StartupType $svc.StartupType

    if (-not $startupType) {
        Write-Warning "Skipping service '$name' due to invalid startup type."
        continue
    }

    if ($name -like "*`**") {
        # Handle wildcard names
        $matchingServices = Get-Service | Where-Object { $_.Name -like $name }
        foreach ($ms in $matchingServices) {
            try {
                Write-Output "Setting startup type of service '$($ms.Name)' to $startupType"
                Set-Service -Name $ms.Name -StartupType $startupType
            } catch {
                Write-Warning "Failed to set startup type for service '$($ms.Name)': $($_)"
            }
        }
    } else {
        $service = Get-Service -Name $name -ErrorAction SilentlyContinue
        if ($service) {
            try {
                Write-Output "Setting startup type of service '$name' to $startupType"
                Set-Service -Name $name -StartupType $startupType
            } catch {
                Write-Warning "Failed to set startup type for service '$name': $($_)"
            }
        } else {
            Write-Warning "Service '$name' not found."
        }
    }
}
