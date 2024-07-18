module Main exposing (main)

import Browser
import Html exposing (..)
import Time 
import Task
import Html.Attributes exposing (style)
import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, src)
import Html.Styled.Events exposing (onClick)

main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model = {
    currentTime: Time.Posix,
    targetTime: Time.Posix
    }


init : () -> ( Model, Cmd Msg )
init _ =
    (Model (Time.millisToPosix 0) (Time.millisToPosix 1721689200000), Task.perform Tick Time.now )


type Msg
    = Tick Time.Posix

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( { model | currentTime = newTime}, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions _ = Time.every 1000 Tick


view : Model -> Html.Html Msg
view model =
    let 
        remaining = 
            Time.posixToMillis model.targetTime - Time.posixToMillis model.currentTime
        days =
            remaining // (24 * 60 * 60 * 1000)
        hours =
            (remaining // 1000 // 60 // 60 // 60) + 12
        minutes = 
            modBy 60 (remaining // 1000 // 60)
        seconds =
            modBy 60 (remaining // 1000)
    in 
        Html.Styled.toUnstyled <|
        Html.Styled.div [ css
            [ height (vh 100)
            , backgroundColor (hex "000000")
            , border3 (px 1) solid (hex "000000")
            , borderRadius (px 5)
            , fontSize (px 30)
            , color (hex "00FFFF")
            , fontFamily monospace
            , overflow hidden
            ] ] 
            [
                Html.Styled.div [ css [ position relative, top (px 120), textAlign center, color (hex "000FF") ] ] [ Html.Styled.text ("Time Left Until Ayman's Birthday :3") ] 
                , Html.Styled.img [src "https://user-images.githubusercontent.com/74038190/212284158-e840e285-664b-44d7-b79b-e264b5e54825.gif", css [ margin2 (px 10) (auto), textAlign center, display block ]] []
                , Html.Styled.div 
                [ css 
                    [ displayFlex 
                    , justifyContent center
                    , alignItems center
                    , textAlign center
                    , borderRadius (px 10)
                    , border3 (px 1) (solid) (hex "ffffff")
                    , margin4 (px 100) (px 50) (px 15) (px 50)
                    , padding2 (px 20) (px 20) ]
                ]
                [ Html.Styled.div [ css [ marginRight (px 20), textAlign center, color (hex "ffffff") ] ] [ Html.Styled.text ("Days: " ++ String.fromInt days ++ ". ") ]
                , Html.Styled.div [ css [ marginRight (px 20), textAlign center, color (hex "ffffff") ] ] [ Html.Styled.text (" Hours: " ++ String.fromInt hours ++ ". ") ]
                , Html.Styled.div [ css [ marginRight (px 20), textAlign center, color (hex "ffffff") ] ] [ Html.Styled.text (" Minutes: " ++ String.fromInt minutes ++ ". ") ]
                , Html.Styled.div [ css [ marginRight (px 20), textAlign center, color (hex "ffffff") ] ] [ Html.Styled.text (" Seconds: " ++ String.fromInt seconds ++ ". ") ]
                ]
                , Html.Styled.img [src "./nge.png", css [ display block, width (px 600), height (px 600) ]] []
            ]
