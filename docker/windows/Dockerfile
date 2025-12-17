# escape=`

FROM mcr.microsoft.com/windows/servercore:ltsc2022 AS build

SHELL ["cmd", "/S", "/C"]

# Download VS Build Tools
RUN curl -SL https://aka.ms/vs/17/release/vs_buildtools.exe -o vs.exe

# Install MSVC toolchain (SINGLE LINE!)
RUN vs.exe --quiet --wait --norestart --nocache --add Microsoft.VisualStudio.Workload.VCTools --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64

# Cleanup
RUN del vs.exe

# Tools
RUN choco install -y cmake ninja git python

# Conan
RUN pip install "conan>=2.20,<3"

WORKDIR C:\workspace

FROM build AS runtime
WORKDIR C:\workspace
