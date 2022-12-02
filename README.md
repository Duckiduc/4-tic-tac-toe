# Tic Tac Toe

A simple implementation of the classic game of Tic Tac Toe using OCaml.

## Features

* Two players can play against each other
* The game automatically checks for wins and ends the game if a player wins
* Provides a simple command-line interface

## Installation

To install the project, you will need OCaml and OPAM installed on your system.

First, clone the repository:

```sh
git clone git@github.com:Duckiduc/4-tic-tac-toe.git
```
Then, navigate to the directory where you cloned the repository and run the following commands:

```sh
opam install ocaml
opam install ocamlbuild
opam install core
```
This will install the necessary dependencies.

## Usage

To run the game, navigate to the project directory and run the following command:

```sh
ocamlbuild -use-ocamlfind main.native
```
This will compile the code and create an executable main.native. Run the executable with:

```sh
./main.native
```
The game will start and you will be able to play against another player.

## License

This project is licensed under the MIT license.
