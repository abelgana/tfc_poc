
export SVC_PROJECT=svc-project-25e0
export CLUSTER_NAME=cluster
export PSQL_INSTANCE=default-postresql-cluster

gcloud iam service-accounts create gkesqlconnect --project ${SVC_PROJECT}

gcloud projects add-iam-policy-binding ${SVC_PROJECT} \
  --role="roles/cloudsql.client" \
  --member="serviceAccount:gkesqlconnect@${SVC_PROJECT}.iam.gserviceaccount.com" \
  --project ${SVC_PROJECT}

gcloud projects add-iam-policy-binding ${SVC_PROJECT}  \
  --role="roles/cloudsql.editor" \
  --member="serviceAccount:gkesqlconnect@${SVC_PROJECT}.iam.gserviceaccount.com" \
  --project ${SVC_PROJECT}

gcloud projects add-iam-policy-binding ${SVC_PROJECT} \
  --role="roles/cloudsql.admin" \
  --member="serviceAccount:gkesqlconnect@${SVC_PROJECT}.iam.gserviceaccount.com" \
  --project ${SVC_PROJECT}

gcloud iam service-accounts add-iam-policy-binding \
  --project ${SVC_PROJECT} \
  --role="roles/iam.workloadIdentityUser" \
  --member="serviceAccount:${SVC_PROJET}.svc.id.goog[default/test]" \
  gkesqlconnect@${SVC_PROJECT}.iam.gserviceaccount.com

gcloud logging read "resource.type=cloudsql_database" \
--project=${SVC_PROJECT} \
--limit=10 \
--format=json


gcloud sql users create gkesqlconnect@${SVC_PROJECT}.iam \
--instance=${PSQL_INSTANCE} \
--type=cloud_iam_service_account \
--project=${SVC_PROJECT}

gcloud container clusters get-credentials ${CLUSTER_NAME} --region us-east4 --project${SVC_PROJECT}

kubectl apply -f sa-gke.yaml

kubectl annotate serviceaccount \
  test \
  iam.gke.io/gcp-service-account=gkesqlconnect@${SVC_PROJECT}.iam.gserviceaccount.com

kubectl apply -f deployment.yaml

# kubectl exec -it test-df7877f58-f2xpc  -c client -- /bin/sh
# apk add --no-cache postgresql-client
gcloud sql users set-password postgres \
  --instance=${PSQL_INSTANCE} \
  --prompt-for-password --project=${SVC_PROJECT}
# psql "host=127.0.0.1 sslmode=disable user=postgres"
# create database uflock;
# GRANT CONNECT ON DATABASE uflock TO "gkesqlconnect@${SVC_PROJECT}.iam";
# psql "host=127.0.0.1 sslmode=disable dbname=uflock user=gkesqlconnect@${SVC_PROJECT}.iam"
# kubectl run redis-cli3 --image redis:latest --attach --leave-stdin-open --rm -it -- /bin/bash
# get the ca
# cat > ca.pem <<EOF
# EOF
# redis-cli -h 10.64.0.4 -p 6378 --tls --cacert ca.pem PING
