module State exposing (..)

import Types exposing (..)
import Request.Card exposing (..)


initialModel : Model
initialModel =
    { count = 0
    , card = MCard "" "" "" "" "" "" ""
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, getCard )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CountUp ->
            ( { model | count = model.count + 1 }, Cmd.none )

        ReceiveCard (Err err) ->
            ( model, Cmd.none )

        ReceiveCard (Ok card) ->
            ( { model | card = card.card }, Cmd.none )
