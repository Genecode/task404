# README

How to run app in develop env
```bash
docker-compose build
docker-compose up
```

Open your browser to ```http://[DOCKER_HOST]:[DOCKER_PORT].```

Run test:
```bash
docker-compose -f docker-compose.test.yml run --rm app rspec
```