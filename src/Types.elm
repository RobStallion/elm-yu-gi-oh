module Types exposing (..)

import Http


type alias Model =
    { player1 : Player
    , player2 : Player
    }


type Msg
    = ReceiveCard PlayerName (Result Http.Error Card)
    | ReceiveDeckNames PlayerName (Result Http.Error (List String))
    | Shuffle
    | ReceiveShuffledDeck PlayerName (List Card)
    | DrawCard Int PlayerName
    | PlayCard Card PlayerName


type PlayerName
    = Yugi
    | Joey


getName : PlayerName -> String
getName playerName =
    case playerName of
        Yugi ->
            "yugi"

        Joey ->
            "joey"


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
