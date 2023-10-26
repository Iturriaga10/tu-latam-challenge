#!/bin/bash
KEYARRAY=(`kubectl get pods --namespace latam-challenge -o jsonpath="{.items[*].spec.containers[*].image}" -l app=latam-challenge-api`)
OLDIMAGENAME=${KEYARRAY[1]}
echo $OLDIMAGENAME

envsubst < $k8sManifest | kubectl apply -f -

# Execute Testing

if [ $? -eq 0 ]; then
    echo Succesfull Deployment
else
    echo RollBack Image
    export imageName=$OLDIMAGENAME
    envsubst < deployment.yml | kubectl apply -f -
    echo RollBack Image Succesfull
    raise error "Test cases failed !!!"
fi
