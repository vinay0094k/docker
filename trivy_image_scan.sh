#!/bin/bash
#get the image name from Dockerfile file 
imageName=$(awk 'NR==1 {print $2}' Dockerfile.alpine)
echo $imageName
trivyVersion="0.48.3"

#-e TRIVY_GITHUB_TOKEN=$token: Sets an environment variable TRIVY_GITHUB_TOKEN with the provided token value. This is used to access private GitHub repositories during vulnerability scanning.
#docker run --rm -v $WORKSPACE:/root/.cache/ -e TRIVY_GITHUB_TOKEN='token_github' aquasec/trivy:0.48.3 -q image --exit-code 1 --severity CRITICAL --light $dockerImageName
docker run --rm -v $WORKSPACE:/root/.cache/ aquasec/trivy:$trivyVersion -q image --exit-code 1 --severity CRITICAL --light $imageName

    # Trivy scan result processing
    exit_code=$?
    echo "Exit Code : $exit_code"

    # Check scan results
    if [[ "${exit_code}" == 1 ]]; then
        echo "Image scanning failed. Vulnerabilities found"
        exit 1;
    else
        echo "Image scanning passed. No CRITICAL vulnerabilities found"
    fi;
