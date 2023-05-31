if (interactive()) {
  con <- stdin()
} else {
  con <- "stdin"
}
cat("X or O? ")
symbol <- readLines(con = con, n = 1)
print(symbol)