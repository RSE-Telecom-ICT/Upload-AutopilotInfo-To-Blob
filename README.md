# Upload AutopilotInfo to blob storage
Upload Autopilot Hardware hash to Azure Blob Storage

## Generate SAS Token

- Go to the storage account

- Create a new container
  ![New Container](images/New-Container.png)


- Open the created container and click Shared access tokens
  ![Open Container](images/Open-Container.png)


- Generate a SAS URL
  ![Genrate SAS URL](images/Generate-SAS-URL.png)

## Create task in Datto RMM

- Go to Datto RMM and create a [new job](https://pinotage.rmm.datto.com/job)
  ![Datto Create Job](images/Datto-Jobs.png)


- Name the job and add a component
  ![Datto Add Component](images/Datto-Create-Job-AddComponent.png)


- Provide the earlier created SAS URL
  ![Datto SAS URL](images/Datto-Create-Job-SASURL.png)


- Add the targets
  ![Datto Targets](images/Datto-Create-Job-Targets.png)


- Set the schedule and the duration
  ![Datto Duration](images/Datto-Create-Job-Duration.png)


- Monitor the [job status](https://pinotage.rmm.datto.com/jobs/)
  ![Datto Status](images/Datto-Job-Status.png)

## Get the CSV's

- Watch the blob container fill with CSV files
  ![Container contents](images/Container-Contents.png)


- Download the CSV's with [Azure Storage Explorer](https://go.microsoft.com/fwlink/?LinkId=708343&clcid=0x409)
  ![Container contents](images/Azure-StorageExplorer.png)


## Merge CSV's  

- Run the merge-csv.ps1 script in this repository
- Select the source folder where you downloaded the CSV's
- Select the destintion folder where you want the merged CSV to be stored


## Final actions

- Upload the merged CSV to the tenant!
