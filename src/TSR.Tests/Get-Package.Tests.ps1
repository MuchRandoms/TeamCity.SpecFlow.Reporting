###
. "$(Join-Path $PSScriptRoot '_TestContext.ps1')"
###

Fixture "Get-Package" {
	
	Given "the package doesn't exist" {
		
		Get-Package 'Invalid Package' -ea SilentlyContinue -ev actual
				
		Then "it should display an error message" {
				$actual | Should Not BeNullOrEmpty
			}
	}
	
	Given "multiple versions of the same package" {
		Setup -Dir $(Join-Path $NuGetPath 'Test.1.0.0')
		Setup -Dir $(Join-Path $NuGetPath 'Test.1.0.1')

		$expected = Get-TestDriveItem $(Join-Path $NuGetPath 'Test.1.0.1')
		
		$actual = Get-Package "Test"
		
		Then "it should return the latest version" {
			$actual.Version	| Should Be "1.0.1"
			$actual.Path	| Should Be $expected.FullName
		}		
	}

	Given "the package has no version" {
		Setup -File $(Join-Path $NugetPath 'Test.NoVersion\test.txt')

		Then "it should ignore the version" {
			$actual = Get-Package "Test.NoVersion"			
	
			$actual.Path 	| Should Exist
			$actual.Version	| Should Be "n/a"
			
		}
	}
}











