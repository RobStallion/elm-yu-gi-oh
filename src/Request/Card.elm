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
    Http.get (cardUrl "dark magician") cardObjDecoder |> Http.send ReceiveCard


cardDecoder : Json.Decoder MCard
cardDecoder =
    decode MCard
        |> required "name" string
        |> required "image_path" string
        |> required "text" string
        |> required "type" string
        |> required "attack" string
        |> required "defense" string
        |> required "stars" string


cardObjDecoder : Json.Decoder CardObj
cardObjDecoder =
    decode CardObj
        |> required "card" cardDecoder
