# escape=`

FROM mcr.microsoft.com/windows/servercore:ltsc2022 AS build

SHELL ["cmd", "/S", "/C"]

# Download Visual Studio Build Tools
RUN curl -SL https://aka.ms/vs/17/release/vs_buildtools.exe -o vs.exe

# Install minimal MSVC toolchain
RUN vs.exe --quiet --wait --norestart --nocache ^
    --add Microsoft.VisualStudio.Workload.VCTools ^
    --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64

# Cleanup installer
RUN del vs.exe

# Install additional build tools
RUN choco install -y cmake ninja git python

# Install Conan
RUN pip install "conan>=2.20,<3"

WORKDIR C:\workspace

FROM build AS runtime
WORKDIR C:\workspace
