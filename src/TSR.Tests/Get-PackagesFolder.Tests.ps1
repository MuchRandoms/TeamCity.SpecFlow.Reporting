###
. "$(Join-Path $PSScriptRoot '_TestContext.ps1')"
###

Fixture "Get-PackagesFolder" {		

	Given "the 'packages' folder location is not valid" {	
		$_PathToPackagesFolder = $tsr.PathToPackagesFolder
		Set-Properties @{
			PathToPackagesFolder = $(Join-Path $TestDrive 'NotValid')
		}
		
		Then "it should display an error message" {
			Get-PackagesFolder -ea SilentlyContinue -ev actual
			
			$actual | Should Not BeNullOrEmpty
		}
		
		Set-Properties @{
			PathToPackagesFolder = $_PathToPackagesFolder
		}
	}
	
	Given "'packages' is already included in the path to the folder" {
		$expected = Get-Item $(Join-Path $tsr.PathToPackagesFolder 'Packages')
		$_PathToPackagesFolder = $tsr.PathToPackagesFolder
		Set-Properties @{
			PathToPackagesFolder = $(Join-Path $tsr.PathToPackagesFolder 'Packages')
		}		

		Then "it shouldn't be duplicated" {
			$(Get-PackagesFolder).FullName | Should Be $expected.FullName
		}
		
		Set-Properties @{
			PathToPackagesFolder = $_PathToPackagesFolder
		}
	}
		
	
}











