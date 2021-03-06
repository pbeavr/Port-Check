$ComputerName = '10.10.80.75', '10.10.80.76', '10.10.80.77', '192.168.34.227', '192.168.34.228','192.168.34.229'
$Ports = 4001

foreach ($Computer in $ComputerName) {
    
    foreach ($Port in $Ports) {


        # Create a Net.Sockets.TcpClient object to use for
        # checking for open TCP ports.
        $Socket = New-Object Net.Sockets.TcpClient

        # Suppress error messages
        $ErrorActionPreference = 'SilentlyContinue'

        # Try to connect
        $Socket.Connect($Computer, $Ports)

        # Make error messages visible again
        $ErrorActionPreference = 'Continue'

        # Determine if we are connected.
        if ($Socket.Connected) {
            "${Computer}: Port $Port is open"
            $Socket.Close()
        }
        else {
            "${Computer}: Port $Port is closed or filtered"  
        }
        # Apparently resetting the variable between iterations is necessary.
        $Socket = $null

    }
    
}