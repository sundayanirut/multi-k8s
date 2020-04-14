docker build -t sundayanirut/multi-client:latest -t sundayanirut/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sundayanirut/multi-server:latest -t sundayanirut/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sundayanirut/multi-worker:latest -t sundayanirut/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sundayanirut/multi-client:latest
docker push sundayanirut/multi-server:latest
docker push sundayanirut/multi-worker:latest

docker push sundayanirut/multi-client:$SHA
docker push sundayanirut/multi-server:$SHA
docker push sundayanirut/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sundayanirut/multi-server:$SHA
kubectl set image deployments/client-deployment client=sundayanirut/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sundayanirut/multi-worker:$SHA
