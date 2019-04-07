![](https://img.shields.io/github/license/while-true-do/test-library.svg?style=flat)
![](https://img.shields.io/github/issues/while-true-do/test-library.svg?style=flat)

# test-library

This repository contains some scripts and templates for testing.

## Motivation

During the past years, while-true-do.io opened and closed some repositories.
Keeping track of common tests and test templates should be easy and maintainable
.Re-testing existing repositories without touching each repository should be
painless, too.

## Description

The scripts maintained in this repository should be considered as common test
scenarios. You will find tests which can be run manually and automatically.
The idea is, that you will be able to do the same tests on different OS,
locally, remote or in a container.

### Scripts

You will find the following scripts in this repository.

-   [tl-ansible.sh](scripts/tl-ansible.sh) - to test Ansible roles
-   [tl-bash.sh](scripts/tl-bash.sh) - to test bash scripts
-   [tl-compliance.sh](scripts/tl-compliance.sh) - to test for while-true-do.io compliance
-   [tl-pykickstart.sh](scripts/tl-pykickstart.sh) - to test kickstart files
-   [tl-spelling.sh](scripts/tl-spelling.sh) - to test the spelling in files

If you want to write your own scripts, please consider reading the
[DEVELOPMENT.md](./docs/DEVELOPMENT.md).

### Templates

The following templates are maintained in this repository.

-  [.aspell.en.pws](templates/.aspell.en.pws.j2) - personal dictionary for [tl-spelling.sh](scripts/tl-spelling.sh)
-  [.travis.yml](templates/.travis.yml.j2) -template for automated tests in travis-ci

## Requirements

For the library itself, you do not need any special tools or software. The
scripts may need additional tools, which can be installed with the 'prep'
action. Please read the [Usage](#Usage) section for some more details.

## Installation

Install from [Github](https://github.com/while-true-do/test-library)

```
git clone https://github.com/while-true-do/test-library.git
```

## Usage

All of the scripts will provide "actions". The most useful action will be the
`help` action, which will provide information about the script and it's functionality.

### Actions

Actions are parameter / arguments, which trigger the correct use case. An action
can have additional options or can be used standalone.

```
# Using the help action
scripts/tl-SCRIPT.sh help

# Using the test action
scripts/tl-SCRIPT.sh test

# Using the help of an action
scripts/tl-SCRIPT.sh test --help
```

The most common actions are `help`, `test` and `prep`. It is possible to
specify more for specific tasks like configurations, pulling updates, etc.

| action | description                  | mandatory |
| ------ | ---------------------------- | --------- |
| help   | Shows the help for a script. | yes       |
| test   | Runs the tests.              | yes       |
| prep   | Preparations for tests.      | no        |

## Testing

Most of the "generic" tests are located our
[Test Library](https://github.com/while-true-do/test-library). Tests and
instructions for a single repository are located in the
[Test Directory](./tests).

## Contribute

Thank you so much for considering to contribute. We are very happy, when somebody
is joining the hard work. Please fell free to open
[Bugs, Feature Requests](https://github.com/while-true-do/test-library/issues) or
[Pull Requests](https://github.com/while-true-do/test-library/pulls) after reading the [Contribution Guideline](https://github.com/while-true-do/doc-library/blob/master/documents/CONTRIBUTING.md).

## License

This work is licensed under a [BSD-3-Clause License](https://opensource.org/licenses/BSD-3-Clause).

## Contact

-   Site <https://while-true-do.io>
-   Twitter <https://twitter.com/wtd_news>
-   Code <https://github.com/while-true-do>
-   Mail [hello@while-true-do.io](mailto:hello@while-true-do.io)
-   IRC [freenode, #while-true-do](https://webchat.freenode.net/?channels=while-true-do)
-   Telegram <https://t.me/while_true_do>
