module State exposing (..)

import Types exposing (..)
import Request.Card exposing (..)


initialModel : Model
initialModel =
    { count = 0
    , card = Card "" "" "" "" "" "" ""
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetCard ->
            ( model, getCard )

        ReceiveCard (Err err) ->
            ( model, Cmd.none )

        ReceiveCard (Ok card) ->
            ( { model | card = card }, Cmd.none )
