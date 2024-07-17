module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
import Http
import Json.Decode exposing (Decoder, map4, field, int, string)

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
    | Success Quote

type alias Quote = 
    { quote : String
    , source : String
    , author : String
    , year: Int 
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Loading
    , Http.get
        { url = "https://elm-lang.org/api/random-quotes"
        , expect = Http.expectJson GotQuote quoteDecoder }
    )


type Msg
    = MorePlease
    | GotQuote (Result Http.Error Quote)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        MorePlease ->
            ( Loading
            , Http.get
                { url = "https://elm-lang.org/api/random-quotes"
                , expect = Http.expectJson GotQuote quoteDecoder }
            )

        GotQuote result -> 
            case result of
                Ok quote ->
                    (Success quote, Cmd.none)
                
                Err _ -> 
                    (Failure, Cmd.none)


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Html Msg
view model =
    case model of 
        Failure ->
            div []
                [ text "I could not load a random quote for some reason. "
                , button [ onClick MorePlease ] [ text "Try Again!" ] ]

        Loading -> 
            text "Loading..."

        Success quote ->
            div []
                [ button [ onClick MorePlease, style "display" "block" ] [ text "More Please!" ] 
                , blockquote [] [ text quote.quote ]
                , p [ style "text-align" "right" ]
                    [ text "_ "
                    , cite [] [ text quote.source ]
                    , text (" by " ++ quote.author ++ " (" ++ String.fromInt quote.year ++ ")") ]
                ]

quoteDecoder : Decoder Quote
quoteDecoder = 
    map4 Quote
        (field "quote" string)
        (field "source" string)
        (field "author" string)
        (field "year" int)