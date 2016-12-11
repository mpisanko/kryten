# Kryten

Jora ChatOps bot

![Kryten](kryten.jpg)

# Commands

Kryten understands some simple commands at the moment. These commands are case
insensitive.

* `Pull Requests` or `PRs` - Will list all open Pull Requests in the
  `JobSeekerLtd` Github organisation
* `deploy $PROJECT` - Will run a deploy project on Jenkins. Only works for
  staging deployments at the moment 

# Running tests

When running our tests, we don't want the whole OTP application to start when
invoking `mix`, so we should run our tests like:

```
$ mix test --no-start
```
