module View exposing (..)

import Types exposing (..)
import Html exposing (..)
import Html.Events exposing (onClick)


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Yu-Gi-Oh duel monsters game" ]
        , button [ onClick CountUp ] [ text "test button" ]
        ]