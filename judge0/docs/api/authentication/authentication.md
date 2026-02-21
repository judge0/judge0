# Group Authentication
Administrators of Judge0 can configure Judge0 to require you to have an authentication token (a.k.a. API key).
If that is the case with the instance of Judge0 you are using, then you
should provide `X-Auth-Token` header field in **every** API request.

## Authenticate [/authenticate]
### Authenticate [POST]
Check if your authentication token is valid.

::: note
<h4>Note</h4>
* `X-Auth-Token` is default header field name, but administrators of Judge0 instance you are using
   can change this default field name.
* Contact administrator of Judge0 instance you are using to get your authentication token.
:::

::: warning
<h4>Security Warning</h4>
* Although you can send authentication token as URI parameter, **always** send authentication token through headers.
:::

+ Request
    + Headers
        ```
        X-Auth-Token: f6583e60-b13b-4228-b554-2eb332ca64e7
        ```

+ Response 200
If your authentication token is valid or authentication is disabled.
If authentication is disabled you do not need an authentication token.
    + Body

+ Response 401
Authentication failed because your authentication token is invalid.
    + Body