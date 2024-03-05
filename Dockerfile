# ew-dotnet:6.0-ubuntu的Dockerfile说明
# 包含.NET 6运行时  ASP.NET Core Runtime 及同步时区

# 定义镜像源
ARG REPO=mcr.microsoft.com/dotnet/runtime-deps
ARG OS=jammy
ARG NET_VERSION=6.0

# Installer image
FROM $REPO:$NET_VERSION-$OS

# .NET Runtime version
ENV DOTNET_VERSION=6.0.27
# 从微软官方镜像拷贝.NET Runtime时至当前镜像
COPY --from=mcr.microsoft.com/dotnet/runtime:6.0-jammy /usr/share/dotnet /usr/share/dotnet
RUN ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

# aspnet  version
ENV ASPNET_VERSION=6.0.27
# 从微软官方镜像拷贝ASP.NET Core Runtime运行时文件至当前镜像
COPY --from=mcr.microsoft.com/dotnet/aspnet:6.0-jammy /usr/share/dotnet/shared/Microsoft.AspNetCore.App \
/usr/share/dotnet/shared/Microsoft.AspNetCore.App

# ew基础版镜像设置  
RUN rm -f /etc/localtime && \  
    ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
