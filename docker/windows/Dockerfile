# escape=`

FROM mcr.microsoft.com/windows/servercore:ltsc2022 AS build

# ----------------------------
# Install Chocolatey
# ----------------------------
SHELL ["powershell", "-NoProfile", "-ExecutionPolicy", "Bypass", "-Command"]

RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; \iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# ----------------------------
# Switch back to cmd
# ----------------------------
SHELL ["cmd", "/S", "/C"]

# ----------------------------
# Visual Studio Build Tools
# ----------------------------
RUN curl -SL https://aka.ms/vs/17/release/vs_buildtools.exe -o vs.exe
RUN vs.exe --quiet --wait --norestart --nocache --add Microsoft.VisualStudio.Workload.VCTools --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64
RUN del vs.exe

# ----------------------------
# Tools via Chocolatey
# ----------------------------
RUN choco install -y cmake ninja git python

# ----------------------------
# Conan
# ----------------------------
RUN pip install "conan>=2.20,<3"

WORKDIR C:\workspace

FROM build AS runtime
WORKDIR C:\workspace
