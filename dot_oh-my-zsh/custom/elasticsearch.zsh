# esdata 1000 localhost
esdata () {
  DOCSIZE=2046
  DOCUMENTS=$1

  dd if=/dev/urandom bs=$DOCSIZE count=1 | base64 | tr -d '\n' | jq --raw-input '{ data: . }' > /tmp/random.json

  # Paralllel
  for i in $(seq 1 $DOCUMENTS); do
          jq -n --argfile random /tmp/random.json --arg x $i '{ id: $x, data: ($x + $random.data) }' \
          | curl -Ss  -o /dev/null -H 'Content-Type: application/json' -XPOST -d @- \
          "http://$2:9200/harry/doc"
          echo $?
  done

  rm /tmp/random.json
}

# esperftest index search_query
esperftest () {
  local host=localhost
  local index=$1
  /usr/bin/time /usr/bin/curl -H 'Content-Type: application/json' -XPOST "$host:9200/$index/_search" -d'
  {
    "size": "10000",
    "query": {
        "bool" : {
            "must" : {
                "query_string" : {
                    "query" : "thou"
                }
            }
        }
    }
  }
  '
}
