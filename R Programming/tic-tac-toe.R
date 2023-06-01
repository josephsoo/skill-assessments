#!/usr/bin/env Rscript

# A tic-tac-toe script that allows a player and a computer to play the game

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
space_check <- function(board, row, col) {
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

    # Gets the player's choice of who to play as
    cat("Do you want to play as X or O? \n")
    if (interactive()) {
        con <- stdin()
    } else {
        con <- "stdin"
    }
    input <- readLines(con = con, n = 1)

    # Interpret the player's choice
    if (toupper(input) == "X") {
        assign("playersymbol", "X", envir = .GlobalEnv)
        assign("computersymbol", "O", envir = .GlobalEnv)
        playermove(board)
    } else if (toupper(input) == "O") {
        assign("playersymbol", "O", envir = .GlobalEnv)
        assign("computersymbol", "X", envir = .GlobalEnv)
        computermove(board)
    } else {
        cat("Unknown input. You play as O \n")
        assign("playersymbol", "O", envir = .GlobalEnv)
        assign("computersymbol", "X", envir = .GlobalEnv)
        computermove(board)
    }
}

# Define a function for player's move
playermove <- function(board) {
    # Get the input from the current player
    while (TRUE) {
        cat(
            "Player", "(", playersymbol,
            "): Enter row followed by the column (1-3)\n"
        )
        if (interactive()) {
            con <- stdin()
        } else {
            con <- "stdin"
        }

        input <- readLines(con = con, n = 1)


        input <- as.numeric(input)

        if (is.na(input) || is.nan(input)) {
            cat("instructions unclear try again \n")
            next
        }

        # Validate the input

        # Extract the row and column fron the input
        row <- floor(input / 10)
        col <- input %% 10
        if (nchar(input) != 2 || (row < 1) || row > 3 || col < 1 || col > 3) {
            cat("Invalid input. Try again.\n")
            next
        }

        # Check if the move is valid
        if (!space_check(board, row, col)) {
            cat("Invalid move. Try again.\n")
            next
        }
        break
    }

    # Make the move
    board <- make_move(board, row, col, playersymbol)

    # Display the board
    display_board(board)

    gameover <- FALSE

    # Check if the current player has won
    if (has_won(board, playersymbol)) {
        cat(
            "Player", "(",
            playersymbol, ") wins!\n"
        )
        gameover <- TRUE
    }

    # Check if the board is full
    if (is_full(board)) {
        cat("It's a tie!\n")
        gameover <- TRUE
    }

    # Switch to the computer
    if (!gameover) {
        computermove(board)
    } else {
        repeatgame()
    }
}

repeatgame <- function() {
    cat("Do you want to play again? (y/n)")
    if (interactive()) {
            con <- stdin()
        } else {
            con <- "stdin"
        }
        input <- readLines(con = con, n = 1)

    if (startsWith(input, "y")) {
        play_game()
    }
}



# Make the computer's move and return to player
computermove <- function(board) {
    # Define a helper function to evaluate the score of a board state
    evaluate_board <- function(board, symbol) {
        # Check if the board is a win for the symbol
        if (has_won(board, symbol)) {
            return(10)
        }

        # Check if the board is a loss for the symbol
        if (has_won(board, switch_symbol(symbol))) {
            return(-10)
        }

        # Check if the board is a tie
        if (is_full(board)) {
            return(0)
        }

        # Otherwise, return a random score between -1 and 1
        return(runif(1, -1, 1))
    }

    # Define a helper function to switch the symbol
    switch_symbol <- function(symbol) {
        if (symbol == "X") {
            return("O")
        } else {
            return("X")
        }
    }

    # Initialize a list to store the possible moves and their scores
    moves <- list()

    # Loop through all the empty spaces on the board
    for (i in 1:3) {
        for (j in 1:3) {
            if (space_check(board, i, j)) {
                # Make a copy of the board
                board_copy <- board

                # Make the move on the copy
                board_copy <- make_move(board_copy, i, j, computersymbol)

                # Evaluate the score of the move
                score <- evaluate_board(board_copy, computersymbol)

                # Add the move and its score to the list
                moves[[length(moves) + 1]] <-
                list(row = i, col = j, score = score)
            }
        }
    }

    # Find the move with the highest score
    best_move <- moves[[1]]
    for (move in moves) {
        if (move$score > best_move$score) {
            best_move <- move
        }
    }

    # Make the best move on the board
    board <- make_move(board, best_move$row, best_move$col, computersymbol)

    # Display the board
    display_board(board)

    gameover <- FALSE

    # Check if the computer has won
    if (has_won(board, computersymbol)) {
        cat(
            "Computer", "(", computersymbol,
            ") wins!\n"
        )
        gameover <- TRUE
    }

    # Check if the board is full
    if (is_full(board)) {
        cat("It's a tie!\n")
        gameover <- TRUE
    }

    if (!gameover) {
        playermove(board)
    } else {
        repeatgame()
    }

}

# Start the game
print("start")
playersymbol <- ""
computersymbol <- ""

play_game()
