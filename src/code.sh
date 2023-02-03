#!/bin/bash
# dnanexus_bigwig_coverage_map_report 0.0.1
# Generated by dx-app-wizard.
#
# Basic execution pattern: Your app will run on a single machine from
# beginning to end.
#
# Your job's input variables (if any) will be loaded as environment
# variables before this script runs.  Any array inputs will be loaded
# as bash arrays.
#
# Any code outside of main() (or any entry point you may add) is
# ALWAYS executed, followed by running the entry point itself.
#
# See https://wiki.dnanexus.com/Developer-Portal for tutorials on how
# to modify this file.

# Exit at any point if there is any error and output each line as it is executed (for debugging)
set -e -x -o pipefail

echo "${input_bam}"

main() {
    # SET VARIABLES
    # Store the API key. Grants the script access to DNAnexus resources
    API_KEY=$(dx cat project-FQqXfYQ0Z0gqx7XG9Z2b4K43:mokaguys_nexus_auth_key)

    # Set the output directory
    mkdir -p "out"
    cd "out"

    # Download BAM files.
    dx download "${input_bam}" --auth "${API_KEY}"

    bam_file_name=$(dx describe "${input_bam}" --json | jq .name | tr -d '"')
    echo "${bam_file_name}"

    # Give all users access to docker.sock
    sudo chmod 666 /var/run/docker.sock

    # Load docker image from docker hub

    # docker image pull seglh/toolbox@sha256:eef6e84ea6dad93f045e12c868efd71a630bfbe0fed62a91d8d12952177b0304
    docker image pull seglh/toolbox:latest

    # Execute the dockerised script - args described below:
    # -v Bind the directory in the DNA Nexus instance to the /home folder in the docker app
    # This insures that all the files produced in the docker instance will be saved before the docker instance closes
    # --rm automatically remove the container when it finishes

    docker run --rm -v "$(pwd)":/work seglh/toolbox bam2bw "${bam_file_name}"
    
    # Upload results to DNA nexus
    
    output_file=$(dx upload  "${bam_file_name}".bw --brief)

    # This line reports the uploaded file ID under the output field
    # called "bigwig_file".

    dx-jobutil-add-output bigwig_file "$output_file" --class=file
}
