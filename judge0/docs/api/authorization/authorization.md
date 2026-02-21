# Group Authorization
To issue some API calls you need to be authorized. For example, you need to be authorized to
[list all submissions](#submissions-submission-get-1) on Judge0.

## Authorize [/authorize{?X-Auth-User}]
### Authorize [POST]
With this API call you can check if your authorization token is valid. If authentication is enabled you should also
authenticate in this API call.

::: note
<h4>Note</h4>
* `X-Auth-User` is default header field name, but administrators of Judge0 instance you are using
   can change this default field name.
* Contact administrator of Judge0 instance you are using to get your authorization token.
:::

::: warning
<h4>Security Warning</h4>
* Although you can send authorization token as URI parameter, **always** send authorization token through headers.
:::

+ Request
    + Headers
        ```
        X-Auth-User: a1133bc6-a0f6-46bf-a2d8-6157418c6fe2
        ```


+ Response 200
If your authorization token is valid.
    + Body

<!-- include(../_unauthenticated.md) -->

+ Response 403
Authorization failed because your authorization token is invalid.
    + Body