# escape=`

FROM mcr.microsoft.com/windows/servercore:ltsc2022 AS build

SHELL ["cmd", "/S", "/C"]

RUN curl -SL https://aka.ms/vs/17/release/vs_buildtools.exe -o vs.exe ^
 && vs.exe --quiet --wait --norestart --nocache ^
    --add Microsoft.VisualStudio.Workload.VCTools ^
    --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 ^
 && del vs.exe

RUN choco install -y cmake ninja git python

RUN pip install "conan>=2.20,<3"

WORKDIR C:\workspace

FROM build AS runtime
WORKDIR C:\workspace

