# An interim kata. Kata 2.i
# I'm supposed to be doing a binary chop:
# http://codekata.com/kata/kata02-karate-chop/
# I tried last night, and I didn't get it right.
# I'm supposed to do it FIVE different ways
# I couldn't do it in 1 hour without looking for a tutorial
# So I decided to try something similar, but stepped & interactive.
# SO, Here's a number guesser.
# Technically it'd work with numbers over 100 or under 0, but it'd take a while.

# Once again, walking through my logic:
guess = int(50)  # initial guess
adjuster = 50  # halfway between possible numbers!
# just decoration. Maybe I should figure out how to automatically adjust the length ... not today though
hr = "\n* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *\n"

# Print the title and give em a second to think of a number...
pause = input(hr+"Think of a whole number between 1 and 100... then press enter"+hr)

# start guessing! Get input so we know how to adjust or whether I got it:
correct = input("Is it "+str(guess)+"? Type (h)higher, (l)ower, or (y)es: ")

# and as long as I'm NOT correct, adjust my guess, and ask again!
while correct != "y":
    adjuster = round(adjuster / 2)  # Cutting the "distance" between guesses in half
    if correct == "h":  # then adding that number to my guess if it's higher...
        guess = guess + adjuster
    elif correct == "l":  # or subtracting the adjustment from my guess if it's lower...
        guess = guess - adjuster
    else:  # if it's not h, l, OR y, that's an error, and we should clarify & reset the adjuster.
        print("Pardon? Type 'h' for higher, 'l' for lower, or 'y' for yes. Without quotes.")
        adjuster = adjuster * 2
    # in any case but "y", I ask again and go to the top of my while loop:
    correct = input("Is it " + str(guess) + "? Type (h)higher, (l)ower, or (y)es: ")

# If it is 'y', celebrate!
if correct == "y":
    print("\n  Yay, I got it!")
