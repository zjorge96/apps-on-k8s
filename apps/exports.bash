if [[ $- == *u* ]]; then
    unset $(grep -v '^#' .env | sed -E 's/(.*)=.*/\1/' | xargs)
else
    export $(grep -v '^#' .env | xargs)
fi
