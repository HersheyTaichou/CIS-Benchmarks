# CIS Benchmark Scripts

## Introduction

Here you will find in-progress scripts designed to audit and deploy the CIS Benchmarks in a business environment. These scripts are based on version 2.0.0 of the CIS Benchmarks, released on 2023-03-07

These scripts are VERY MUCH a work in progress, so take caution and review them carefully before running them, as what worked in my environment may break yours! These scripts were created as I went through the benchmark documentation and learned how to impliment them on one test environment.

## Getting Started

Before starting, it is advised that you carefully review the CIS Benchmarks. You can download the latest copy of the [CIS Benchmarks](https://learn.cisecurity.org/benchmarks) for review by filling out the form on their site.

Once you are ready to review a system or environment, the scripts are divided into various functions. I recommend you start with the Audit commands, and see what is already in place, before running the commands to deploy the benchmark standards.

The repository is divided up by OS, then by audit and deploy, and under those, they follow the number and naming schemes from the CIS Benchmark documentation. Each top level of the documentation is represented by a single module, with various functions in each module for each sub-level. (This is my initial plan, and subject to change)

## Licenses

The CIS Benchmarks are, at last check, covered by a Create Commons "Attribution-NonCommercial-ShareAlike 4.0 International" License. The current license for the benchamrks and other CIS programs can be found at their site:

[Center for Internet Security Terms and Conditions](https://www.cisecurity.org/terms-and-conditions-table-of-contents)

The scripts and original resources are covered by the GNU General Public License v3.0. More information on the license can be found in the COPYING file.
