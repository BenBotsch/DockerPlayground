# escape=`
FROM mcr.microsoft.com/windows/servercore:ltsc2022

SHELL ["cmd", "/S", "/C"]

RUN choco install -y `
    visualstudio2022buildtools `
    visualstudio2022-workload-vctools `
    cmake `
    ninja `
    git `
    python

RUN pip install "conan>=2.20,<3"

WORKDIR C:\workspace
