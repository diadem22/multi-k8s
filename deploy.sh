docker build -t diadem27/multi-client:latest -t diadem27/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t diadem27/multi-server:latest -t diadem27/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t diadem27/multi-worker:latest -t diadem27/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push diadem27/multi-client:latest
docker push diadem27/multi-server:latest
docker push diadem27/multi-worker:latest
docker push diadem27/multi-client:$SHA
docker push diadem27/multi-server:$SHA
docker push diadem27/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=diadem27/multi-server:latest
kubectl set image deployments/client-deployment client=diadem27/multi-client:latest
kubectl set image deployments/worker-deployment worker=diadem27/multi-worker:latest