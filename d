name: Deploy with ServiceNow Change

on:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Build step (replace with your real build)
        run: echo "Building application..."

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
          context-github: ${{ toJSON(github) }}
          job-name: 'create_change'
          change-request: '{"attributes":{"short_description":"Automated deployment change","description":"Auto-created by GitHub Actions pipeline","implementation_plan":"Automated deployment via GitHub Actions","backout_plan":"Revert to previous commit","test_plan":"Automated tests run in CI pipeline"}}'

  deploy:
    needs: create_change
    runs-on: ubuntu-latest
    steps:
      - name: Deploy step (replace with your real deploy)
        run: echo "Deploying application..."

      - name: Update ServiceNow Change to Closed
        uses: ServiceNow/servicenow-devops-update-change@v3.1.0
        with:
          devops-integration-token: ${{ secrets.SN_DEVOPS_INTEGRATION_TOKEN }}
          instance-url: ${{ secrets.SN_INSTANCE_URL }}
          tool-id: ${{ secrets.SN_ORCHESTRATION_TOOL_ID }}
          context-github: ${{ toJSON(github) }}
          change-request-number: ${{ needs.create_change.outputs.change-request-number }}
          change-request-details: '{"state": "3", "close_code": "successful", "close_notes": "Deployed successfully via GitHub Actions"}'
