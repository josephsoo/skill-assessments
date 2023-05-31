#!/usr/bin/env Rscript

# A tic-tac-toe script that allows two players to play the game on a 3x3 board

# Define a function to create an empty board
create_board <- function() {
    board <- matrix("", nrow = 3, ncol = 3)
    return(board)
}

# Define a function to display the board
display_board <- function(board) {
    cat("\n")
    cat(" ", board[1, 1], "|", board[1, 2], "|", board[1, 3], "\n")
    cat("-----------\n")
    cat(" ", board[2, 1], "|", board[2, 2], "|", board[2, 3], "\n")
    cat("-----------\n")
    cat(" ", board[3, 1], "|", board[3, 2], "|", board[3, 3], "\n")
    cat("\n")
}

# Define a function to check if a move is valid
is_valid_move <- function(board, row, col) {
    if (row < 1 || row > 3 || col < 1 || col > 3) {
        return(FALSE)
    }
    if (board[row, col] != "") {
        return(FALSE)
    }
    return(TRUE)
}

# Define a function to make a move
make_move <- function(board, row, col, symbol) {
    board[row, col] <- symbol
    return(board)
}

# Define a function to check if the board is full
is_full <- function(board) {
    return(all(board != ""))
}

# Define a function to check if a player has won
has_won <- function(board, symbol) {
    # Check rows
    for (i in 1:3) {
        if (all(board[i, ] == symbol)) {
            return(TRUE)
        }
    }

    # Check columns
    for (j in 1:3) {
        if (all(board[, j] == symbol)) {
            return(TRUE)
        }
    }

    # Check diagonals
    if (all(diag(board) == symbol)) {
        return(TRUE)
    }

    if (all(diag(t(board)) == symbol)) {
        return(TRUE)
    }

    # No winner
    return(FALSE)
}

# Define a function to play the game
play_game <- function() {
    # Create an empty board
    board <- create_board()

    # Display the board
    display_board(board)

    # Set the symbols for the players
    symbols <- c("X", "O")

    # Set the current player to be the first one

    # Gets the player's choice of who to play as
    cat("Do you want to play as X or O?")
    if (interactive()) {
            con <- stdin()
        } else {
            con <- "stdin"
        }
    input <- readLines(con = con, n = 1)
    if (tolower(input) == "x") {
        playersymbol <- "X"
        playermove(playersymbol)
    } else {
        playersymbol <- "O"
        computermove(playersymbol)
    }
}

playermove <- function(playersymbol) {
     # Get the input from the current player
        cat(
            "Player", "(", playersymbol,
            "): Enter row followed by the column (1-3)\n"
        )
        if (interactive()) {
            con <- stdin()
        } else {
            con <- "stdin"
        }
        input <- as.numeric(readLines(con = con, n = 1))

        # Validate the input

        # Extract the row and column fron the input
        row <- floor(input/10)
        col <- input %% 10
        if (nchar(input) != 2 || (row < 1) || row > 3 || col < 1 || col > 3) {
            cat("Invalid input. Try again.\n")
            next
        }

        # Check if the move is valid
        if (!is_valid_move(board, row, col)) {
            cat("Invalid move. Try again.\n")
            next
        }
        # Make the move
        board <- make_move(board, row, col, playersymbol)

        # Display the board
        display_board(board)

}






    # Loop until the game is over
    while (TRUE) {


        # Get the input from the current player
        cat(
            "Player", current_player, "(", symbols[current_player],
            "): Enter row followed by the column (1-3)\n"
        )
        if (interactive()) {
            con <- stdin()
        } else {
            con <- "stdin"
        }
        input <- as.numeric(readLines(con = con, n = 1))

        # Validate the input
        
        print(input)
        print(nchar(input))
        row <- floor(input/10)
        col <- input %% 10
        if (nchar(input) != 2 || (row < 1) || row > 3 || col < 1 || col > 3) {
            cat("Invalid input. Try again.\n")
            next
        }

        # Check if the move is valid
        if (!is_valid_move(board, row, col)) {
            cat("Invalid move. Try again.\n")
            next
        }

        # Make the move
        board <- make_move(board, row, col, symbols[current_player])

        # Display the board
        display_board(board)

        # Check if the current player has won
        if (has_won(board, symbols[current_player])) {
            cat("Player", current_player, "(", 
            symbols[current_player], ") wins!\n")
            break
        }

        # Check if the board is full
        if (is_full(board)) {
            cat("It's a tie!\n")
            break
        }

        # Switch to the next player
        current_player <- current_player %% 2 + 1
        computermove(symbols[current_player]);
        current_player <- current_player %% 2 + 1
    }


# Make the computer's move and return to player
computermove <- function(symbol) {


}

# Start the game
print("start")
play_game()
