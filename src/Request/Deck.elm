module Request.Deck exposing (..)

import Http
import Types exposing (..)
import Json.Decode as Json exposing (..)


deckUrl : String -> String
deckUrl string =
    "https://www.ygohub.com/api/set_info?name=" ++ string


getDeckFromAPI : Cmd Msg
getDeckFromAPI =
    Http.get (deckUrl "starter deck: yugi") deckDecoder |> Http.send ReceiveDeckNames


deckDecoder : Json.Decoder (List String)
deckDecoder =
    Json.field "set" <|
        Json.field "language_cards" <|
            Json.field "English (na)" <|
                Json.list <|
                    Json.field "card_name" string
