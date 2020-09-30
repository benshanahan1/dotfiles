# Get Air Quality Index
#    requires `jq` (`sudo apt -y install jq`)
#    uses on https://docs.airnowapi.org/ for AQI data
AQI() {
    if [ "$#" -ne 1 ]; then
        echo "usage: AQI [zipcode]"
        echo "    returns forecasted air quality index"
    else
        echo "Air quality forecast for $1:"
        curl -s -H "Accept: application/json" -H "Content-Type: application/json" -X GET "http://www.airnowapi.org/aq/forecast/zipCode/?format=application/json&zipCode=$1&api_key=106C1BD4-D8A2-4129-A160-ADBB16DAD15D" | jq ".[0]"
    fi
}

# Get current weather
weather() {
    curl "wttr.in/$1?format=3 "
}
alias wttr="weather "
alias forecast="weather "
alias temp="weather "
