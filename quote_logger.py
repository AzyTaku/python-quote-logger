import time
import random

quotes = [
    "What happens, happens. It's an expression of faith in the mechanics of the world, not an excuse to do nothing. - Christopher Nolan's TENET",
    "But how could you live, and have no story to tell - Dotoevsky",
    "I go to seek a great perhaps - Francois Rabeleis",
    "you dont need to worry abt the path ahead until you reach it",
    "Butterflies cant see the color of their own wings",
    "So many books, so little time." ,
    "You only live once, but if you do it right, once is enough.",
    "Success is not final, failure is not fatal: It is the courage to continue that counts.",
    "The journey of a thousand miles begins with one step",
    "if it works don't touch it",
]

def log_quotes(interval=30):
    try:
        while True:
            quote = random.choice(quotes)
            print(quote)
            time.sleep(interval)
    except KeyboardInterrupt:
        print("\nLogging stopped by user.")

if __name__ == "__main__":
    log_quotes(30)
