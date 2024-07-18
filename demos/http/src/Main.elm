module Main exposing (..)

import Browser
import Html exposing (..)
import Http


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type Model 
    = Failure
    | Loading
    | Success String


init : () -> ( Model, Cmd Msg )
init _ =
    ( Loading
    , Http.get
        { url = "https://elm-lang.org/assets/public-opinion.txt"
        , expect = Http.expectString GotText }
    )


type Msg
    = GotText ( Result Http.Error String )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        GotText result ->
            case result of
                Ok fullText ->
                    (Success fullText, Cmd.none)

                Err _ ->
                    (Failure, Cmd.none)
            

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Html Msg
view model =
    case model of
        Failure ->
            text "I was unable to become you"

        Loading ->
            text "Loading..."

        Success fullText ->
            pre [] [ text fullText ]
