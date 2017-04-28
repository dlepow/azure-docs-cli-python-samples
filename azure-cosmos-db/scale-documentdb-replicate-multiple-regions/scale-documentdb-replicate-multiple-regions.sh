#!/bin/bash

# Set variables for the new account, database, and collection
resourceGroupName=docdbgetstarted
location="South Central US"
name=docdb-test
databaseName=docdb-test-database
collectionName=docdb-test-collection
distributedLocations="East US"=2 "West US"=1 "South Central US"=0
newDistributedLocations="South Central US"=2 "East US"=1 "West US"=0  

# Create a resource group
az group create \
	--name $resourceGroupName \
	--location $location

# Create a DocumentDB account
az documentdb create \
	--name $name \
	--resource-group $resourceGroupName \
	--kind GlobalDocumentDB \
	--locations $location  \
	--max-interval 10 \
	--max-staleness-prefix 200

# Replicate DocumentDB in multiple regions 
az documentdb update \
	--name $name \
	--resource-group $resourceGroupName \
	--locations $distributedLocations  

# Modify regional failover priorities 
az documentdb update \
	--name $name \
	--resource-group $resourceGroupName \
	--locations $newDistributedLocations 

