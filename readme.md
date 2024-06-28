# Migrate Users to Entra External Tenant and force password reset sample
## Register an application 
1.	Register an application in Entra ID External Tenant. Follow this [documentation](https://learn.microsoft.com/en-us/entra/external-id/customers/how-to-register-ciam-app?tabs=graphapi#tabpanel_1_graphapi)
2.	Grant User.ReadWrite.All API permissions to the registered application.
3.	Create a client secret for the application.

## Create a users.csv file 
1. Replace contoso.onmicrosoft.com with your tenant domain name in [users.csv](./users.csv) file. 
2. Aadd other fields as needed - see the [documentation](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0&tabs=http).

```csv
DisplayName,MailNickname,UserPrincipalName,Password
Test User 1,TestUser1,TestUser1@contoso.onmicrosoft.com,TempPass1
Test User 2,TestUser2,TestUser2@contoso.onmicrosoft.com,TempPass3
Test User 3,TestUser3,TestUser3@contoso.onmicrosoft.com,TempPass3
```

## Run the CreateUser.ps1 script
1. Replace the TenantId, ClientId and ClientSecret in the [createUser.ps1](./createUser.ps1) script 
2. Run the script to create the users.






