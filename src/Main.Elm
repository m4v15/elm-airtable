module Main exposing (..)

import Models exposing (..)
import Commands exposing (fetchPlayers)
import Msgs exposing (..)
import Navigation exposing (Location)
import Routing
import Update exposing (..)
import View exposing (..)


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
    ( initialModel currentRoute, fetchPlayers )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
