#/bin/bash

# Ensures unique id
random=$(python -c 'import uuid; print(str(uuid.uuid4())[0:8])')

# Variables
resourceGroupName="myResourceGroup$random"
appName="AppServiceLinuxDocker$random"
location="WestUS"
dockerHubContainerPath="<replace-with-docker-hub-container-or-image" #format: <username>/<container-or-image>:<tag>

# Create a Resource Group
az group create --name $resourceGroupName --location $location

# Create an App Service Plan
az appservice plan create --name AppServiceLinuxDockerPlan --resource-group $resourceGroupName --location $location --is-linux --sku S1

# Create a Web App
az appservice web create --name $appName --plan AppServiceLinuxDockerPlan --resource-group $resourceGroupName

# Configure Web App with a Custom Docker Container from Docker Hub
az appservice web config container update --docker-custom-image-name $dockerHubContainerPath --name $appName --resource-group $resourceGroupName