#!/bin/bash

# Inputs
IMAGE_GREP=$1
SEVERITIES=$2

# Colours
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
PURPLE='\033[0;35m'
WHITE='\033[0m'

# Files
TAB_FILE=/tmp/table.txt
FULL_FILE=/tmp/full.txt
SLIM_FILE=/tmp/simple.txt
HTML_REPORT=/tmp/trivy_image_reports.html
TOTAL_FILE=/tmp/totals

# Grep For Images
IMAGES=$(docker image list --format "{{.Repository}}:{{.Tag}}"|grep ${IMAGE_GREP})
printf "Images to scan:\n${PURPLE}$IMAGES\n${WHITE}"

# Set initial cumulative count to TOTAL_ISSUES=0
TOTAL_ISSUES=0

# Scan each image
for IMAGE in $IMAGES; do
  printf "${YELLOW}Scanning ${IMAGE}...\n${WHITE}"

  # Full formatted report
  trivy image --format template --template "@templates/html.tpl" -o ${FULL_FILE} --severity ${SEVERITIES} --ignore-unfixed ${IMAGE}
  echo "" >> ${HTML_REPORT}
  cat ${FULL_FILE}  >> ${HTML_REPORT}

  # Reduced report for GitHub Step Summary
  trivy image --format template --template "@templates/html.tpl" -o ${SLIM_FILE}  --severity ${SEVERITIES} --ignore-unfixed ${IMAGE}
  echo "" >> $GITHUB_STEP_SUMMARY
  cat ${SLIM_FILE}  >> $GITHUB_STEP_SUMMARY;

  # Add cumulative issues
  trivy image -o ${TAB_FILE} --severity ${SEVERITIES} --ignore-unfixed ${IMAGE}
  ISSUES=$(cat ${TAB_FILE} |grep "Total:"| sed 's/^.*Total: //'|sed 's/ .*//'|xargs -n1|awk '{ sum += $1 } END { print sum }')
  TOTAL_ISSUES=$(expr ${TOTAL_ISSUES} + ${ISSUES})

  # Logging
  printf "${PURPLE}Cumulative Issues = ${TOTAL_ISSUES}\n${WHITE}"
  printf "${PURPLE}${IMAGE} Issues = ${ISSUES}\n${WHITE}"
done;

# Output total images
echo "issues=${TOTAL_ISSUES}" >> $GITHUB_OUTPUT
#echo "${TOTAL_ISSUES}" > ${TOTAL_FILE}
printf "${YELLOW}Report Generated - ${HTML_REPORT}\n${WHITE}"
printf "${RED}Issues found - ${TOTAL_ISSUES}\n${WHITE}"
#exit 0