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
        , button [ class "pointer", onClick <| DrawCard (6 - List.length model.player1.hand) Yugi ] [ text "Draw" ]
        , button [ class "pointer", onClick <| DrawCard (6 - List.length model.player2.hand) Joey ] [ text "Draw" ]
        , div [ class "flex justify-around h5" ] <| List.map (displayHand Yugi) model.player1.hand
        , div [ class "flex h5" ] <| List.map displayCard model.player1.field
        , div [ class "flex h5" ] <| List.map displayCard model.player2.field
        , div [ class "flex justify-around h5" ] <| List.map (displayHand Joey) model.player2.hand
        ]


displayHand : PlayerName -> Card -> Html Msg
displayHand pName card =
    div
        [ class "cardsize bg-center contain pointer"
        , style
            [ ( "background-image", "url(" ++ card.img_url ++ ")" )
            ]
        , onClick <| PlayCard card pName
        ]
        []


displayCard : Card -> Html Msg
displayCard card =
    div
        [ class "bg-center contain w5 inline-flex"
        , style
            [ ( "background-image", "url(" ++ card.img_url ++ ")" )
            ]
        ]
        []
