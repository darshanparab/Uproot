﻿function New-UprootLP
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $False, ValueFromPipeline = $True)]
            [string[]]$ComputerName = '.',
        [Parameter(Mandatory = $True)]
            [string]$BinaryPathName,
        [Parameter(Mandatory = $False)]
            [string]$DisplayName = 'Uprootd',
        [Parameter(Mandatory = $False)]
            [string]$Description = 'Listening Post for the Uproot IDS',
        [Parameter(Mandatory = $False)]
        [ValidateSet('Automatic', 'Disabled', 'Manual')]
            [string]$StartupType = 'Automatic'
    )

    PROCESS
    {
        foreach($computer in $ComputerName)
        {
            Write-Verbose "Adding uprootd service to $($computer)"

            # Create a new service for uproot
            $class = [WMICLASS]"\\$($computer)\root\cimv2:Win32_BaseService"
            $return = $class.Create('Uprootd', $DisplayName, $BinaryPathName, 0x10, 1, $StartupType, $false, '.\LocalSystem', "")
            if($return.ReturnValue -eq 0)
            {
                Write-Verbose "Uprootd service successfully installed on $($computer)."
            }
            else
            {
                switch($return.ReturnValue)
                {
                    1 {Write-Error "The request is not supported." -ErrorAction Stop; break}
                    2 {Write-Error "The user did not have the necessary access." -ErrorAction Stop; break}
                    3 {Write-Error "The service cannot be stopped because other services that are running are dependent on it." -ErrorAction Stop; break}
                    4 {Write-Error "The requested control code is not valid, or it is unacceptable to the service." -ErrorAction Stop; break}
                    5 {Write-Error "The requested control code cannot be sent to the service because the state of the service (State property of the Win32_BaseService class) is equal to 0, 1, or 2." -ErrorAction Stop; break}
                    6 {Write-Error "The service has not been started." -ErrorAction Stop; break}
                    7 {Write-Error "The service did not respond to the start request in a timely fashion." -ErrorAction Stop; break}
                    8 {Write-Error "Unknown failure when starting the service." -ErrorAction Stop; break}
                    9 {Write-Error "The directory path to the service executable file was not found." -ErrorAction Stop; break}
                    10 {Write-Error "The service is already running." -ErrorAction Stop; break}
                    11 {Write-Error "The database to add a new service is locked." -ErrorAction Stop; break}
                    12 {Write-Error "A dependency this service relies on has been removed from the system." -ErrorAction Stop; break}
                    13 {Write-Error "The service failed to find the service needed from a dependent service." -ErrorAction Stop; break}
                    14 {Write-Error "The service has been disabled from the system." -ErrorAction Stop; break}
                    15 {Write-Error "The service does not have the correct authentication to run on the system." -ErrorAction Stop; break}
                    16 {Write-Error "This service is being removed from the system." -ErrorAction Stop; break}
                    17 {Write-Error "The service has no execution thread." -ErrorAction Stop; break}
                    18 {Write-Error "The service has circular dependencies when it starts."; break}
                    19 {Write-Error "A service is running under the same name." -ErrorAction Stop; break}
                    20 {Write-Error "The service name has invalid characters." -ErrorAction Stop; break}
                    21 {Write-Error "Invalid parameters have been passed to the service." -ErrorAction Stop; break}
                    22 {Write-Error "The account under which this service runs is either invalid or lacks the permissions to run the service." -ErrorAction Stop; break}
                    23 {Write-Error "The service exists in the database of services available from the system." -ErrorAction Stop; break}
                    24 {Write-Error "The service is currently paused in the system." -ErrorAction Stop; break}
                }
            }
        }
    }
}