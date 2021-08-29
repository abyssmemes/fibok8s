docker build -t abyssmemes/multi-client:latest -t abyssmemes/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t abyssmemes/multi-server:latest -t abyssmemes/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t abyssmemes/multi-worker:latest -t abyssmemes/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker

docker push abyssmemes/multi-client:latest
docker push abyssmemes/multi-server:latest
docker push abyssmemes/multi-worker:latest

docker push abyssmemes/multi-client:$SHA
docker push abyssmemes/multi-server:$SHA
docker push abyssmemes/multi-worker:$SHA

kubctl apply -f k8s
kubectl set image deployments/server-deployment server=abyssmemes/multi-server:$SHA
kubectl set image deployments/client-deployment client=abyssmemes/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=abyssmemes/multi-worker:$SHA