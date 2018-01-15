module Players.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Models exposing (Player)
import Msgs exposing (..)
import Players.List exposing (addBtn)
import Routing exposing (playersPath)


view : Player -> Html Msg
view model =
    div []
        [ nav
        , form model
        ]


nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black" ]
        [ listBtn
        , addBtn
        ]


form : Player -> Html Msg
form player =
    div [ class "m3" ]
        [ h1 []
            [ input
                [ class "h2 bold"
                , value player.name
                , onInput (ChangeName player)
                ]
                []
            ]
        , formLevel player
        ]


formLevel : Player -> Html Msg
formLevel player =
    div
        [ class "clearfix py1"
        ]
        [ div [ class "col col-5" ] [ text "Level" ]
        , div [ class "col col-7" ]
            [ span [ class "h2 bold" ] [ text (toString player.level) ]
            , btnLevelDecrease player
            , btnLevelIncrease player
            ]
        ]


btnLevelDecrease : Player -> Html Msg
btnLevelDecrease player =
    a [ class "btn ml1 h1" ]
        [ i [ class "fa fa-minus-circle", onClick (ChangeLevel player -1) ] [] ]


btnLevelIncrease : Player -> Html Msg
btnLevelIncrease player =
    a [ class "btn ml1 h1" ]
        [ i [ class "fa fa-plus-circle", onClick (ChangeLevel player 1) ] [] ]


listBtn : Html Msg
listBtn =
    a
        [ class "btn regular left p2"
        , href playersPath
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]
