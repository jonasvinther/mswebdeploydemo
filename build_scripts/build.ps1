param(
    [Parameter(Position=0)]
    [string] $project_path
)

&"C:/Program Files (x86)/Microsoft Visual Studio/2017/BuildTools/MSBuild/15.0/Bin/amd64/MSBuild.exe" `
${project_path}/WebApplication1.csproj `
/v:detailed /t:ReBuild;Package /p:Configuration=Release