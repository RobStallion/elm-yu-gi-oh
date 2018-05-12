module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)
import Types exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Yu-Gi-Oh duel monsters game" ]
        , button [ class "pointer", onClick Shuffle ] [ text "Shuffle" ]
        , button [ class "pointer", onClick <| DrawCard <| 6 - List.length model.player1.hand ] [ text "Draw" ]
        , div [ class "flex justify-around h5" ] <| List.map displayCard model.player1.hand
        , div [ class "flex justify-around h5" ] <| List.map displayCard model.player1.field
        , div [ class "flex justify-around h5" ] <| List.map displayCard model.player2.field
        , div [ class "flex justify-around h5" ] <| List.map displayCard model.player2.hand
        ]


displayCard : Card -> Html Msg
displayCard card =
    div
        [ class "bg-center contain w5 inline-flex pointer"
        , style
            [ ( "background-image", "url(" ++ card.img_url ++ ")" )
            ]
        , onClick <| PlayCard card
        ]
        []
