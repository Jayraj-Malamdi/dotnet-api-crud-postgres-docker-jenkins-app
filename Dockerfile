FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY ./publish_folder ./
ENTRYPOINT [ "dotnet", "csharp-crud-api.dll" ]