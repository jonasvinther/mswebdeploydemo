node("windows") {

    def build_scripts_path = env.WORKSPACE + "/build_scripts"
    def project_path = env.WORKSPACE + "/WebApplication1"
    def workspacePath = env.WORKSPACE

    stage("Preparation") {
        checkout scm
    }

    stage("Build") {
        powershell(script:"c:/Jenkins/nuget.exe restore ${workspacePath}/WebApplication1.sln", returnStdout:true)

        powershell(script:". '${env.WORKSPACE}/build_scripts/build.ps1' ${project_path}")

        // bat """ \
        //     \"C:/Program Files (x86)/Microsoft Visual Studio/2017/BuildTools/MSBuild/15.0/Bin/amd64/MSBuild.exe\" \
        //     ${project_path}/WebApplication1.csproj \
        //     /v:detailed /t:ReBuild;Package /p:Configuration=Release \
        // """
    }

    stage("Deploy") {
        withCredentials([
            string(credentialsId: 'IISURL', variable: 'IISURL'), 
            string(credentialsId: 'IISUSER', variable: 'IISUSER'), 
            string(credentialsId: 'IISPWD', variable: 'IISPWD')]) {

                powershell(script:". '${env.WORKSPACE}/build_scripts/deploy.ps1' ${project_path} ${IISURL} ${IISUSER} ${IISPWD}")
                // bat """ \
                //     ${project_path}/obj/Release/Package/WebApplication1.deploy.cmd \
                //     /Y \"-setParam:name=\'IIS Web Application Name\',value=\'test\'\" \
                //     \"/M:%IISURL%\" -allowUntrusted /U:%IISUSER% /P:%IISPWD% /A:Basic \
                // """
        }
    }

}