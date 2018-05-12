module Types exposing (..)

import Http


type alias Model =
    { player1 : Player
    , player2 : Player
    }


type Msg
    = ReceiveCard (Result Http.Error Card)
    | ReceiveDeckNames (Result Http.Error (List String))
    | Shuffle
    | ReceiveShuffledDeck (List Card)
    | DrawCard Int
    | PlayCard Card


type alias Card =
    { name : String
    , img_url : String
    , text : String
    , card_type : String
    , attack : String
    , defence : String
    , stars : String
    }


type alias Player =
    { hand : List Card
    , deck : List Card
    , field : List Card
    }
