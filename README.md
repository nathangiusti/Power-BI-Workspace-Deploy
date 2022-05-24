# Power BI Workspace Deploy

Deploys PBIX files to a workspace. 

# Set Up

Add an environment variable to your GitHub repo for your service principle's id and secret key. 
Pass these credentials to the action as seen in the usage example below

Create a yaml config file and place it in your repo.
The config file will map folder names to workspace ids. This allows the action to deploy to multiple workspaces from a single repository. 

Example:

```yaml
Workspace_name1:
  workspace_id: 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
Workspace_name2:
  workspace_id:  'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
```

A PBIX file placed in a folder called Workspace_name1 will be deployed to the workspace id listed in the config file. 

The folder does not need to be at root. 

/foo/bar/Workspsace_name1/myfile.pbix will deploy myfile.pbix to the workspace listed in the config file for Workspace_name1

# Usage

```yaml

name: Deploy to workspace
on: [pull_request]
jobs:
  Deploy-Asset:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
        with:
          fetch-depth: 0
      - name: Get changed files
        id: changed-files
        uses: tj-actions/changed-files@v19
        with:
          separator: ","
          quotepath: false
      - name: Power BI Workspace Deploy
        uses: nathangiusti/Power-BI-Workspace-Deploy@v1.2
        with:
          files: ${{ steps.changed-files.outputs.all_modified_files }}
          separator: ","
          tenant_id: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
          config_file: ".github/config/workspace-deploy-config.yaml"
        env:
          CLIENT_ID: ${{ secrets.CLIENT_ID }}
          CLIENT_SECRET: ${{ secrets.CLIENT_SECRET }}
```

|               Input               |          type          | required |        default        |                                                                                                                                                          description                                                                                                                                                          |
|:---------------------------------:|:----------------------:|:--------:|:---------------------:|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| files | `string` | `true` | | List of files to process. Will only deploy files with .pbix ending. The rest will be ignored. |
| separator | `string` | `false` | `","` | Character which separates file names. |
| tenant_id | `string` | `true` | | Your tenant id. |
| config_file | `string` | `true` | | The location of your config file |