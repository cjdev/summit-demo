# Summit Demo

Demonstrate the Voltron strategy.

## How to Run

(TBD is the master branch going to be the final code?)

### Foundation

The demo relies on the Lambda Architecture, which is unfortunately
a private repo at this time.  We're working on making it available

From the Lambda Architecture directory, launch these components, waiting for each to complete before launching the next:

0. `./src/aws/launch-security summit`
0. `./src/aws/launch-network summit`
0. `./src/aws/launch-deployment-cluster summit`

### Demo Application Infrastructure and Deployment Pipeline

From the root of this project

0. `./provision/provision.sh <audience-provided-name>`



