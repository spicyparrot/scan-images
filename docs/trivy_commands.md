# Trivy

## Commands

- `trivy image ubuntu:20.04`
- `trivy image --severity "CRITICAL,HIGH" ubuntu:20.04`
- `trivy image --severity "CRITICAL,HIGH" --ignore-unfixed ubuntu:20.04`
- `trivy image --severity "CRITICAL,HIGH" --ignore-unfixed ubuntu:20.04`
- `trivy image --severity "CRITICAL,HIGH" --format template --template "@templates/html.tpl" -o reports/full_report.md ubuntu:20.04`
- `trivy image --severity "CRITICAL,HIGH" -f json -o reports/full_report.json python:3.8.10`