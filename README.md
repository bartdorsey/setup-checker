# Setup Checker

This checks to make sure your setup for local development is all correct.

## Running it automatically

You can use this curl command to run the script directly from the web.

```shell
curl -s https://raw.githubusercontent.com/bartdorsey/setup-checker/master/run.sh | bash
```

## Running it manually

To run this, clone or download this repository and then in a Unix shell, run

```shell
./check.sh
```

If for some reason it's not executable, you may need to run this:

```shell
chmod u+x check.sh
```

## What it checks

It supports the following operating systems:

- Windows with WSL 2
- Ubuntu Linux
- Debian Linux
- Fedora Linux
- Raspbian Linux (Raspberry Pi)
- macOS (Intel and M1 architecture)

It checks the following tools:

- Shell
  - Checks which shell you are running and tells you the startup file for that shell
- NodeJS
  - Supports NodeJS installed via NVM.
  - Checks that ESLint is installed globally
- VSCode
  - Checks that the code command line is installed correctly
- PostgreSQL 
  - Checks that the psql tools are installed
  - Checks that postgres is up and running
  - Checks that we can query the server without a username and password (through environment variables or a .pgpass file)
