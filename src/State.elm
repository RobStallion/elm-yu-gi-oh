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
    initialModel
        ! [ getDeckFromAPI "starter deck: yugi" Yugi
          , getDeckFromAPI "starter deck: joey" Joey
          ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReceiveDeckNames _ (Err err) ->
            model ! []

        ReceiveDeckNames player (Ok names) ->
            model ! List.map (\name -> getCardFromAPI name player) names

        ReceiveCard _ (Err err) ->
            model ! []

        ReceiveCard pName (Ok card) ->
            if card.card_type == "Monster" then
                case pName of
                    Yugi ->
                        { model | player1 = addToPlayerDeck card model.player1 } ! []

                    Joey ->
                        { model | player2 = addToPlayerDeck card model.player2 } ! []
            else
                model ! []

        Shuffle ->
            model
                ! [ generate (ReceiveShuffledDeck Yugi) <| shuffle model.player1.deck
                  , generate (ReceiveShuffledDeck Joey) <| shuffle model.player2.deck
                  ]

        ReceiveShuffledDeck pName shuffled_deck ->
            case pName of
                Yugi ->
                    { model | player1 = updateDeck shuffled_deck model.player1 } ! []

                Joey ->
                    { model | player2 = updateDeck shuffled_deck model.player2 } ! []

        DrawCard int pName ->
            case pName of
                Yugi ->
                    { model | player1 = drawCard int model.player1 } ! []

                Joey ->
                    { model | player2 = drawCard int model.player2 } ! []

        PlayCard card pName ->
            case pName of
                Yugi ->
                    { model | player1 = placeCardOnField card model.player1 } ! []

                Joey ->
                    { model | player2 = placeCardOnField card model.player2 } ! []


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
