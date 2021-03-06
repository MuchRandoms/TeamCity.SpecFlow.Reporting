###
. "$(Join-Path $PSScriptRoot '_TestContext.ps1')"
###


Fixture "Get-SpecFlowPackage" {
	
	Given "the SpecFlow.NUnit nuget package is used" {
		
		Setup -Dir $(Join-Path $NuGetPath 'SpecFlow.NUnit.1.1.1')		
	
		Then "we should still get the correct nuget package" {
			$package = Get-SpecFlowPackage
			
			$package.Exe | Should Exist
		}		
	}

}









