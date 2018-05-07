module State exposing (..)

import Request.Card exposing (getCard)
import Request.Deck exposing (getDeck)
import Types exposing (..)


initialModel : Model
initialModel =
    { count = 0
    , card = Card "" "" "" "" "" "" ""
    , deck = []
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetCard ->
            ( model, getCard )

        GetDeck ->
            ( model, getDeck )

        ReceiveCard (Err err) ->
            ( model, Cmd.none )

        ReceiveCard (Ok card) ->
            ( { model | card = card }, Cmd.none )

        ReceiveDeck (Err err) ->
            ( model, Cmd.none )

        ReceiveDeck (Ok deck) ->
            ( { model | deck = deck }, Cmd.none )
