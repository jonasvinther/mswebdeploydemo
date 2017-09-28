param(
    [Parameter(Position=0)]
    [string] $project_path,

    [Parameter(Position=1)]
    [string] $IISURL,

    [Parameter(Position=2)]
    [string] $IISUSER,

    [Parameter(Position=3)]
    [string] $IISPWD
)

& "$project_path/obj/Release/Package/WebApplication1.deploy.cmd" `
/Y "-setParam:name='IIS Web Application Name',value='test'" `
/M:'"$IISURL/msdeploy.axd?site=test"' -allowUntrusted /U:"$IISUSER" /P:"$IISPWD" /A:"Basic"