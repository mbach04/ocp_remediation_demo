## Remediation demo of applications on a common baselayer container image (UBI7)

### High level
- Populate a registry with various old and new versions of UBI7 from RH or the DCAR
- Ensure the tag `latest` is applied to an older UBI image in the registry
- Deploy UBI7 as an image stream
- Deploy n BuildConfigs that are based on the UBI7 image stream
- Deploy the apps
- Update the `latest` tag to be the most recent version of UBI
- Run the `oc import-image ubi7` command to start rolling deployment(s) of UBI7 based apps

### UBI7 sitting on Quay.io
![quay.io](https://raw.githubusercontent.com/mbach04/ocp_remediation_demo/master/images/quayio-ubi7-dcar-example.png)
### Flow chart
![quay.io](https://raw.githubusercontent.com/mbach04/ocp_remediation_demo/master/images/flowchart.png)

### Steps to accomplish the above
```bash
oc new-project remediation-demo
# Create the image stream
oc import-image quay.io/mbach/ubi7 --confirm
# Create the build configs
oc create -f https://raw.githubusercontent.com/mbach04/ocp_remediation_demo/master/dc-metro-map/metro-bc-dcar.yaml
oc create -f https://raw.githubusercontent.com/mbach04/ocp_remediation_demo/master/nodejs-demoapp/nodejs-bc-dcar.yaml
# Wait for builds to complete
# Create new apps from each BC (results in DeploymentConfigs)
oc new-app dc-metro-map --name map-1 --as-deployment-config=true
oc new-app nodejs-demo-app --name nodejs-demo --as-deployment-config=true
# Expose the services as OpenShift routes
oc expose svc/dc-metro-map
oc expose svc/nodejs-demo-app
```
After the builds have completed and you can route to the app, move the `latest` tag to a newer version of UBI7 in your registry then update the image stream:
```bash
oc import-image ubi7
```
From here you should see the rolling deployment kick off and replace the underlying UBI7 baselayer on each application deployed.
