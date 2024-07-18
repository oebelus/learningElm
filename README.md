# Some Notes from the [Elm Documentation ](https://guide.elm-lang.org)

### HOW TO START A PROJECT

```
elm init
```

Go to src and create a Main.elm;

## CORE LANGUAGE

Some code snippets that I might wanna go back to later (because I will forget the syntax):

-> To update values of a record with `map`

```elm
List.map .key [dictionary_name, dictionary_name, dictionary_name]

{ dictionary_name | key = val }
```

When updating a recordm a new one gets created; the original one doesn't get modified;

A function to update some key in the dictionary:

```elm
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

```elm
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

```elm
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

```elm
type alias Model = Int
```

The counter should be ofc initialized:

```elm
init : Model
init =
  0
```

3. UPDATE
   Now we have a model with the initial value, and we need to update it, that's where VIEW comes;

I first define the types, so I get a clear idea of what I am going to do:
`type Msg = Increment | Decrement | Reset | Ten`
And then I create an update function to describe what I want to do:

```elm
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

```elm
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

## COMMANDS AND SUBSCRIPTIONS

The Elm architecture handles mouse and keyboard interactions, as well as communicating with servers and generating random numbers. Let's see how;

### `sandbox`:

-> Model + Update + View (By isolating all DOM manipulation, Elm allows for highly aggressive optimizations, making its runtime system a key factor in why Elm is one of the fastest frameworks available.);
![sandbox](https://guide.elm-lang.org/effects/diagrams/sandbox.svg)

### `element`:

-> This will introduce the ideas of commands and subscriptions which allow us to interact with the outside world.

![sandbox](https://guide.elm-lang.org/effects/diagrams/element.svg)

-> In addition to producing `Html` values, the programs will also send `Cmd` and `Sub` values to the runtime system.

-> The programs can command the runtime system to make an HTTP request ot to generate a random number;

1. HTTP: (link)[]
   The GET request -> we specify the url of the data we want to fetch, and we specify what we expect that data to be;

- `init`:

```elm
init : () -> (Model, Cmd Msg)
init _ =
  ( Loading
  , Http.get
      { url = "https://elm-lang.org/assets/public-opinion.txt"
      , expect = Http.expectString GotText
      }
  )
```

The `Http.expectString GotText` line says that when we get a response, it should be turned into a `GotText` message;

```elm
type Msg = GotText ( Result Http.Error String )
-- Http.Error if failure, String if success
```

- `update`:
  -> It doesn't just return an updated model, it's also producing a command of what we want Elm to do; <br>
  -> `Cmd.none` says that that there is no more work to do. And in the case that there was some error, we also say Cmd.none and just give up XDDD.

- `subscription`:
  The other new thing in this program is the subscription function. It lets you look at the Model and decide if you want to subscribe to certain information. In our example, we say S`ub.none` to indicate that we do not need to subscribe to anything. <br>

2. JSON

3. Random

```elm
usuallyTrue : Random.Generator Bool
usuallyTrue =
  Random.weighted (80, True) [ (20, False) ]
```

-> It will produce a Bool, true 80% of the time and false 20% of the time.<br>
-> Mapping in Random.generate: When you use Random.generate, you provide a function that translates the generated value into a message (Msg). This function takes the generated value (of type a) and adapts it to fit the expected message type (Msg).<br>
-> Using identity: In the update function, if you have a generator (generator) that outputs a tuple (Numbers, Numbers), you can directly convert this tuple into a Msg type (NewFaces Numbers Numbers) using identity. identity simply passes through its argument unchanged, making it suitable for situations where you want to use the generated value without alteration.

4. Time
   To work with time, we need 3 concepts:

- Human time (clocks);
- POSIX time: seconds elapsed since some moment (1970);
- Time Zones
  -> We'll use `Time.Posix` and `Time.Zone`;

## COMPILING TO JS

Running elm make produces HTML files by default. This produces `index.html`;

`elm make src/Main.elm`

To produce JavaScript, run this command:
`elm make src/Main.elm --output=main.js`

## FLAGS:

They are a way to pass values into Elm on initialization: API keys, environment variables, user data, cached information in localStorage... etc.
-> Adding the `flags` argument to the `Elm.Main.init()` (any JS value that can be JSON decoded can be given as a flag)

```elm
var app = Elm.Main.init({
    node: document.getElementById("elm"),
    flags: Dte.now()
});
```

## MY SOLUTIONS LINKS

- [Buttons](https://github.com/oebelus/learningElm/tree/main/buttons)
- [Forms](https://github.com/oebelus/learningElm/tree/main/forms)
- [Text Fields](https://github.com/oebelus/learningElm/tree/main/text-fields)
- [Fahrenheit to Celsius](https://github.com/oebelus/learningElm/tree/main/toFahrenheit) - Maybe

## LIST OF THINGS I LIKE ABOUT ELM:

-> The cute friendly error messages that make me smile everytime <br>
-> The concise documentation <br>
-> The simple syntax <br>
