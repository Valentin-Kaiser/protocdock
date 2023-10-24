prod:
	docker build -t proto-compiler:latest .
	docker compose up -d
	docker exec -it proto-compiler /bin/bash