module State exposing (..)

import Types exposing (..)


initialModel : Model
initialModel =
    { count = 0
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CountUp ->
            ( { model | count = model.count + 1 }, Cmd.none )
