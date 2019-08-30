# Coding Sample Instructions

REST API and modern UI

## Overview

### The Background Story

We'd like to make our software better: currently we have an existing monolith server to play a game made popular on the show “The Big Bang Theory” called Rock, Paper, Scissors, Lizard, Spock.

### Rules

Here are the rules to “Rock Paper Scissors Spock Lizard”
http://www.samkass.com/theories/RPSSL.html

## The Mission (should you choose to accept)

We'd like to swap the legacy system out with micro-services using a REST API that can be independently scaled and a modern UI.
Your goal will be to create a front-end service that users can interact with to play the game and a back-end service that takes input from the user to calculate the winner based on what the computer player chooses. The computer player’s choice is determined by a provided third-party endpoint that returns a random number between 1 and 100. Good luck and happy coding!

## Requirements

Before starting...
Take a moment to think about how long you think this will take to get done.
Send an email to the address in the footer of this document as to when you’ll have this complete.

### Submitting Your Work

Post the full source for both services to Github or your preferred source control website.
Send an email to the address in the footer of this document with a link to the repository.

### General

- Use React or Vue.js on the front-end.
- Use Go or Python on the back-end.
- Include credits in your source of what you pulled from the internet (if anything).

### Random Numbers

Use our random number endpoint for the computer's random choice any time a random number is needed:

GET: http://codechallenge.boohma.com/random

Example Result: application/json

```
{ "random_number": integer [1-100] }
```

### Hints

- Ask questions to clarify as needed
- Implement the game rules as above
- Make the game as bug-free as possible
- Add clear instructions on how to install the code
- Add any other "readme" type information

### User Interface Requirements

The user plays against a computer that randomly generates a choice
There are 5 buttons for the user to pick, each representing one of the choices
A round is played after the user makes their selection, results are displayed per round

### Game Service

Please use the following endpoints. Additional endpoints, if needed, can also be used.

#### Choices

Get all the choices that are usable for the frontend

GET: /choices
Example Result: application/json

```
[
{
  "choice": {
    "id": integer [1-5],
    "name": string [12]
  }
}
]
```

#### Choice

Get a randomly generated choice (for clients that don’t trust the server)

GET: /choice
Example Result: application/json

```
{
  "id": integer [1-5],
  "name" : string [12]
}
```

#### Play

Play a round (for servers that don’t trust the client)

POST: /play
Data: application/json

```
{
  "player": choice_id
}
```

Example Result: application/json

```
{
  "results": string [12] (win, lose, tie),
    "player": choice_id,
    "computer": choice_id
}
```

### Bonus

- Do something fun or creative with the game!
- A scoreboard with the 10 most recent results
- Allow the scoreboard to be reset
- Allow multiple users to play on the same service
