# ---------- 构建阶段 ----------
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

COPY . .
RUN dotnet publish \
    -c Release \
    -r linux-x64 \
    --self-contained true \
    -o /out

# ---------- 运行阶段 ----------
FROM mcr.microsoft.com/dotnet/runtime-deps:9.0-bookworm-slim
WORKDIR /app

COPY --from=build /out/ /app/

RUN chmod +x /app/TelegramMonitor

EXPOSE 5005
ENTRYPOINT ["/app/TelegramMonitor"]
