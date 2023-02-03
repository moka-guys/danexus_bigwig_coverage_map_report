# dnanexus_bigwig_coverage_map_report

DNA Nexus App to create bigwig coverage maps from the stiched/realigned BAMs for TSO runs

## What does this app do?

This app calculates the coverage for a provided BAM file.  Results are available as a BigWig file.

## What are typical use cases for this app?

This app can be used to assess the coverage of TSO runs.

## What inputs are required for this app to run?

This app requires the following inputs:

- BAM File

## How does this app work?

At the core of the app is a dockerised tool (See [mokaguys/Coverage_Uniformity_Report](https://github.com/moka-guys/seglh-toolbox) repo) which reads in a BAM file and outputs a BigWig file.

## What does this app output?

This app outputs:

- BigWig Coverage Map

## What are the limitations of this app?

Initial version of a dx app to produce a BigWig coverage file from a provided BAM using the dockerised tool located at [https://github.com/moka-guys/seglh-toolbox:](https://github.com/moka-guys/seglh-toolbox:)

Currently the tool downloads the latest version of the docker image - this can be changed to use a fixed version before moving to production (See commented out code).
