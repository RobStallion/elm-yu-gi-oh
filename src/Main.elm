module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)


type alias Model =
    { count : Int
    }


type Msg
    = CountUp


initialModel : Model
initialModel =
    { count = 0
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Yu-Gi-Oh duel monsters game" ]
        , button [ onClick CountUp ] [ text "test button" ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CountUp ->
            ( { model | count = model.count + 1 }, Cmd.none )


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
