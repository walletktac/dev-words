.PHONY: up down sh php cc mig jwt-keys


up:
	docker compose up -d --build
	docker compose exec php composer create-project symfony/skeleton:"^6.4" . || true
	docker compose exec php composer require webapp symfony/orm-pack doctrine maker security jwt-authentication-bundle lexik/jwt-authentication-bundle


sh:
	docker compose exec php bash


cc:
	docker compose exec php php bin/console cache:clear


mig:
	docker compose exec php php bin/console doctrine:migrations:diff && \\
	docker compose exec php php bin/console doctrine:migrations:migrate -n


jwt-keys:
	docker compose exec php mkdir -p config/jwt && \\
	docker compose exec php openssl genrsa -out config/jwt/private.pem -aes256 -passout pass:changeit 4096 && \\
	docker compose exec php openssl rsa -pubout -in config/jwt/private.pem -out config/jwt/public.pem -passin pass:changeit

stop:
	docker compose stop

down:
	docker compose down -v