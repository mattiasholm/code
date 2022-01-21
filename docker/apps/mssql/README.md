# Tutorial - Microsoft SQL Server in Docker container

<br>

## Source:
https://blog.logrocket.com/how-to-run-sql-server-in-a-docker-container/

## Provision mssql with Docker Compose YAML file:
```shell
docker-compose up -d
```

## Connect to mssql:
```shell
mssql -u sa -p <password>
```