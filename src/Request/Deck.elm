module Request.Deck exposing (..)

import Types exposing (..)


deckUrl : String -> String
deckUrl string =
    "https://www.ygohub.com/api/set_info?name=" ++ string


getDeck : Cmd Msg
getDeck =
    Cmd.none
