# Group Authorization
## Authorize [/authorize{?X-Auth-User}]
### Authorize [POST]
To issue some API calls you need to be authorized. For example, you need to be authorized to
[list all submissions](#submissions-submission-get) on Judge0 API.

Please note that `X-Auth-User` is default parameter name that needs to be sent, and that Judge0 API admins
can change the name of this parameter. Please contact admins of Judge0 API you are using to give you
correct parameter name and valid authorization tokens for successful authorization.

With this API call you can check if your authorization token is valid. If authentication is enabled you should also
authenticate in this API call.

+ Parameters
    + X-Auth-User (required, string, `a1133bc6-a0f6-46bf-a2d8-6157418c6fe2`) ... User's authorization token

+ Response 200
If your authorization token is valid.
    + Body

<!-- include(../_unauthenticated.md) -->
<!-- include(../_unauthorized.md) -->