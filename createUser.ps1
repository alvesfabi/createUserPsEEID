# Install the Microsoft.Graph module if not already installed
Install-Module -Name Microsoft.Graph -Scope CurrentUser

# Import the Microsoft.Graph module
Import-Module Microsoft.Graph

# Define tenant ID, client ID, and client secret
$tenantId = "your-tenant-id"
$clientId = "your-client-id"
$clientSecret = "your-client-secret"

# Define the authentication URL and the resource (Microsoft Graph)
$authUrl = "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token"
$scope = "https://graph.microsoft.com/.default"

# Create the body for the authentication request
$body = @{
    client_id     = $clientId
    scope         = $scope
    client_secret = $clientSecret
    grant_type    = "client_credentials"
}

# Get the access token
$response = Invoke-RestMethod -Method Post -Uri $authUrl -ContentType "application/x-www-form-urlencoded" -Body $body
$accessToken = $response.access_token

# Define the API endpoint
$uri = "https://graph.microsoft.com/v1.0/users"

# Import user data from CSV file
$csvFilePath = ".\users.csv"
$userData = Import-Csv -Path $csvFilePath

# Loop through each user and create them in Azure AD
foreach ($user in $userData) {
    # Define user details
    $userDetails = @{
        accountEnabled = $true
        displayName = $user.DisplayName
        mailNickname = $user.MailNickname
        userPrincipalName = $user.UserPrincipalName
        passwordProfile = @{
            forceChangePasswordNextSignIn = $true
            password = $user.Password
        }
    }

    # Convert user details to JSON format
    $userDetailsJson = $userDetails | ConvertTo-Json

    # Create the user by calling the Graph API
    try {
        Invoke-RestMethod -Uri $uri -Method Post -Headers @{ Authorization = "Bearer $accessToken" } -Body $userDetailsJson -ContentType "application/json"
        Write-Host "User $($user.UserPrincipalName) created successfully."
    } catch {
        Write-Host "Failed to create user $($user.UserPrincipalName): $_"
    }
}
