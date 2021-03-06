$tsr_dir = Join-Path $(Split-Path -Parent $PSScriptRoot) 'TSR'
$module = $(Join-Path $tsr_dir 'TeamCity.SpecFlow.Reporting.psm1')
$code = Get-Content $module | Out-String
Invoke-Expression $code

$SolutionPath 		= 'MySolution'
$NuGetPath 			= Join-Path $SolutionPath 'packages'
$SpecFlowPath 		= Join-Path $NuGetPath 'SpecFlow.1.0.0\tools'
$SpecFlowExePath 	= Join-Path $SpecFlowPath 'specflow.exe'
$NUnitPath 			= Join-Path $NuGetPath 'NUnit.Runners.1.0.0\tools'
$NUnitExePath		= Join-Path $NUnitPath 'nunit-console.exe'
$ProjectName		= 'MyProject'
$ProjectPath 		= Join-Path $SolutionPath $ProjectName
$ProjectFileName	= $("{0}.csproj" -f $ProjectName)
$ProjectFilePath 	= Join-Path $ProjectPath $ProjectFileName
$Configuration 		= 'release'
$BinFolder 			= Join-Path 'bin' $Configuration
$BinPath 			= Join-Path $ProjectPath $BinFolder
$AssemblyFilePath 	= Join-Path $BinPath ('{0}.dll' -f $ProjectName)


function Fixture {
	param(
		[String]$Fixture,
		[ScriptBlock]$Action
	)
	
	Describe $('=== {0} ===' -f $Fixture) {
		Mock Write-LogMessage {}
		
		& $Action
	}
}

function Given {
	param(
		[String]$Given,
		[ScriptBlock]$Action,
		[String]$WorkingDirectory = $(Join-Path $TestDrive $ProjectPath)
	)

	Set-Properties @{
		Verbose = $false		
	}	
	Setup-ProjectDirectory	
	
	Context $("given {0}" -f $Given) {
		In $WorkingDirectory {			
			Background			
			& $Action			
		}
	}
}

function Then {
	param(
		[String]$Then,
		[ScriptBlock]$Action
	)
	
	It $('then {0}' -f $Then) {
		& $Action
	}
}

function And {
	param(
		[String]$And,
		[ScriptBlock]$Action
	)
	
	It $('and {0}' -f $And) {
		& $Action
	}
}

function Get-TestDriveItem($Path) {
	$result = Get-Item (Join-Path $TestDrive $Path)
	return $result
}

function Setup-ProjectDirectory {	

	Setup -File $ProjectFilePath #*.csproj
	Setup -File $AssemblyFilePath #*.dll
	Setup -File $SpecFlowExePath #specflow.exe
	Setup -File $NUnitExePath #nunit-console.exe
}

function Background {} # optionally defined by each tests
