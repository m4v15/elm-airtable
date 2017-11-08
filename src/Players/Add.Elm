module Players.Add exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Models exposing (Model)
import Msgs exposing (..)
import Players.Edit exposing (nav)


view : Model -> Html Msg
view model =
    div []
        [ Players.Edit.nav
        , addForm model
        ]


addForm : Model -> Html Msg
addForm model =
    div []
        [ input [ type_ "text", placeholder "Name", onInput (NewName model.newPlayer) ] []
        , input [ type_ "number", placeholder "Level", onInput (NewLevel model.newPlayer) ] []
        , button [ onClick AddPlayer ] [ text "Add" ]
        ]
