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


getCardFromAPI : String -> PlayerName -> Cmd Msg
getCardFromAPI cardName pName =
    Http.get (cardUrl cardName) cardDecoder |> Http.send (ReceiveCard pName)


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
