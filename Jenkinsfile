node("windows") {

    def build_scripts_path = pwd() + "/build_scripts"
    def project_path = pwd() + "/WebApplication1"
    def workspacePath = pwd()

    stage("Preparation") {
        checkout scm
    }

    stage("Build") {
        powershell(script:"c:/Jenkins/nuget.exe restore ${workspacePath}/WebApplication1.sln", returnStdout:true)

        bat """ \
            \"C:/Program Files (x86)/Microsoft Visual Studio/2017/BuildTools/MSBuild/15.0/Bin/amd64/MSBuild.exe\" \
            ${project_path}/WebApplication1.csproj \
            /v:detailed /t:ReBuild;Package /p:Configuration=Release \
        """
    }

    stage("Deploy") {
        withCredentials([
            string(credentialsId: 'IISURL', variable: 'IISURL'), 
            string(credentialsId: 'IISUSER', variable: 'IISUSER'), 
            string(credentialsId: 'IISPWD', variable: 'IISPWD')]) {
                bat """ \
                    ${project_path}/obj/Release/Package/WebApplication1.deploy.cmd \
                    /Y \"-setParam:name=\'IIS Web Application Name\',value=\'demo\'\" \
                    \"/M:%IISURL%\" -allowUntrusted /U:%IISUSER% /P:%IISPWD% /A:Basic \
                """
        }
    }

}