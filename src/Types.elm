module Types exposing (..)

import Http


type alias Model =
    { count : Int
    , hand : List Card
    , monsters : List Card
    }


type Msg
    = ReceiveCard (Result Http.Error Card)
    | ReceiveDeckNames (Result Http.Error (List String))
    | Shuffle
    | ReceiveShuffledDeck (List Card)
    | DrawCard Int


type alias Card =
    { name : String
    , img_url : String
    , text : String
    , card_type : String
    , attack : String
    , defence : String
    , stars : String
    }
