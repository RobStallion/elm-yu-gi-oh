module Types exposing (..)

import Http


type Msg
    = CountUp
    | ReceiveCard (Result Http.Error CardObj)


type Card
    = Monster
    | Spell


type alias CardObj =
    { card : MCard
    }


type alias MCard =
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
    , card : MCard
    }
