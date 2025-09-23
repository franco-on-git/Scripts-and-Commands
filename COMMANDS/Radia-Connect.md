# Radia Connect Command

> [!NOTE]
> - Starts RadiaConnect agent and runs updates.

## Copy Code:
```
cmd.exe /c "C:\Program Files (x86)\Novadigm\radntfyc.exe" localhost radskman hreboot=Y,context=M,mname=RADIA,dname=SOFTWARE,log=connect_machine.log,logsize=10000000,uid=$MACHINE,cat=prompt,rtimeout=120,sendcat=Y,ask=Y,cop=Y,MNT=Y,jobid=CONNECT_ICON
```
