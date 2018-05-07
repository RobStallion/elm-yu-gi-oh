module Types exposing (..)

import Http


type Msg
    = GetCard
    | ReceiveCard (Result Http.Error Card)
    | GetDeck
    | ReceiveDeck (Result Http.Error (List String))


type alias Card =
    { name : String
    , img : String
    , text : String
    , card_type : String
    , attack : String
    , defence : String
    , stars : String
    }


type alias Model =
    { count : Int
    , card : Card
    , deck : List String
    }
