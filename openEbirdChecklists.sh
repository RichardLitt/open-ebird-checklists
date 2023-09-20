#!/bin/bash

# Set this here if you don't want to use an env variable
# EBIRD_API_TOKEN=''

# Check if the script is called with an argument
if [ $# -lt 1 -o $# -gt 2 ]; then
    echo "# eBird Checklists"
    echo ""
    echo "A script to automatically open all checklists from an eBird region."
    echo ""
    echo "## Usage"
    echo ""
    echo "$ $0 <region> <date in mm/dd/yyyy format|today|yesterday>"
    echo ""
    echo "This script will accept the names of Vermont counties, or the eBird"
    echo "region codes, like 'US-NC' from 'https://ebird.org/region/US-NC'."
    echo ""
    echo "If no date is provided, it will only show the ten most recent"
    echo "checklists, or however many eBird provides for recent checklists."
    echo ""
    echo "### Examples"
    echo ""
    echo "    $ $0 Addison 09/16/2023"
    echo "    $ $0 Washington yesterday"
    echo "    $ $0 US-VT-001 09/16/2023"
    echo "    $ $0 Orange"
    echo ""
    echo "## Install"
    echo ""
    echo "Replace the API token in line three with your own token."
    echo "Go to https://ebird.org/api/keygen to register your own."
    echo "You can also add an env variable for $EBIRD_API_TOKEN, or run:"
    echo "    $ EBIRD_API_TOKEN='example' $0 <region> <date>"
    echo ""
    echo "Then, change directory in your terminal to where the script"
    echo "was downloaded, and then run:"
    echo "    $ chmod a+x ebirdChecklists.sh"
    echo "Then, run using the above examples."
    echo ""
    exit 1
fi

# Check if jq is installed
if ! command -v jq &>/dev/null; then
    echo "Error: 'jq' is not installed. Please install it to run this script."
    exit 1
fi

# Bash v3 doesn't allow associative arrays yet
keys=()
values=()

# Function to add key-value pairs
add_key_value() {
  keys+=("$1")
  values+=("$2")
}

# Function to get a value by key
get_value() {
  local key="$1"
  for ((i = 0; i < ${#keys[@]}; i++)); do
    if [[ "${keys[i]}" == "$key" ]]; then
      echo "${values[i]}"
      return
    fi
  done
  # Pass through if not a Vermont county
  echo "$key"
}

add_key_value "Addison" "US-VT-001"
add_key_value "Bennington" "US-VT-003"
add_key_value "Caledonia" "US-VT-005"
add_key_value "Chittenden" "US-VT-007"
add_key_value "Essex" "US-VT-009"
add_key_value "Franklin" "US-VT-011"
add_key_value "Grand" "US-VT-013"
add_key_value "Lamoille" "US-VT-015"
add_key_value "Orange" "US-VT-017"
add_key_value "Orleans" "US-VT-019"
add_key_value "Rutland" "US-VT-021"
add_key_value "Washington" "US-VT-023"
add_key_value "Windham" "US-VT-025"
add_key_value "Windsor" "US-VT-027"

# Get the input string from the command-line argument
input_string="$1"

# Lookup the parameter in the associative array
input_string="$(get_value $input_string)"

# Function to execute when there is no argument
without_date_argument() {
  # Use curl to fetch the JSON object
  # Replace this token if you use it! This is my (Richard's) token.
  # echo "$parameter"
  json_data=$(curl --location 'https://api.ebird.org/v2/product/lists/'$1 --header 'X-eBirdApiToken: '$EBIRD_API_TOKEN)

  # Check if the curl command was successful
  if [ $? -ne 0 ]; then
    echo "Error: Curl command failed."
    exit 1
  fi

  # Use jq to extract URLs from the JSON data (assuming URLs are in a "urls" array)
  extracted_urls=$(echo "$json_data" | jq .[].subId)
}

# Function to execute when an argument is provided
with_date_argument() {

  # Function to format yesterday's date without using -d flag because Bash v3
  format_yesterday() {
    # Get the current date in the format "mm/dd/yyyy"
    current_date=$(date "+%m/%d/%Y")

    # Split the current date into components (month, day, year)
    IFS="/" read -a date_components <<< "$current_date"
    month="${date_components[0]}"
    day="${date_components[1]}"
    year="${date_components[2]}"

    # Calculate yesterday's date
    if [ "$day" -eq 1 ]; then
      if [ "$month" -eq 1 ]; then
        # If it's the first day of the year, go to the last day of the previous year
        month=12
        day=31
        ((year--))
      else
        # If it's the first day of a month, go to the last day of the previous month
        ((month--))
        day=$(cal "$month" "$year" | grep -oP '\d{2}' | tail -n 1)
      fi
    else
      # Subtract one day from the day component
      ((day--))
    fi


    # Format yesterday's date as "mm/dd/yyyy"
    formatted_date=$(printf "%02s/%02d/%04d" "$month" "$day" "$year")
    echo "$formatted_date"
  }

  # Check if the input is "today" or "tomorrow" and calculate the respective dates
  if [ "$2" == "today" ]; then
    date_string=$(date "+%m/%d/%Y")
  elif [ "$2" == "yesterday" ]; then
    date_string=$(format_yesterday)
  else
    # If it's not "today" or "tomorrow," assume it's a formatted date
    date_string="$2"
  fi

  # Extract day, month, and year from the date string
  day=$(echo "$date_string" | cut -d'/' -f2)
  month=$(echo "$date_string" | cut -d'/' -f1)
  year=$(echo "$date_string" | cut -d'/' -f3)

  # Convert the month number to the abbreviated month name
  case "$month" in
    01) month="Jan" ;;
    02) month="Feb" ;;
    03) month="Mar" ;;
    04) month="Apr" ;;
    05) month="May" ;;
    06) month="Jun" ;;
    07) month="Jul" ;;
    08) month="Aug" ;;
    09) month="Sep" ;;
    10) month="Oct" ;;
    11) month="Nov" ;;
    12) month="Dec" ;;
    *) echo "Invalid month"; exit 1 ;;
  esac

  # Formatted date
  formatted_date="$day $month $year"

  # Use curl to fetch the JSON object
  json_data=$(curl --location 'https://api.ebird.org/v2/product/lists/'$input_string'?maxResults=200' --header 'X-eBirdApiToken: '$EBIRD_API_TOKEN)

  # Check if the curl command was successful
  if [ $? -ne 0 ]; then
    echo "Error: Curl command failed."
    exit 1
  fi

  # Use jq to extract URLs from the JSON data (assuming URLs are in a "urls" array)
  extracted_urls=$(echo "$json_data" | jq --arg searchDate "$formatted_date" '
    .[] |
    select(.obsDt == $searchDate) | .subId
  ')
}

# Check if the script is called with a date. If so, filter. If not, only get the latest 10 reports.
if [ $# -eq 1 ]; then
  # echo 'Without date argument'
  without_date_argument $input_string
else
  # echo 'With date argument'
  with_date_argument "$1" "$2"
fi

# Loop through each ChecklistID in a list of IDs and open it in a web browser
prefix="https://ebird.org/checklist/"

if [ ${#extracted_urls[@]} -eq 0 ]; then
    echo "There are no recent checklists, or checklists on the given day in the given region."
else
    for checklistId in $extracted_urls; do
      checklistId=$(echo $checklistId | tr -d '"')
      checklistUrl=$(printf "%s%s\n" "$prefix" $checklistId)
      echo "Opening URL: $checklistUrl"
      open "$checklistUrl"
      # Be nice to the API
      sleep .5
    done
fi
