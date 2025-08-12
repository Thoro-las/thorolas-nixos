DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
CATEGORY=$( cat "$DIR/.category" )

if [ ! -d "${CATEGORY}" ]; then
   CATEGORY="default"
fi

echo "$(ls $CATEGORY/* | shuf -n1)"
