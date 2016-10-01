Unless otherwise mentioned, all the requests are HTML forms:

* `application/x-www-form-urlencoded`
* `multipart/form-data`

## browser requirement

Front-end should probably run on browsers newer than

* Firefox 21
* Chrome 27
* IE 10

because:

* They avoid [JSON hijacking][1].

It is suggested that front-end framework either refuse to work on a legacy browser, or (at least) alert users to possible security issues.

[1]: http://stackoverflow.com/questions/16289894/is-json-hijacking-still-an-issue-in-modern-browsers#answer-16880162
