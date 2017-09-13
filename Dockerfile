FROM nugardt/msbuild:12.0

SHELL ["PowerShell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Install-PackageProvider NuGet -Force
RUN Install-Module Pester -SkipPublisherCheck -Force

# Create user with a short name, and use it to avoid "path too long" exceptions
RUN NET USER a /add
RUN NET LOCALGROUP Administrators a /add
USER a

WORKDIR /

RUN New-Item /TestResults -ItemType Directory

# All Pester tests in '/Scripts' will be run. 
# Test results are written to '/TestResults/TestResults.xml'. 
# Use e.g. 'docker run -v=<absolute path to my scripts>:C:\Scripts -v=<absolute path to where I want test results>:C:\TestResults'.
CMD Invoke-Pester -Path "/Scripts" -OutputFormat NUnitXml -OutputFile "/TestResults/TestResults.xml"