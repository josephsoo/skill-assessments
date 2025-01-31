import random

def display_board(board):
    print(board[0] + "|" + board[1] + "|" + board[2])
    print("-+-+-")
    print(board[3] + "|" + board[4] + "|" + board[5])
    print("-+-+-")
    print(board[6] + "|" + board[7] + "|" + board[8])


def player_input():
    symbol = ""
    while symbol != "X" and symbol != "O":
        symbol = input("Do you want to be X or O? ").upper()
        if symbol != "X" and symbol != "O":
            print("Invalid input! Please choose 'X' or 'O'.")
    return symbol


def place_marker(board, symbol, position):
    board[position] = symbol


def win_check(board, symbol):
    return (
        (board[0] == symbol and board[1] == symbol and board[2] == symbol)
        or (board[3] == symbol and board[4] == symbol and board[5] == symbol)
        or (board[6] == symbol and board[7] == symbol and board[8] == symbol)
        or (board[0] == symbol and board[3] == symbol and board[6] == symbol)
        or (board[1] == symbol and board[4] == symbol and board[7] == symbol)
        or (board[2] == symbol and board[5] == symbol and board[8] == symbol)
        or (board[0] == symbol and board[4] == symbol and board[8] == symbol)
        or (board[2] == symbol and board[4] == symbol and board[6] == symbol)
    )


def space_check(board, position):
    return board[position] == " "


def full_board_check(board):
    for i in range(0, 9):
        if space_check(board, i):
            return False
    return True


def player_choice(board):
    position = -1
    while True:
        entry = input("Choose your next position (1-9): ")
        if not (entry.isdigit()):
            print("Invalid input! Please choose a number between 1 and 9.")
            continue
        position = int(entry) - 1
        if position < 0 or position > 8:
            print("Invalid input! Please choose a number between 1 and 9.")
            continue
        if not space_check(board, position):
            print("This position is already occupied! Please choose another.")
            continue
        return position


def computer_choice(board, symbol):
    if symbol == "X":
        player_symbol = "O"
    else:
        player_symbol = "X"
    for i in range(0, 9):
        if space_check(board, i):
            board[i] = symbol
            if win_check(board, symbol):
                board[i] = " "
                return i
            board[i] = player_symbol
            if win_check(board, player_symbol):
                board[i] = " "
                return i
            board[i] = " "
    if space_check(board, 4):
        return 4
    while True:
        i = random.randint(0, 8)
        if space_check(board, i):
            return i


# Returns true if the player's input starts with y (probably typed in yes)
def replay():
    return (
        input("Do you want to play again? Enter 'Yes' or 'No': ")
        .lower()
        .startswith("y")
    )


while True:
    print("Welcome to Tic Tac Toe!")

    board = [" "] * 9
    player_symbol = player_input()
    if player_symbol == "X":
        computer_symbol = "O"
        print("player will go first")
        turn = "player"
    else:
        computer_symbol = "X"
        print("computer will go first")
        turn = "computer"

    game_on = True

    while game_on:
        if turn == "player":
            display_board(board)
            position = player_choice(board)
            place_marker(board, player_symbol, position)

            if win_check(board, player_symbol):
                display_board(board)
                print("Congratulations! You have won the game!")
                game_on = False
            else:
                if full_board_check(board):
                    display_board(board)
                    print("The game is a draw!")
                    game_on = False
                else:
                    turn = "computer"

        # Computer makes a move
        else:
            position = computer_choice(board, computer_symbol)
            place_marker(board, computer_symbol, position)

            if win_check(board, computer_symbol):
                display_board(board)
                print("The computer has won!")
                game_on = False
            else:
                if full_board_check(board):
                    display_board(board)
                    print("The game is a draw!")
                    break
                else:
                    turn = "player"

    if not replay():
        break

    #What does this code do
    #1. It imports the random module
    #2. It defines a function called display_board that takes in a list called board
    #3. It print