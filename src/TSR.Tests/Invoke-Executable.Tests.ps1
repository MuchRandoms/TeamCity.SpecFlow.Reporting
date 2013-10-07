###
. "$(Join-Path $PSScriptRoot '_TestContext.ps1')"
###


Fixture "Invoke-Executable" {
	
	Given "the user wants verbose output" {
		$exe = Get-Item $(Join-Path $PSScriptRoot "bin\tsr.exe")
		$arguments = @()
		$arguments += "/output=Hello World"
		
		$VerbosePreference = "Continue"
		Mock Out-String {}
			
		Then "it should forward the output" {
			Invoke-Executable $exe.FullName $arguments
			
			Assert-MockCalled Out-String -Exactly 1 {$InputObject -eq "Hello World"}

		}		
	}

}