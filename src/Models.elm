module Models exposing (..)

-- MODEL

import RemoteData exposing (WebData)


type alias Model =
    { players : WebData (List Player)
    , route : Route
    , newPlayer : Player
    }


initialModel : Route -> Model
initialModel route =
    { players = RemoteData.Loading
    , route = route
    , newPlayer =
        { id = "27"
        , name = ""
        , level = 0
        }
    }


type alias PlayerId =
    String


type alias Player =
    { id : PlayerId
    , name : String
    , level : Int
    }


type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | AddPlayerRoute
    | NotFoundRoute
