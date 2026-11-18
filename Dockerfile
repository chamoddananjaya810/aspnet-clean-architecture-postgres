FROM mcr.microsoft.com/dotnet/sdk:11.0 AS build
WORKDIR /src

# Project files copy කර restore කිරීම
COPY ["TaskManager.API/TaskManager.API.csproj", "TaskManager.API/"]
COPY ["TaskManager.Application/TaskManager.Application.csproj", "TaskManager.Application/"]
COPY ["TaskManager.Domain/TaskManager.Domain.csproj", "TaskManager.Domain/"]
COPY ["TaskManager.Infrastructure/TaskManager.Infrastructure.csproj", "TaskManager.Infrastructure/"]
RUN dotnet restore "TaskManager.API/TaskManager.API.csproj"

# සම්පූර්ණ code එක copy කර build/publish කිරීම
COPY . .
WORKDIR "/src/TaskManager.API"
RUN dotnet publish "TaskManager.API.csproj" -c Release -o /app/publish

# Runtime image එක සැකසීම
FROM mcr.microsoft.com/dotnet/aspnet:11.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080
ENTRYPOINT ["dotnet", "TaskManager.API.dll"]