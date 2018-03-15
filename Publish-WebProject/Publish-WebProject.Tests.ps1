# Requires https://github.com/pester/Pester: Install-Module Pester -Force -SkipPublisherCheck
Import-Module "$PSScriptRoot\..\UserSettings\UserSettings.psm1" -Force
Import-Module "$PSScriptRoot\..\Invoke-MSBuild\Invoke-MSBuild.psm1" -Force
Import-Module "$PSScriptRoot\..\Invoke-ConfigurationTransform\Invoke-ConfigurationTransform.psm1" -Force
Import-Module "$PSScriptRoot\Publish-WebProject.psm1" -Force
Import-Module "$PSScriptRoot\..\TestContent\TestSolution\New-TestSolution.psm1" -Force

Describe "Publish-WebProject" {

    $ProjectLayerWebProjectFilePath = "\src\Project\WebProject\Code\Project.WebProject.csproj"
    $FeatureLayerWebProjectFilePath = "\src\Feature\WebProject\Code\Feature.WebProject.csproj"
    $FoundationLayerWebProjectFilePath = "\src\Foundation\WebProject\Code\Foundation.WebProject.csproj"
    $PublishWebsitePath = "$TestDrive\Website"
    
    It "should create the output directory if it doesn't exist" {
        # Arrange
        $solutionRootPath = New-TestSolution -TempPath "$TestDrive"
        $projectFilePath = $solutionRootPath + $ProjectLayerWebProjectFilePath

        # Act
        Publish-WebProject -WebProjectFilePath $projectFilePath -OutputPath $PublishWebsitePath

        # Assert
        Test-Path $PublishWebsitePath | Should Be $true
    }

    It "should publish a web project to the target directory" {
        # Arrange
        $PublishUnConfigeredWebsitePath = "$TestDrive\UnConfigeredWebsite"
        $solutionRootPath = New-TestSolution -TempPath "$TestDrive"
        $projectFilePath = $solutionRootPath + $ProjectLayerWebProjectFilePath

        # Act
        Publish-WebProject -WebProjectFilePath $projectFilePath -OutputPath $PublishUnConfigeredWebsitePath

        # Assert
        $publishedFiles = Get-ChildItem $PublishUnConfigeredWebsitePath -Recurse -File | Select-Object -ExpandProperty Name
        $publishedFiles -contains "Project.WebProject.dll" | Should Be $true
        $publishedFiles -contains "Project.WebProject.pdb" | Should Be $true
    }

    It "should publish a web project to the target directory using the alias Publish-UnconfiguredWebProject" {
        # Arrange
        $solutionRootPath = New-TestSolution -TempPath "$TestDrive"
        $projectFilePath = $solutionRootPath + $ProjectLayerWebProjectFilePath

        # Act
        Publish-UnconfiguredWebProject -WebProjectFilePath $projectFilePath -OutputPath $PublishWebsitePath

        # Assert
        $publishedFiles = Get-ChildItem $PublishWebsitePath -Recurse -File | Select-Object -ExpandProperty Name
        $publishedFiles -contains "Project.WebProject.dll" | Should Be $true
        $publishedFiles -contains "Project.WebProject.pdb" | Should Be $true
    }

    It "should respect Build Actions of XDT files" {
        # Arrange
        $solutionRootPath = New-TestSolution -TempPath "$TestDrive"
        $projectFilePath = $solutionRootPath + $ProjectLayerWebProjectFilePath
        [xml]$projectFileXml = Get-Content -Path $projectFilePath
        $contentFiles = $projectFileXml.SelectNodes("//*[local-name()='Content']/@Include") | Select-Object -ExpandProperty "Value"
        
        # Act
        Publish-WebProject -WebProjectFilePath $projectFilePath -OutputPath $PublishWebsitePath
        
        # Assert
        $contentFiles.Count | Should BeGreaterThan 0 "Didn't find any files with Build Action 'Content'."
        $publishedFiles = Get-ChildItem $PublishWebsitePath -Recurse -File | Select-Object -ExpandProperty Name
        foreach ($contentFile in $contentFiles) {
            $publishedFiles -contains $contentFile | Should Be $true "Didn't find file '$contentFile' in publish output."
        }
    }
    
    It "should throw an exception when a project fails to publish" {
        # Arrange
        $solutionRootPath = New-TestSolution -TempPath "$TestDrive"
        $projectFilePath = $solutionRootPath + $FoundationLayerWebProjectFilePath
        Remove-Item -Path ($solutionRootPath + "\src\Foundation\WebProject\Code\Web.Foundation.WebProject.Debug.config") -ErrorAction Stop
        
        # Act
        $publishWebProject = { Publish-WebProject -WebProjectFilePath $projectFilePath -OutputPath $PublishWebsitePath }

        # Assert
        $publishWebProject | Should Throw
    }

    It "should not apply any XDTs during publish" {
        # Arrange
        $solutionRootPath = New-TestSolution -TempPath "$TestDrive"
        $projectFilePath = $solutionRootPath + $FeatureLayerWebProjectFilePath

        # Act
        Publish-WebProject -WebProjectFilePath $projectFilePath -OutputPath $PublishWebsitePath

        # Assert
        $webConfigContent = Get-Content "$PublishWebsitePath\App_Config\Include\Feature.WebProject.Pipelines.config" -ErrorAction Stop | Out-String
        $webConfigContent | Should Not Match "Feature\.WebProject\.Pipelines\.Debug"
        $webConfigContent | Should Not Match "Feature\.WebProject\.Pipelines\.Release"
    }

    It "should publish projects relative to current working directory" {
        # Arrange
        $solutionRootPath = New-TestSolution -TempPath "$TestDrive"
        $projectFilePath = $solutionRootPath + $FeatureLayerWebProjectFilePath

        # Act
        Push-Location $TestDrive
        try {
            Publish-WebProject -WebProjectFilePath $projectFilePath -OutputPath ".\output"
        }
        finally {
            Pop-Location
        }

        # Assert
        Get-ChildItem "$TestDrive\output\" -Recurse | Measure-Object | Select-Object -ExpandProperty Count | Should BeGreaterThan 0
    }
}

InModuleScope "Publish-WebProject" {

    Describe "Find-SolutionRootPath" {
        It "should not create an infinite loop" {
            # Arrange
            $searchStartPath = $TestDrive

            # Act
            $solutionRootPath = Find-SolutionRootPath -SearchStartPath $searchStartPath

            # Assert
            $solutionRootPath | Should Be $null
        }

        It "should find the solution root path when starting in the solution root folder" {
            # Arrange
            New-Item "$TestDrive/.pentia" -ItemType Directory -Force
            Set-Content "$TestDrive/.pentia/user-settings.json" -Value "{""buildConfiguration"":""Debug""}" -Force
            $searchStartPath = "$TestDrive"

            # Act
            $solutionRootPath = Find-SolutionRootPath -SearchStartPath $searchStartPath

            # Assert
            $solutionRootPath | Should Be "$TestDrive"
        }

        It "should find the solution root path when starting in a solution subfolder" {
            # Arrange
            New-Item "$TestDrive/subfolder" -ItemType Directory -Force
            New-Item "$TestDrive/.pentia" -ItemType Directory -Force
            Set-Content "$TestDrive/.pentia/user-settings.json" -Value "{""buildConfiguration"":""Debug""}" -Force
            $searchStartPath = "$TestDrive/subfolder"

            # Act
            $solutionRootPath = Find-SolutionRootPath -SearchStartPath $searchStartPath

            # Assert
            $solutionRootPath | Should Be "$TestDrive"
        }

        It "should find the solution root path when the search start path is a relative path" {
            # Arrange
            New-Item "$TestDrive/subfolder" -ItemType Directory -Force
            New-Item "$TestDrive/.pentia" -ItemType Directory -Force
            Set-Content "$TestDrive/.pentia/user-settings.json" -Value "{""buildConfiguration"":""Debug""}" -Force
            $searchStartPath = "$TestDrive/subfolder"

            # Act
            Push-Location $searchStartPath
            try {
                $solutionRootPath = Find-SolutionRootPath -SearchStartPath "."
            }
            finally {
                Pop-Location                
            }

            # Assert
            $solutionRootPath | Should Be "$TestDrive"
        }
    }

}

Describe "Publish-ConfiguredWebProject" {
    $FeatureLayerWebProjectFilePath = "\src\Feature\WebProject\Code\Feature.WebProject.csproj"
    $PublishWebsitePath = "$TestDrive\Website"

    function New-UserSettings {
        param (
            [Parameter(Mandatory = $true)]
            [string]$SolutionRootPath,

            [Parameter(Mandatory = $false)]
            [string]$BuildConfiguration = "Debug"            
        )
        New-Item -Path "$SolutionRootPath\.pentia" -ItemType Directory -Force | Out-Null
        $settings = @{
            "webrootOutputPath"  = "$PublishWebsitePath";
            "dataOutputPath"     = "$PublishWebsitePath\Data";
            "buildConfiguration" = "$BuildConfiguration";
        }
        $settings | ConvertTo-Json -Depth 100 | Out-File -FilePath "$SolutionRootPath\.pentia\user-settings.json"
    }

    function New-Solution {
        $solutionRootPath = New-TestSolution -TempPath "$TestDrive"
        New-UserSettings -SolutionRootPath $solutionRootPath
        New-Item -Path "$TestDrive\Website\Web.config" -Force | Set-Content -Value "<?xml version=""1.0"" encoding=""utf-8""?><configuration></configuration>" -Force
        $solutionRootPath
    }

    It "should apply XDTs" {
        # Arrange
        $solutionRootPath = New-Solution
        $projectFilePath = $solutionRootPath + $FeatureLayerWebProjectFilePath

        # Act
        Publish-ConfiguredWebProject -WebProjectFilePath $projectFilePath -WebrootOutputPath $PublishWebsitePath -BuildConfiguration "Debug"

        # Assert
        $webConfigContent = Get-Content "$PublishWebsitePath\App_Config\Include\Feature.WebProject.Pipelines.config" -ErrorAction Stop | Out-String
        $webConfigContent | Should Match "Feature\.WebProject\.Pipelines\.Debug"
        $webConfigContent | Should Not Match "Feature\.WebProject\.Pipelines\.Release"
    }

    It "should delete XDTs after applying them" {
        # Arrange
        $solutionRootPath = New-Solution
        $projectFilePath = $solutionRootPath + $FeatureLayerWebProjectFilePath

        # Act
        Publish-ConfiguredWebProject -WebProjectFilePath $projectFilePath -WebrootOutputPath $PublishWebsitePath -BuildConfiguration "Debug"

        # Assert
        "$TestDrive\App_Config\Include\Feature.WebProject.Pipelines.Debug.config" | Should Not Exist
        "$TestDrive\App_Config\Include\Feature.WebProject.Pipelines.Release.config" | Should Not Exist
    }

    It "should use user settings as fallback parameters when available" {
        # Arrange
        $solutionRootPath = New-Solution
        New-UserSettings -SolutionRootPath $solutionRootPath -BuildConfiguration "Release"
        $projectFilePath = $solutionRootPath + $FeatureLayerWebProjectFilePath

        # Act
        Publish-ConfiguredWebProject -WebProjectFilePath $projectFilePath

        # Assert
        $webConfigContent = Get-Content "$PublishWebsitePath\App_Config\Include\Feature.WebProject.Pipelines.config" -ErrorAction Stop | Out-String
        $webConfigContent | Should Not Match "Feature\.WebProject\.Pipelines\.Debug"
        $webConfigContent | Should Match "Feature\.WebProject\.Pipelines\.Release"
    }
}