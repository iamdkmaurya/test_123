name: Create ServiceNow Change

on:
  push:
    branches: [ main ]
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Build
        run: echo "Build steps go here"

  create_change:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - name: Create ServiceNow Change
        uses: ServiceNow/servicenow-devops-change@v6.1.0
        with:
          devops-integration-token: ${{ secrets.SN_DEVOPS_INTEGRATION_TOKEN }}
          instance-url: ${{ secrets.SN_INSTANCE_URL }}
          tool-id: ${{ secrets.SN_ORCHESTRATION_TOOL_ID }}
