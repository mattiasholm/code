# Cheat Sheet - NPM

<br>

## Official docs:
https://docs.npmjs.com/

<br><br>

## Show NPM version:
```shell
npm --version
npm -v
```

## Contextual help:
```shell
npm [<subcommand>] --help
npm [<subcommand>] -h
```

<br><br>

## List installed local packages:
```shell
npm list
```

## List installed global packages:
```shell
npm list --global
npm list -g
```

<br><br>

## Install all dependencies:
```shell
npm install
```

## Install a specific dependency locally:
```shell
npm install <package>
```

## Install a specific dependency globally:
```shell
npm install --global <package>
npm install -g <package>
```

<br><br>

## Upgrade local dependencies, without updating package.json:
```shell
npm update
```

## Upgrade local dependencies and update package.json
```shell
npm update --save
npm update -S
```

## List outdated packages:
```shell
npm outdated
```

## Run a security audit
```shell
npm audit
```

<br><br>

## List available package scripts:
```shell
npm run
```

## Run a package script:
```shell
npm run <script>
```

## Run a command from a local or remote npm package:
```shell
npx <command>
npm exec <command>
```