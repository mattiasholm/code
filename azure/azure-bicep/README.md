# Cheat Sheet - Azure Bicep

<br>

## GitHub repository:
https://github.com/Azure/bicep

## Install Azure Bicep on macOS:
```shell
cd ~/Downloads

curl -Lo bicep https://github.com/Azure/bicep/releases/latest/download/bicep-osx-x64

chmod +x ./bicep

sudo spctl --add ./bicep

sudo mv ./bicep /usr/local/bin/bicep
```

## Contextual help:
```shell
bicep [<subcommand>] --help
bicep [<subcommand>] -h
```

<br><br>

## Build a specific template:
```shell
bicep build <file-name>
```

## Build all templates in working directory:
```shell
bicep build ./*.bicep
```

<br><br>





# Transpile / Compile Azure Bicep code
bicep build main.bicep

# Create an Azure Resource Group to deploy to
az group create -n Bicep-RG -l northcentralus

# Deploy ARM Template to Resource Group
az deployment group create -f main.json -g Bicep-RG

az deployment group create -f ./main.json -g my-rg

az deployment group create --resource-group "${RESOURCEGROUP}" --template-file "${templateFile}" --parameters "${parameters}" --mode "${DEPLOY_MODE}"