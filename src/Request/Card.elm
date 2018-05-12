module Request.Card exposing (..)

import Http
import Json.Decode as Json exposing (..)
import Json.Decode.Pipeline exposing (..)
import Regex exposing (Regex)
import Types exposing (..)


cardUrl : String -> String
cardUrl name =
    Regex.replace
        Regex.All
        (Regex.regex "#")
        (\_ -> "%23")
        ("https://www.ygohub.com/api/card_info?name=" ++ name)


getCardFromAPI : String -> Cmd Msg
getCardFromAPI str =
    Http.get (cardUrl str) cardDecoder |> Http.send ReceiveCard


cardDecoder : Json.Decoder Card
cardDecoder =
    Json.field "card"
        (decode
            Card
            |> required "name" string
            |> required "image_path" string
            |> required "text" string
            |> required "type" string
            |> optional "attack" string "attack"
            |> optional "defense" string "defense"
            |> optional "stars" string "stars"
        )
