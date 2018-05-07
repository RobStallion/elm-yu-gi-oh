module View exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Types exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Yu-Gi-Oh duel monsters game" ]
        , button [ onClick GetCard ] [ text "test button" ]
        ]
