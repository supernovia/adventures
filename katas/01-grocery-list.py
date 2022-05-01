# This is V feeling pretty proud right now.
# My last time writing a whole program _by myself_ was in a college class.
# Today I decided to try Python with a kata on grocery pricing:
# http://codekata.com/kata/kata01-supermarket-pricing/
# This one suggests only thinking about the problems, and getting feedback.
# I didn't have feedback and did want to test my logic.
# So instead I wrote up a scope, and coded it too.
# And WITH SO MANY COMMENTS so as show my mental work.
# I'm sure it's inefficient, but I'm pleased that it works.
#
# KNOWN ISSUES:
# I am still having some trouble with rounding. Currency should round up
# and if I have a whole number of an item, I don't want to show .0 after it.
# Also, zero localization. This assumes USD, and no taxes.
# And, I haven't figured out error handling.
#
# Still, I showed it to my coding kids. They're proud of me!
# And they gave me more homework.
# So I'll share what I did, VERBOSELY.
# I'm running Python 3.10, and this is written with PyCharm
 
hr = "\n* * * * * * * * * *\n"  # just for sectioning things off things to print
 
# Now print the title of my program and its scope!
print(hr + "GROCERY-O-MATIC")  # Set my title and decorate it!
print("Tell me each item you're buying, its price, and how many you need.")
print("I will try to understand different price formats,")
print("estimate the (pre-tax) cost, and build a list for you."+hr)  # food taxes are complex
 
# define a couple of "so far" type variables to start with
total = 0  # so far the total is $0
totalS = ""  # that same total as a printable word, which for now, is nothing
keepGoing = "y"  # yes we want to keep going, we just started
items = ""  # so far the list has nothing on it
startingQ = "What are you buying?"  # later I'll change that to "What ELSE" if needed
 
while keepGoing == "y":  # now, as long as we're running this:
 
    # First we need to find out the item and its price
    item = input(startingQ)  # ask for the first item
    item = item.replace("A ", "")  # if they started with A remove that
    salePrice = input("What is the price? ")  # I'll ask and get an answer stored as salePrice
    salePrice = salePrice.lower()  # make that answer lower case
    salePrice = salePrice.replace("$", "")  # remove any $ signs
 
    # Now to break up that salePrice phrase into parts, so I can use it.
    # It's not really an array, so much as a "list" in python. Oh well.
    priceArray = str.split(salePrice)  # This splits the answer, dividing by spaces.
    # Here's how Python will see that: ["1.99", "per", "pound")
    # The first word is priceArray[0], the second is priceArray[1],
    # and the third is priceArray[2]
    # (I am a #0 geek!)
 
    # These variables are for working with different price formats.
    # Is Operator a good name? IDK. But here we go:
    eachOp = "each"  # short for "each" Operator. If they say each, I'll multiply by how many
    perOp = "per"  # if they say per, I'll multiply and remember the label, like pounds
    forOp = "for"  # this one takes division and multiplication
    # and if none of these words are there, I'll assume they mean each, and just multiply
 
    # Once I ordered bananas for grocery pickup. They were 59 center per pound.
    # I ordered "5" and ended up with 19 bananas! To avoid that:
    # Ask how many, but take care to be specific if needed.
    if perOp in salePrice:  # if the price has the word "per" in it,
    # I need to get specific, so
        perWhat = " "+priceArray[2]+"s"  # Use the last list item.
    else:  # OTHERWISE...
        perWhat = ""  # just don't say anything about perWhat
    # NOW we ask how many they need.
    howMany = float(input("How many"+perWhat+" do you need? ")) 
 
    # Now for the math logic, using our "operator" variables set earlier:
    # These will define the cost
    if eachOp in salePrice:  # If the salePrice phrase has the word each
        cost = howMany * float(priceArray[0])  # multiply how many by the first word as a number in that phrase.
    elif perOp in salePrice:  # else if (elif!) if it says Per
        cost = howMany * float(priceArray[0])  # I can multiply that, too.
    elif forOp in salePrice:  # and if the price has the word "for ..."
        # get a bit trickier. Divide the last item in the list by the first, then multiply.
        cost = (float(priceArray[2]) / float(priceArray[0])) * howMany  # just like that
    else:  # if they didn't use ANY of those operators, I'm going to assume they just mean each.
        cost = howMany * float(priceArray[0])  # so I'll just multiply that.
 
    # Now get the total. This is based on the existing total (0 at first), plus cost
    total = total+cost
 
    # My cost and total need to be formatted to two decimal points. This part needs reworking to round smartly.
    totalS = "{:.2f}".format(total)  # make a new "total String" that's formatted to two decimals.
    costS = "{:.2f}".format(cost)  # and do the same for cost. We'll use that to print this message:
 
    # Say how much it costs and give a so-far total.
    print("That will cost $" + costS+". So far your total is $"+totalS)
    items = items+"\n"+str(howMany)+perWhat+" "+item  # now add that item to our list of items!
 
    # Now, we'll set up to add another item, and ask if they want to go again.
    startingQ = "What else are you buying? "  # Change that first question, just in case...
 
    # And now ask if they want to keep going. If "y" we loop back to our "while" up top.
    keepGoing = input("* * Do you want to add more items? (y/n) ")
 
# If they say n for no, let's wrap up:
if keepGoing == "n":
 
# we provide the total and a list:
    print(hr+"Okay! Your total is $"+totalS+" for:"+items+hr) 
 
# I'm sure I missed some things. Error handling especially.
# And all of it could be optimized.
# But not bad for the first foray into programming for so long!
