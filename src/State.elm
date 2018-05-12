module State exposing (..)

import Random exposing (generate)
import Random.List exposing (shuffle)
import Request.Card exposing (getCardFromAPI)
import Request.Deck exposing (getDeckFromAPI)
import Types exposing (..)


initialModel : Model
initialModel =
    { player1 = Player [] [] []
    , player2 = Player [] [] []
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, getDeckFromAPI )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReceiveCard (Err err) ->
            model ! []

        ReceiveCard (Ok card) ->
            if card.card_type == "Monster" then
                { model | player1 = addToPlayerDeck card model.player1 } ! []
            else
                model ! []

        ReceiveDeckNames (Err err) ->
            model ! []

        ReceiveDeckNames (Ok names) ->
            model ! List.map getCardFromAPI names

        Shuffle ->
            model ! [ generate ReceiveShuffledDeck <| shuffle model.player1.deck ]

        ReceiveShuffledDeck shuffled_deck ->
            { model | player1 = updateDeck shuffled_deck model.player1 } ! []

        DrawCard int ->
            { model | player1 = drawCard int model.player1 } ! []

        PlayCard card ->
            { model | player1 = placeCardOnField card model.player1 } ! []


drawCard : Int -> Player -> Player
drawCard int player =
    { player
        | deck = List.drop int player.deck
        , hand = List.append player.hand <| List.take int player.deck
    }


updateDeck : List Card -> Player -> Player
updateDeck cardList player =
    { player | deck = cardList }


addToPlayerDeck : Card -> Player -> Player
addToPlayerDeck card player =
    { player | deck = card :: player.deck }


filterCard : Card -> List Card -> List Card
filterCard card cardList =
    List.filter (\x -> x /= card) cardList


placeCardOnField : Card -> Player -> Player
placeCardOnField card player =
    { player
        | hand = filterCard card player.hand
        , field = card :: player.field
    }
