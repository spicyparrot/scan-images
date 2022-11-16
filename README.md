# Scan Docker Images

This is a composte action that uses the the excellent [Trivy](https://aquasecurity.github.io/trivy) by Aqua Security to scan in-memory docker images for security issues.

This can be used to flag security issues prior to pushing to an image registry, such as Docker Hub, to further improve a shift left development life cycle.

## Requirements

- Images to be scan available in memory prior to scanning

## Example workflow

```yaml
name: 🧪 Test
on: 
  workflow_dispatch:
    
jobs:
  test:
    name: ☢ Test Scan
    runs-on: ubuntu-latest
    steps:
      - name: 🛀 Checkout Self
        uses: actions/checkout@v3
      
      - name: ⏬ Load Test Images
        run: |
          docker pull python:3.4-alpine
          docker pull python:3.8.10-slim

      - name: ☢ Scan Images
        uses: spicyparrot/scan-images@trunk
        id: python
        with:
          image_grep: "python"
          severities: "CRITICAL"   
```

### Inputs

| Input  |  Required | Values  | Description  | 
|---|---|---|---|
| `image_grep`  | true  | Any string  | String pattern used to grep for all matching images to be scanned (e.g. "python")  |
| `severities` | false  |   |   |
| `upload_reports` |   |   |   |
| `exit_on_error` |   |   |   |

### Outputs

| Output                                             | Description                                        |
|------------------------------------------------------|-----------------------------------------------|
| `total_issues`  | The total number of issues for all matching images and severities    |


### GitHub Action Decorations