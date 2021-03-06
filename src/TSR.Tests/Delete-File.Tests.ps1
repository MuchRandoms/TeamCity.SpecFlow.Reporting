###
. "$(Join-Path $PSScriptRoot '_TestContext.ps1')"
###

function Background {
	Mock Remove-Item {}
}

Fixture "Delete-File" {	
	
	Given "the path to the file is not a valid object" {		
		$obj = @{}		
		
		Then "it shouldn't try to delete the file" {
			Delete-File $obj.NotValid
			
			Assert-MockCalled Remove-Item -Exactly 0 
		}
	}
	
	Given "the path is a valid file object" {
		Setup -File test.txt
		$file = Get-TestDriveItem 'test.txt'		
		
		Then "it should use the FullName property while removing it" {
			Delete-File $file.FullName
			
			Assert-MockCalled Remove-Item -Exactly 1 {$Path -eq $file.FullName}
		}
	}
}



