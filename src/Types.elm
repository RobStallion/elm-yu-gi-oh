module Types exposing (..)

import Http


type Msg
    = ReceiveCard (Result Http.Error Card)
    | ReceiveDeckNames (Result Http.Error (List String))


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
    , deck : List Card
    }
