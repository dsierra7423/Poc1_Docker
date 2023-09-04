FROM ubuntu:22.04

RUN apt update  \
    && apt install -y git

RUN apt install -y software-properties-common apt-transport-https
RUN apt-get install -y wget gpg  \ 
    && wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg  \
    && install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg \
    && sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' \
    && rm -f packages.microsoft.gpg \
    && apt install -y apt-transport-https \
    && apt update \
    && echo yes | apt install code

RUN apt install -y maven
#RUN apt install -y postgresql
RUN apt install -y openjdk-17-jdk
RUN java -version

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
#WORKDIR /src
#RUN dotnet restore "K2_Betterware_Schedule_Assistance.Api/K2_Betterware_Schedule_Assistance.Api.csproj"

FROM httpd:2.4

COPY ./public_html/ /usr/local/apache2/htdocs/

EXPOSE 80
