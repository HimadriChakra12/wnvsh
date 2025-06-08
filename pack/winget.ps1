#Winget
start-process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command "wsreset -i"' -wait -verb RunAs
write-host "Wait, installing Microsoft Store"
$read = read-host "Is It installed?"
switch ($read){
    y{
        start-process "https://apps.microsoft.com/detail/9nblggh4nns1?hl=en-US&gl=US"
            $read = read-host "Winget got installed?[y]"
            switch ($read){
                y{
                    Start-Process powershell -ArgumentList '-noexit -NoProfile -ExecutionPolicy Bypass -Command "iwr -useb "https://github.com/HimadriChakra12/Himutil/raw/refs/heads/master/Him/install.ps1" | iex"' -Verb RunAs -wait
                }
            }
    }
}

