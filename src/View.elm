module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)
import Types exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Yu-Gi-Oh duel monsters game" ]
        , button [ onClick Shuffle ] [ text "Shuffle" ]
        , button [ onClick <| DrawCard <| 6 - List.length model.hand ] [ text "Draw" ]
        , div [] <| List.map displayCard model.hand
        ]


displayCard : Card -> Html Msg
displayCard card =
    div
        [ class "bg-center contain w5 inline-flex"
        , style
            [ ( "background-image", "url(" ++ card.img_url ++ ")" )
            , ( "height", "350px" )
            ]
        ]
        []
