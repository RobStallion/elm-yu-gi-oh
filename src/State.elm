module State exposing (..)

import Random exposing (generate)
import Random.List exposing (shuffle)
import Request.Card exposing (getCardFromAPI)
import Request.Deck exposing (getDeckFromAPI)
import Types exposing (..)


initialModel : Model
initialModel =
    { count = 0
    , monsters = []
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
            if card.card_type == "Monster" then
                { model | monsters = card :: model.monsters } ! []
            else
                model ! []

        ReceiveDeckNames (Err err) ->
            model ! []

        ReceiveDeckNames (Ok names) ->
            model ! List.map getCardFromAPI names

        Shuffle ->
            model ! [ generate ReceiveShuffledDeck <| shuffle model.monsters ]

        ReceiveShuffledDeck shuffled_deck ->
            { model | monsters = shuffled_deck } ! []

        DrawCard int ->
            { model
                | hand = List.append model.hand <| List.take int model.monsters
                , monsters = List.drop int model.monsters
            }
                ! []
