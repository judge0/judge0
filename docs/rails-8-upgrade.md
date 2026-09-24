# Judge0 Rails 8.0 Upgrade

## Overview

This PR upgrades the Judge0 Rails application from Ruby 2.7.0 + Rails 6.1 to Ruby 3.4.1 + Rails 8.0.4.

## Architecture Decision

**Ruby 3.4 is installed directly in the judge0 Dockerfile**, separate from the compilers base image.

- **Rails application**: Runs on Ruby 3.4.1 (new)
- **User code submissions**: Still use Ruby 2.7.0 from compilers image (unchanged)

The `judge0/compilers:1.4.0` base image was intentionally left unchanged.

## Version Summary

| Component | Before | After |
|-----------|--------|-------|
| Ruby (Rails app) | 2.7.0 (EOL) | 3.4.1 |
| Rails | 6.1.7.7 | 8.0.4 |
| Bundler | 2.1.4 | 2.6.2 |
| Puma | 5.x | 6.6.1 |
| Redis gem | 4.x | 5.4.1 |

## Changes Made

### Dockerfile
- Added Ruby 3.4.1 compilation from source
- Updated PATH to use Ruby 3.4.1
- Added Debian Buster archive repository fix (EOL workaround)
- Added `bundle config set force_ruby_platform true` for native gem compilation

### Gemfile
- Updated Rails to `~> 8.0.0`
- Updated gem versions for Rails 8 compatibility
- Removed `annotate` gem (incompatible with Rails 8)

### config/application.rb
- Set `config.load_defaults 8.0`

### config/puma.rb
- Added default values using `ENV.fetch` to prevent crashes

### config/initializers/resque.rb
- Removed `thread_safe: true` option (deprecated in Redis gem 5.x)

### config/initializers/secrets.rb (NEW)
- Compatibility layer for `Rails.application.secrets` (removed in Rails 7.1+)

### docker-compose.dev.yml
- Added `env_file` and `depends_on` to judge0 service

### Deleted Files
- `lib/tasks/auto_annotate_models.rake` - Referenced removed gem

## Breaking Changes Addressed

1. **Rails.application.secrets removed** - Created compatibility initializer
2. **Redis gem thread_safe option removed** - Removed from resque initializer
3. **Annotate gem incompatibility** - Removed gem and rake task
4. **Native gem compilation** - Force ruby platform for glibc compatibility
5. **Debian Buster EOL** - Redirect apt sources to archive.debian.org

## Testing

Verified locally with Docker:
- `GET /languages` - 200 OK (48 languages)
- `GET /about` - 200 OK (version 1.13.1)

## Build Notes

First build takes ~12 minutes due to Ruby compilation. Subsequent builds use cached layers.
