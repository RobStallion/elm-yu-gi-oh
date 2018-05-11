module State exposing (..)

import Random exposing (generate)
import Random.List exposing (shuffle)
import Request.Card exposing (getCardFromAPI)
import Request.Deck exposing (getDeckFromAPI)
import Types exposing (..)


initialModel : Model
initialModel =
    { count = 0
    , deck = []
    , hand = []
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, getDeckFromAPI )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReceiveCard (Err err) ->
            model ! []

        ReceiveCard (Ok card) ->
            { model | deck = card :: model.deck } ! []

        ReceiveDeckNames (Err err) ->
            model ! []

        ReceiveDeckNames (Ok names) ->
            model ! List.map getCardFromAPI names

        Shuffle ->
            model ! [ generate ReceiveShuffledDeck <| shuffle model.deck ]

        ReceiveShuffledDeck shuffled_deck ->
            { model | deck = shuffled_deck } ! []

        DrawCard int ->
            { model
                | hand = List.take int model.deck
                , deck = List.drop int model.deck
            }
                ! []
