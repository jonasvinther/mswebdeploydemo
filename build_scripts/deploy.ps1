& "C:/Program Files/IIS/Microsoft Web Deploy V3/msdeploy.exe" `
-verb:sync `
-source:contentPath="path/to/content" `
-dest:contentPath="websites/demo",ComputerName="https://ec2-52-59-53-140.eu-central-1.compute.amazonaws.com:8172/msdeploy.axd?site=demo",UserName="deployiis",Password="praqma",AuthType="Basic" `
-enableRule:DoNotDeleteRule
-allowUntrusted `




${workspacePath}/obj/Release/Package/WebApplication1.deploy.cmd \
/Y \"-setParam:name=\'IIS Web Application Name\',value=\'test\'\" \
\"/M:%IISURL%\" -allowUntrusted /U:%IISUSER% /P:%IISPWD% /A:Basic \