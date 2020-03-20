Configuration TempFolder
{
    Node ("localhost")
    {
        File Temp {
            DestinationPath = 'C:\Temp'
            Type = 'Directory'
            Ensure = 'Present'
        }
    }
}