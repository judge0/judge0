# Group Authentication
Administrators of Judge0 API can configure Judge0 API to require you to have an authentication token (a.k.a. API key).
If that is the case with the instance of Judge0 API you are using, then you
should provide `X-Auth-Token` header field in **every** API request.

::: note
<h4>Note</h4>
* For [official public API](#header-official-public-api) you **do not** need an authentication token.
:::

## Authenticate [/authenticate]
### Authenticate [POST]
Check if your authentication token is valid.

::: note
<h4>Note</h4>
* `X-Auth-Token` is default header field name, but administrators of Judge0 API instance you are using
   can change this default field name.
* Contact administrator of Judge0 API instance you are using to get your authentication token.
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

<!-- include(../_unauthenticated.md) -->