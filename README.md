# Some Notes from the [Elm Documentation ](https://guide.elm-lang.org)

## CORE LANGUAGE
Some code snippets that I might wanna go back to later (because I will forget the syntax):

-> To update values of a record with `map`
```
> List.map .key [dictionary_name, dictionary_name, dictionary_name]

> { dictionary_name | key = val }
```
When updating a recordm a new one gets created; the original one doesn't get modified; 

A function to update some key in the dictionary: 
```
func arg = 
    { arg | key = arg.key + 1 }
```

## THE ELM ARCHITECTURE

### THE BASIC PATTERN

How Elm works:
1- Elm renders the initial state on the screen; 
2- It waits for the user input;
3- It sends a message to the `update`;
4- The `update` does the necessary changes and produces a new model; 
5- The `view` is called to get new HTML; 
6- New HTML is shown on the screen;
7- Go back to step 1 (YAAY 7)

```
{ init = init
, view = view
, update = update
}
```

![Elm Program](https://guide.elm-lang.org/architecture/buttons.svg)

What really happens? The Elm program breaks into three parts:
-> Model: The state of the application
-> View: A way to turn the state into HTML
-> Update: a way to update your state based on messages

### SOME CONCEPTS: [Buttons](https://guide.elm-lang.org/architecture/buttons)

1. MAIN
-> `main`: it describes what gets shown in the screen.
```
main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
```
> We initialize with `init`, show stuff on the screen with `view` and user input will be updated with `update`


2. MODEL
The purpose of `model` is to capture all the details about the applications as data; 

To make a counter, I need to keep track of the number that is incremented or decremented:
```
type alias Model = Int
```

The counter should be ofc initialized: 
```
init : Model
init =
  0
```

3. UPDATE
Now we have a model with the initial value, and we need to update it, that's where VIEW comes; 

I first define the types, so I get a clear idea of what I am going to do:
```type Msg = Increment | Decrement | Reset | Ten```
And then I create an update function to describe what I want to do:
```
update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1

    Reset ->
        0

    Ten -> 
        model + 10
```

4. VIEW:
Now I settled up my model with initial values and function to update it, I have to show it on the screen:
```
view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (String.fromInt model) ]
    , button [ onClick Increment ] [ text "+" ]
    , button [ onClick Ten ] [ text "+10" ]
    , button [ onClick Reset ] [ text "reset" ]
    ]
```
The view takes a model as an argument and returns HTML; 

## COMPILING TO JS
Running elm make produces HTML files by default. This produces `index.html`;

```elm make src/Main.elm```

To produce JavaScript, run this command:
```elm make src/Main.elm --output=main.js```

## FLAGS: 
They are a way to pass values into Elm on initialization: API keys, environment variables, user data, cached information in localStorage... etc. 
    -> Adding the `flags` argument to the `Elm.Main.init()` (any JS value that can be JSON decoded can be given as a flag)

```
var app = Elm.Main.init({ 
    node: document.getElementById("elm"),
    flags: Dte.now()
});
```

## LIST OF THINGS I LIKE ABOUT ELM:
-> The cute friendly error messages that make me smile everytime
-> The concise documentation
-> The simple syntax