iwr -uri "https://github.com/HimadriChakra12/wnvsh/releases/download/reg/combined.reg" -outfile "$env:temp/combined.reg"
start-process "$env:temp/combined.reg" -verb runas
