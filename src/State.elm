module State exposing (..)

import Request.Card exposing (getCardFromAPI)
import Request.Deck exposing (getDeckFromAPI)
import Types exposing (..)


initialModel : Model
initialModel =
    { count = 0
    , deck = []
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, getDeckFromAPI )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReceiveCard (Err err) ->
            ( model, Cmd.none )

        ReceiveCard (Ok card) ->
            ( { model | deck = card :: model.deck }, Cmd.none )

        ReceiveDeckNames (Err err) ->
            ( model, Cmd.none )

        ReceiveDeckNames (Ok names) ->
            ( model, Cmd.batch <| List.map (\a -> getCardFromAPI a) names )
