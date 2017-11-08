module Update exposing (..)

import Commands exposing (..)
import Models exposing (..)
import Msgs exposing (..)
import RemoteData
import Routing exposing (parseLocation)


-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnFetchPlayers response ->
            ( { model | players = response }, Cmd.none )

        OnLocationChange location ->
            ( { model | route = parseLocation location }, Cmd.none )

        ChangeLevel player howMuch ->
            let
                newPlayer =
                    { player | level = player.level + howMuch }
            in
            ( model, savePlayerCmd newPlayer )

        OnPlayerSave (Ok player) ->
            ( updatePlayer model player, Cmd.none )

        OnPlayerSave (Err error) ->
            ( model, Cmd.none )

        ChangeName player newName ->
            let
                newPlayer =
                    { player | name = newName }
            in
            ( model, savePlayerCmd newPlayer )

        NewName newPlayer newName ->
            let
                playerToAdd =
                    { newPlayer | name = newName }
            in
            ( { model | newPlayer = playerToAdd }, Cmd.none )

        NewLevel newPlayer newLevel ->
            let
                intLevel =
                    Result.withDefault 0 (String.toInt newLevel)

                playerToAdd =
                    { newPlayer | level = intLevel }
            in
            ( { model | newPlayer = playerToAdd }, Cmd.none )

        AddPlayer ->
            let
                oldNewPlayer =
                    model.newPlayer

                newNewPlayer =
                    { oldNewPlayer | id = oldNewPlayer.id ++ "1" }

                newModel =
                    { model | newPlayer = newNewPlayer }
            in
            ( newModel
            , addPlayerCmd model.newPlayer
            )

        OnPlayerAdd _ ->
            ( { model | route = PlayersRoute }, fetchPlayers )

        DeletePlayer player ->
            ( model, deletePlayerCmd player )

        OnPlayerDelete _ ->
            ( model, fetchPlayers )


updatePlayer : Model -> Player -> Model
updatePlayer model newPlayer =
    let
        pick currentPlayer =
            if newPlayer.id == currentPlayer.id then
                newPlayer
            else
                currentPlayer

        updatePlayerList players =
            List.map pick players

        updatedPlayers =
            RemoteData.map updatePlayerList model.players
    in
    { model | players = updatedPlayers }
