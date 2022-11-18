# Base Image
FROM python:3.8.10

RUN apt-get update -y\
    && apt-get install -y unattended-upgrades

RUN unattended-upgrade


#trivy image --severity "CRITICAL,HIGH"  python:3.8.10