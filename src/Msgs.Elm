module Msgs exposing (..)

import Http
import Models exposing (Player)
import Navigation exposing (Location)
import RemoteData exposing (WebData)


type Msg
    = OnFetchPlayers (WebData (List Player))
    | OnLocationChange Location
    | ChangeLevel Player Int
    | OnPlayerSave (Result Http.Error Player)
    | ChangeName Player String
    | NewName Player String
    | NewLevel Player String
    | AddPlayer
    | OnPlayerAdd (Result Http.Error Player)
    | DeletePlayer Player
    | OnPlayerDelete (Result Http.Error Player)
