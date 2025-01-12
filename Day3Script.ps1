function Get-CollatzSteps {
    param (
        [Parameter(ValueFromPipeline)]
        [int]$n
    )
    Begin{
    $steps = 0
    }
    Process{
    while ($n -ne 1) {
        if ($n % 2 -eq 0) {
            # If n is even, divide n by 2
            $n = $n / 2
        } else {
            # If n is odd, multiply n by 3 and add 1
            $n = 3 * $n + 1
        }
        $steps++
    }
    }
    End{
    return $steps
    }
}

12 | Get-CollatzSteps
$n = 50
$steps = Get-CollatzSteps -n $n
Write-Host "Number of steps required to reach 1 from $n : $steps"

#Begin{} 
#Process{}
#End{}
# above blocks are used for pipeline input for getting inputes like array and execute in sequentional manner
#Always design our code like above, Consider it as stander script writing method in Powersheale
#E.g.
function Something {
    [CmdletBinding()]
    Param()
    Begin{} #Empty allowed
    Process{} #Line of code 
    End{} #Empty allowed
    
}

#---------------------------------------------------------
# Example of above code (Below code converts string to upper class)

function Something {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]$InputString
    )

    # Initialization tasks
    begin {
        Write-Host "Begin block: Initializing resources..."
        $results = @()
    }

    # Process each pipeline input
    process {
        Write-Host "Process block: Processing input - $InputString"
        $results += $InputString.ToUpper()  # Example operation: convert to uppercase
    }

    # Finalization tasks
    end {
        Write-Host "End block: Finalizing..."
        $results | ForEach-Object { Write-Host $_ }

        # Cleanup tasks
        Write-Host "End block: Cleaning up resources..."
        Remove-Variable -Name results -ErrorAction SilentlyContinue
    }
}

# Example usage: passing strings to the function via the pipeline
"hello", "world" | Something

#--------------------------------
#Sample from Ravi
function Get-SumOfNumbers{
         [CmdLetBinding()]
         param(
              [Parameter(ValueFromPipeline)]
              $numbers
          )
          Begin{
               $sum = 0
          }
          #Code 
          Process{
              foreach($item in $numbers){
                    $sum += $item
              }
          }
          End{
            Write-Host $sum
          }
}

1, 2, 3 | Get-SumOfNumbers

#--------------------------------------

$csv = Import-Csv "C:\Users\sachin.dilip.patil\Downloads\AZ-040T00\Powershell\Users.csv"
$csv | Get-Member
foreach($u in $csv){
    $name = "$($u.username)"
    $pass = "$($u.password)"
    $securepass = ConvertTo-SecureString -AsPlainText -Force -String "$pass"
    New-LocalUser -Name $name -Password $securepass
    #New-ADUser -Name $name -AccountPassword $securepass
}

#-------------------------------------------------
<#
Scenario - I have two files, those files I need to copy to multiple servers. So, I pasted the server names in a text file and imported it an variable. Then using foreach loop, I am copying the files on target server, where source is a fixed location and destination is dynamically set. For example -- "//$server/c$/temp/upgrade/".
Once files are copied, then I have to run that file, which will install/upgrade an application.
 
Now via script, I can copy both files to target machines, but when I tires to run the file via invoke-command, I am getting errors.
 
I had verified, winrm service is running on client-target machines, I am able to ping target machine from client. Anyone any idea where should I look next?


usually command - (Invoke-Command -ComputerName "COMPUTERNAME" -FilePath "C:\Test\Test.ps1") should work right? if everything is good in respect of connectivity and all.
#>