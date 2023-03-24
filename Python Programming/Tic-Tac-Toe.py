import random
import logging

logging.basicConfig(level=logging.WARNING)


def display_board(board):
    print(board[0] + '|' + board[1] + '|' + board[2])
    print('-+-+-')
    print(board[3] + '|' + board[4] + '|' + board[5])
    print('-+-+-')
    print(board[6] + '|' + board[7] + '|' + board[8])


def player_input():
    symbol = ''
    while symbol != 'X' and symbol != 'O':
        symbol = input("Do you want to be X or O? ").upper()
        if symbol != 'X' and symbol != 'O':
            logging.warning("Invalid input! Please choose 'X' or 'O'.")
    return symbol


def place_marker(board, symbol, position):
    board[position] = symbol


def win_check(board, symbol):
    return (
            (board[0] == symbol and board[1] == symbol and board[2] == symbol) or
            (board[3] == symbol and board[4] == symbol and board[5] == symbol) or
            (board[6] == symbol and board[7] == symbol and board[8] == symbol) or
            (board[0] == symbol and board[3] == symbol and board[6] == symbol) or
            (board[1] == symbol and board[4] == symbol and board[7] == symbol) or
            (board[2] == symbol and board[5] == symbol and board[8] == symbol) or
            (board[0] == symbol and board[4] == symbol and board[8] == symbol) or
            (board[2] == symbol and board[4] == symbol and board[6] == symbol)
    )


def choose_first():
    if random.randint(0, 1) == 0:
        return 'computer'
    else:
        return 'player'


def space_check(board, position):
    return board[position] == ' '


def full_board_check(board):
    for i in range(0, 9):
        if space_check(board, i):
            return False
    return True


def player_choice(board):
    position = -1
    while position < 0 or position > 8 or not space_check(board, position):
        position = int(input("Choose your next position (1-9): ")) - 1
        if position < 0 or position > 8:
            logging.warning("Invalid input! Please choose a number between 1 and 9.")
        elif not space_check(board, position):
            logging.warning("This position is already occupied! Please choose another.")
    return position


def computer_choice(board, symbol):
    if symbol == 'X':
        player_symbol = 'O'
    else:
        player_symbol = 'X'
    for i in range(0, 9):
        if space_check(board, i):
            board[i] = symbol
            if win_check(board, symbol):
                board[i] = ' '
                return i
            board[i] = player_symbol
            if win_check(board, player_symbol):
                board[i] = ' '
                return i
            board[i] = ' '
    if space_check(board, 4):
        return 4
    while True:
        i = random.randint(0, 8)
        if space_check(board, i):
            return i


def replay():
    return input("Do you want to play again? Enter 'Yes' or 'No': ").lower().startswith('y')


while True:
    print('Welcome to Tic Tac Toe!')

    board = [' '] * 9
    player_symbol = player_input()
    if player_symbol == 'X':
        computer_symbol = 'O'
    else:
        computer_symbol = 'X'

    turn = choose_first()
    print(turn + ' will go first.')

    play_game = input('Are you ready to play? Enter Yes or No.')
    if play_game.lower()[0] == 'y':
        game_on = True
    else:
        game_on = False

    while game_on:
        if turn == 'player':
            display_board(board)
            position = player_choice(board)
            place_marker(board, player_symbol, position)

            if win_check(board, player_symbol):
                display_board(board)
                print('Congratulations! You have won the game!')
                game_on = False
            else:
                if full_board_check(board):
                    display_board(board)
                    print('The game is a draw!')
                    break
                else:
                    turn = 'computer'

        else:
            position = computer_choice(board, computer_symbol)
            place_marker(board, computer_symbol, position)

            if win_check(board, computer_symbol):
                display_board(board)
                print('The computer has won!')
                game_on = False
            else:
                if full_board_check(board):
                    display_board(board)
                    print('The game is a draw!')
                    break
                else:
                    turn = 'player'

    if not replay():
        break
