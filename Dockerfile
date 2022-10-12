FROM mcr.microsoft.com/windows/servercore/iis

RUN powershell -NoProfile -Command Remove-Item -Recurse C:\inetpub\wwwroot\*

WORKDIR /inetpub/wwwroot

COPY C:\data\jenkins_home\workspace\ASPNETDocker1/JenkinsDemo1/ .
