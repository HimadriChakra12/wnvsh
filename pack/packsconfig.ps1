#choco
choco feature enable --name=allowGlobalConfirmation
choco feature enable --name=useRememberedArgumentsForUpgrades
choco feature enable --name=usePackageExitCodes
choco feature enable --name=useEnhancedExitCodes
choco feature enable --name=showDownloadProgress
choco config set cacheLocation C:\choco-cache
choco config set commandExecutionTimeoutSeconds 99999
choco config set webRequestTimeoutSeconds 99999
choco config set virusCheck false
choco config set proxyCacheLocation C:\choco-cache
#scoop
scoop bucket add extras
scoop bucket add versions
scoop bucket add nerd-fonts
scoop bucket add java
scoop bucket add games   

scoop update
scoop upgrade --all
scoop cleanup --all
