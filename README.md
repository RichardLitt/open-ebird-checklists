# eBird Checklists

This script automates the process of opening eBird checklists for a specified region and date. It is useful for eBird reviewers and enthusiasts who want to easily access and review checklists in their area.

## Table of Contents
- [Why this repo?](#why-this-repo)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
  - [Examples](#examples)
- [Install](#install)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## Why this repo?

I consistently wanted to see what eBird checklists are happening in my area, easily. I didn't want to have to keep looking for them manually on the website, which only shows a few recent checklists, and I wanted to be able to see them for specific dates. As well, eBird flags certain records, but not all - so in my work as a reviewer, it makes sense to take a look at new checklists coming in to see if there are any easily-spottable errors I can contact users about. This tool provides that functionality, by opening a list of checklists for a given date from a given region. 

## Prerequisites

Before using this script, ensure you have the following:

- [eBird API Token](https://ebird.org/api/keygen)
- [curl](https://curl.se/) and Bash v3 installed on your system


## Usage

    $ ./openEbirdChecklists.sh <region> <date in mm/dd/yyyy format|today|yesterday>

This script will accept the names of Vermont counties, or the eBird
region codes, like 'US-NC' from 'https://ebird.org/region/US-NC'.

If no date is provided, it will only show the ten most recent
checklists, or however many eBird provides for recent checklists.

### Examples

    $ ./openEbirdChecklists.sh Addison 09/16/2023
    $ ./openEbirdChecklists.sh Washington yesterday
    $ ./openEbirdChecklists.sh US-VT-001 09/16/2023
    $ ./openEbirdChecklists.sh Orange

## Install

1. Replace the API token in line three with your own token. You can obtain one by registering at [eBird API Keygen](https://ebird.org/api/keygen).

Alternatively, you can set an environment variable for `$EBIRD_API_TOKEN`, eith in your PATH somewhere or temporarily like this:

   ```bash
   $ export EBIRD_API_TOKEN='your_api_token_here'
   ```

2. Make it executable. Change directory in your terminal to where the script was downloaded, and run:

    ```bash
    $ chmod a+x ebirdChecklists.sh
    ```

3. Run it using the above examples.

    ```bash
    $ EBIRD_API_TOKEN='example' ./openEbirdChecklists.sh <region> <date>
    ```

## Troubleshooting

If you encounter any issues while running the script, consider the following:

- **Invalid API Token**: Double-check that you have replaced the API token with a valid one from [eBird API Keygen](https://ebird.org/api/keygen).

- **Missing Dependencies**: Ensure that you have installed `curl` and set it up correctly.

- **Permission Denied**: If you get a "Permission denied" error when running the script, make sure you have executed `chmod a+x openEbirdChecklists.sh` as mentioned in the installation instructions.


## Contributing

Contributions to this project are welcome! If you'd like to contribute, please follow these guidelines:

- **Bug Reports**: If you encounter a bug or unexpected behavior, open an issue on the GitHub repository.

- **Feature Requests**: Feel free to suggest new features or improvements by creating an issue.

- **Pull Requests**: If you have code changes or enhancements to offer, submit a pull request. Please make sure your code follows the project's coding standards.

## License

This project is licensed under the [MIT License](LICENSE). See the [LICENSE](LICENSE) file for more details.
