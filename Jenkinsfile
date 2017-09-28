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
            \"C:/Windows/Microsoft.NET/Framework/v4.0.30319/MSBuild.exe\" \
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
                    /Y \"-setParam:name=\'IIS Web Application Name\',value=\'test\'\" \
                    \"/M:%IISURL%\" -allowUntrusted /U:%IISUSER% /P:%IISPWD% /A:Basic \
                """
        }
    }

}