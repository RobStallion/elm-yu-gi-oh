module Request.Card exposing (..)

import Http
import Json.Decode as Json exposing (..)
import Json.Decode.Pipeline exposing (..)
import Types exposing (..)


cardUrl : String -> String
cardUrl name =
    "https://www.ygohub.com/api/card_info?name=" ++ name


getCard : Cmd Msg
getCard =
    Http.get (cardUrl "dark magician") cardDecoder |> Http.send ReceiveCard


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
