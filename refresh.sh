docker compose up -d
docker exec -it rabbitmq1 rabbitmq-plugins enable rabbitmq_management
sleep 1
terraform -chdir=terraform apply -auto-approve