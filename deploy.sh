docker build -t supratikpathak/multi-client:latest -t supratikpathak/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t supratikpathak/multi-server:latest -t supratikpathak/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t supratikpathak/multi-worker:latest -t supratikpathak/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push supratikpathak/multi-client:latest
docker push supratikpathak/multi-server:latest
docker push supratikpathak/multi-worker:latest

docker push supratikpathak/multi-client:$SHA
docker push supratikpathak/multi-server:$SHA
docker push supratikpathak/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=supratikpathak/multi-server:$SHA
kubectl set image deployments/client-deployment client=supratikpathak/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=supratikpathak/multi-worker:$SHA

