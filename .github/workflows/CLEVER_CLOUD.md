# Clever Cloud deployment

## Setup

### Clever Cloud interface

Create 2 Rust applications with the `XS` plan:
* `vaultwarden`

And 1 PostgreSQL databases (version 15) with any plan that you will binding to each app accordingly:
* `vaultwarden`

Add 1 FS Bucket addons:
* `vaultwarden`

_(depending on when you created those addonds, don't forget to bind them to the appropriate application)_

Now set for the app these options:
* Zero downtime deployment
* Cancel ongoing deployment on new push
* Force HTTPS

Adjust the domain names as you want, and configure the environment variables as follow:
* `ADMIN_TOKEN`: [SECRET] _(to enable admin panel, for detail see the [wiki](https://github.com/dani-garcia/vaultwarden/wiki/Enabling-admin-page#secure-the-admin_token))_
* `CC_CACHE_DEPENDENCIES`: `true`
* `CC_FS_BUCKET`: [GENERATED] _(can be retrieved from the FS Bucket addons and use `/data:` as local folder)_
* `CC_POST_BUILD_HOOK`: `clevercloud/post_build_hook.sh`
* `CC_PRE_BUILD_HOOK`: `clevercloud/pre_build_hook.sh`
* `DATABASE_MAX_CONNS`: `1` _(only when using DEV plan on pg addon, to avoid `too many clients` error)_
* `DATABASE_URL`: [GENERATED] _(provided by the interface)_
* `DOMAIN`: [GENERATED] _(either your configured domain, or the cleverapp.io one provided by the interface)_
* `ORG_GROUPS_ENABLED`: `true`
* `ROCKET_ADDRESS`: `0.0.0.0`
* `ROCKET_PORT`: `8080`

### GitHub interface

#### GitHub Actions

Configure the following repository secrets (not environment ones):

- `CLEVER_APP_ID`: [GENERATED] _(format `app_{uuid}`, can be retrieved into the Clever Cloud interface)_
- `CLEVER_TOKEN`: [GENERATED] _(can be retrieved from `clever login`, but be warned it gives wide access)_
- `CLEVER_SECRET`: [GENERATED] _(can be retrieved from `clever login`, but be warned it gives wide access)_

## Upgrade Vaultwarden version

1. Synchronize your fork with the original repository
2. Search for the specific commit representing the wanted version
3. Rebase your `deploy` branche to it while making sure to not take third-party files into `.github`. Make also sure to keep local changes in `Cargo.toml`
4. Force-push the branch