# supervise.sh

**supervise.sh** is a tiny process supervisor that ensures that a specified
command stays running as long as the supervisor is running. It is implemented as
a pure POSIX shell script with no dependencies and no need for compilation,
making it extremely portable.

## Usage

A common use case is to use `supervise.sh` in an application's main script to
manage and restart its sub-services:

```sh
#!/bin/sh

set -eu

# Terminate all child processes when this script is terminated.
trap 'trap - INT TERM; kill -TERM -$$ 2>/dev/null; wait' INT TERM

# Run Deno services.
./supervise.sh -- deno serve &

# Run Caddy server.
./supervise.sh -- caddy run &

# ...

# Wait for all child processes to complete.
wait
```

This approach is typically used in Docker containers and portable applications
to make them resilient to process failures.

## Installation

No installation is required. Simply download the script from the
[releases page](https://github.com/gapotchenko/supervise.sh/releases) and
include it in your application directory.

## Why Use a Process Supervisor?

An alternative is to rely on the operating system’s init system (such as
`systemd`). However, using `systemd` or similar tools increases resource usage
and reduces portability — especially in lightweight or containerized
environments. `supervise.sh` provides a simple, dependency-free way to achieve
the same goal in a fully portable manner.

Another alternative is not to use a supervisor at all but then your application
may become brittle due to limited system resources or subtle omnipresent bugs in
sub-services. A lightweight supervisor helps to improve resilience with minimal
overhead.
