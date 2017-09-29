node("windows") {

    stage("Preparation") {
        checkout scm
    }

    stage('Dependencies') {
        powershell(script:"c:/Jenkins/nuget.exe restore ${env.WORKSPACE}/WebApplication1.sln")
    }

    stage("Build") {
        bat """ \
            \"C:/Program Files (x86)/Microsoft Visual Studio/2017/BuildTools/MSBuild/15.0/Bin/amd64/MSBuild.exe\" \
            ${env.WORKSPACE}/WebApplication1/WebApplication1.csproj \
            /v:detailed /t:Build;Package /p:Configuration=Release \
        """
    }

    stage("Deploy") {
        withCredentials([
            string(credentialsId: 'IISURL', variable: 'IISURL'), 
            string(credentialsId: 'IISUSER', variable: 'IISUSER'), 
            string(credentialsId: 'IISPWD', variable: 'IISPWD')]
        ) {
            bat """ \
                ${env.WORKSPACE}/WebApplication1/obj/Release/Package/WebApplication1.deploy.cmd \
                /Y \"-setParam:name=\'IIS Web Application Name\',value=\'test\'\" \
                \"/M:%IISURL%\" /U:%IISUSER% /P:%IISPWD% /A:Basic -allowUntrusted \
            """
        }
    }

}