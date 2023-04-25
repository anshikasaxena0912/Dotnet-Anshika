FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY SimpleWebAppMVC/*.csproj .
RUN dotnet restore

# Copy everything else and build website
COPY SimpleWebAppMVC/. .
RUN dotnet publish -c release -o /WebApp --no-restore

# Final stage / image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
EXPOSE 5000
WORKDIR /WebApp
COPY --from=build /WebApp ./
ENTRYPOINT ["dotnet", "SimpleWebAppMVC.dll"]
