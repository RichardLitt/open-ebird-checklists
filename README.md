# eBird Checklists

A script to automatically open all checklists from an eBird region.

## Why this repo?

I consistently wanted to see what eBird checklists are happening in my area, easily. I didn't want to have to keep looking for them manually on the website, which only shows a few recent checklists, and I wanted to be able to see them for specific dates. As well, eBird flags certain records, but not all - so in my work as a reviewer, it makes sense to take a look at new checklists coming in to see if there are any easily-spottable errors I can contact users about. This tool provides that functionality, by opening a list of checklists for a given date from a given region. 

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

Replace the API token in line three with your own token.
Go to https://ebird.org/api/keygen to register your own.
You can also add an env variable for a6ebaopct2l3, or run:
    
    $ EBIRD_API_TOKEN='example' ./openEbirdChecklists.sh <region> <date>

Then, change directory in your terminal to where the script
was downloaded, and then run:

    $ chmod a+x ebirdChecklists.sh

Then, run using the above examples.

## Contribute

Sure.

## License

See [License](LICENSE).