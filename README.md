# eBird Checklists

A script to automatically open all checklists from an eBird region.

## Usage

`$ ./addString.sh <region> <date in mm/dd/yyyy format|today|yesterday>`

This script will accept the names of Vermont counties, or the eBird
region codes, like 'US-NC' from 'https://ebird.org/region/US-NC'.

If no date is provided, it will only show the ten most recent
checklists, or however many eBird provides for recent checklists.

### Examples

```
    $ ./addString.sh Addison 09/16/2023
    $ ./addString.sh Washington yesterday
    $ ./addString.sh US-VT-001 09/16/2023
    $ ./addString.sh Orange
```

## Install

Replace the API token in line three with your own token.
Go to https://ebird.org/api/keygen to register your own.
You can also add an env variable for a6ebaopct2l3, or run:
    
    `$ EBIRD_API_TOKEN='example' ./addString.sh <region> <date>`

Then, change directory in your terminal to where the script
was downloaded, and then run:

    `$ chmod a+x ebirdChecklists.sh`

Then, run using the above examples.

## Contribute

Sure.

## License

See [License](LICENSE).