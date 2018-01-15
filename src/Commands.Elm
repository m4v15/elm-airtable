module Commands exposing (..)

import Http exposing (..)
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode as Encode
import Models exposing (Player, PlayerId)
import Msgs exposing (Msg)
import RemoteData


playersDecoder : Decode.Decoder (List Player)
playersDecoder =
    Decode.list playerDecoder


playerDecoder : Decode.Decoder Player
playerDecoder =
    decode Player
        |> required "id" Decode.string
        |> required "name" Decode.string
        |> required "level" Decode.int


playerEncoder : Player -> Encode.Value
playerEncoder player =
    let
        attributes =
            [ ( "name", Encode.string player.name )
            , ( "level", Encode.int player.level )
            ]
    in
    Encode.object attributes


basePlayersUrl : String
basePlayersUrl =
    "http://localhost:4000/players"


editPlayerUrl : PlayerId -> String
editPlayerUrl playerId =
    basePlayersUrl ++ "/" ++ playerId


methodPlayerRequest : String -> String -> Player -> Http.Request Player
methodPlayerRequest method url player =
    Http.request
        { body = playerEncoder player |> Http.jsonBody
        , expect = Http.expectJson playerDecoder
        , headers = []
        , method = method
        , timeout = Nothing
        , url = url
        , withCredentials = False
        }


fetchPlayers : Cmd Msg
fetchPlayers =
    Http.get basePlayersUrl playersDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchPlayers


savePlayerCmd : Player -> Cmd Msg
savePlayerCmd player =
    methodPlayerRequest "PUT" (editPlayerUrl player.id) player
        |> Http.send Msgs.OnPlayerSave


addPlayerCmd : Player -> Cmd Msg
addPlayerCmd player =
    methodPlayerRequest "POST" basePlayersUrl player
        |> Http.send Msgs.OnPlayerAdd


deletePlayerCmd : Player -> Cmd Msg
deletePlayerCmd player =
    methodPlayerRequest "DELETE" (editPlayerUrl player.id) player
        |> Http.send Msgs.OnPlayerDelete
