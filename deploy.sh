docker build -t nikpenev/multi-client:latest -t nikpenev/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nikpenev/multi-server:latest -t nikpenev/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nikpenev/multi-worker:latest -t nikpenev/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nikpenev/multi-client:latest
docker push nikpenev/multi-server:latest
docker push nikpenev/multi-worker:latest

docker push nikpenev/multi-client:$SHA
docker push nikpenev/multi-server:$SHA
docker push nikpenev/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=nikpenev/multi-client:$SHA
kubectl set image deployments/server-deployment server=nikpenev/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=nikpenev/multi-worker:$SHA
