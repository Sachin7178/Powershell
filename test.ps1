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
    Begin{}
    Process{}
    End{}
    
}


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