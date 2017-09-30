# Group Authentication
## Authenticate [/authenticate{?X-Auth-Token}]
### Authenticate [POST]
Some Judge0 API hosts can protect their API calls with authentication tokens. If that's the case then you should
provide `X-Auth-Token` for **every** API request.

Please note that `X-Auth-Token` is default parameter name that needs to be sent, and that Judge0 API admins
can change the name of this parameter. Please contact admins of Judge0 API you are using to give you
correct parameter name and valid authentication tokens for successful authentication.

With this API call you can check if your authentication token is valid.

+ Parameters
    + X-Auth-Token (required, string, `f6583e60-b13b-4228-b554-2eb332ca64e7`) ... Judge0 API authentication token

+ Response 200
If your authentication token is valid or authentication is disabled.
    + Body

<!-- include(../_unauthenticated.md) -->