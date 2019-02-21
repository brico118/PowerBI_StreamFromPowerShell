$SqlServer = '<ServerName>';
$SqlDatabase = '<DatabaseName>';

$SqlConnectionString = "Server=$SqlServer;Database=$SqlDatabase;Integrated Security=True;"
$SqlQuery = "<Query>'"

$SqlCommand = New-Object -TypeName System.Data.SqlClient.SqlCommand;
$SqlCommand.CommandText = $SqlQuery;
$SqlConnection = New-Object -TypeName System.Data.SqlClient.SqlConnection -ArgumentList $SqlConnectionString;
$SqlCommand.Connection = $SqlConnection;

$SqlConnection.Open();
$SqlDataReader = $SqlCommand.ExecuteReader();


$endpoint = "<URL to Push data>"

while ($SqlDataReader.Read()) {
    $payload = 
    @{
    "<Key>" =$SqlDataReader['<Value>']
    
    }
    Invoke-RestMethod -Method Post -Uri "$endpoint" -Body (ConvertTo-Json @($payload))
}

$SqlConnection.Close();
$SqlConnection.Dispose();