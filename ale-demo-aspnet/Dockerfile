FROM microsoft/dotnet:latest

RUN apt-get update && apt-get install -y sqlite3 libsqlite3-dev && rm -rf /var/lib/apt/lists/*

COPY . /app

WORKDIR /app

# Removed compiled artifacts, if any
RUN rm -rf bin/ obj/ project.lock.json

RUN ["dotnet", "restore"]

RUN ["dotnet", "build"]

RUN ["dotnet", "ef", "database", "update"]

EXPOSE 5000/tcp

CMD ["dotnet", "run", "--server.urls", "http://*:5000"]
