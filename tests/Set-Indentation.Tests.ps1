###
. "$(Join-Path $PSScriptRoot '_TestContext.ps1')"
###

Fixture "Set-Indentation" {
	
	Given "that the identation 1 and we reset it" {
		Set-Properties @{Indentation = 1}
		
		Set-Indentation -Reset
		
		Then "it should be 0" {
			$tsr.Indentation | Should Be 0
		}
	}
	
	Given "that we use the function without supplying any values" {
		
		Set-Indentation
		
		Then "it should default to 3" {
			$tsr.Indentation | Should Be 3
		}
	}
}












