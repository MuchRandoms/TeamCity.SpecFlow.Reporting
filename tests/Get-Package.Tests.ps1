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
		$expected = '1.0.1'
		Setup -Dir $(Join-Path $NuGetPath 'Test.1.0.0')
		Setup -Dir $(Join-Path $NuGetPath $('Test.{0}' -f $expected))
		
		$actual = Get-Package "Test"
		
		Then "it should return the latest version" {
			$actual.Version | Should Be $expected
		}		
	}
}











