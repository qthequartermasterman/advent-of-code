"""
Something is wrong with global snow production, and you've been selected to take a look. The Elves have even given you 
a map; on it, they've used stars to mark the top fifty locations that are likely to be having problems.

You've been doing this long enough to know that to restore snow operations, you need to check all fifty stars by 
December 25th.

Collect stars by solving puzzles. Two puzzles will be made available on each day in the Advent calendar; the second 
puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!

You try to ask why they can't just use a weather machine ("not powerful enough") and where they're even sending you
("the sky") and why your map looks mostly blank ("you sure ask a lot of questions") and hang on did you just say the 
sky ("of course, where do you think snow comes from") when you realize that the Elves are already loading you into a 
trebuchet ("please hold still, we need to strap you in").

As they're making the final adjustments, they discover that their calibration document (your puzzle input) has been 
amended by a very young Elf who was apparently just excited to show off her art skills. Consequently, the Elves are 
having trouble reading the values on the document.

The newly-improved calibration document consists of lines of text; each line originally contained a specific calibration
value that the Elves now need to recover. On each line, the calibration value can be found by combining the first digit 
and the last digit (in that order) to form a single two-digit number.

For example:

```
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
```
In this example, the calibration values of these four lines are 12, 38, 15, and 77. Adding these together produces 142.

Consider your entire calibration document. What is the sum of all of the calibration values?



--- Part Two ---
Your calculation isn't quite right. It looks like some of the digits are actually spelled out with letters: one, two, three, four, five, six, seven, eight, and nine also count as valid "digits".

Equipped with this new information, you now need to find the real first and last digit on each line. For example:

```
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
```
In this example, the calibration values are 29, 83, 13, 24, 42, 14, and 76. Adding these together produces 281.

What is the sum of all of the calibration values?
"""



fn extract_calibration_value(line: String) raises -> Int:
    """Extracts the calibration value from a line of text.

    The calibration value is the first and last digit of the line, concatenated together.

    Examples:
        >>> extract_calibration_value("1abc2")
        12
        >>> extract_calibration_value("pqr3stu8vwx")
        38
        >>> extract_calibration_value("a1b2c3d4e5f")
        15
        >>> extract_calibration_value("treb7uchet")
        77
    """
    var digits = String("")
    for i in range(len(line)):
        if isdigit(ord(line[i])):
            digits += line[i]
            break

    for i in range(len(line), -1, -1):
        if isdigit(ord(line[i])):
            digits += line[i]
            break

    return atol(digits)

fn swap_words_to_digits(borrowed line: String) raises -> String:
    """Swaps words to digits in a line of text.
    """

    var new_line = line
    new_line = new_line.replace("one", "one1one")
    new_line = new_line.replace("two", "two2two")
    new_line = new_line.replace("three", "three3three")
    new_line = new_line.replace("four", "four4four")
    new_line = new_line.replace("five", "five5five")
    new_line = new_line.replace("six", "six6six")
    new_line = new_line.replace("seven", "seven7seven")
    new_line = new_line.replace("eight", "eight8eight")
    new_line = new_line.replace("nine", "nine9nine")
    return new_line

fn read_file(borrowed filename: String) raises -> String:
    """Reads a file and returns its contents as a string.
    """
    var handler: FileHandle = open(filename, "r")
    let contents: String = handler.read()
    handler.close()
    return contents

fn part1() raises -> None:
    """Processes the calibration document and prints the sum of all calibration values."""
    let adventure = read_file("2023/inputs/day1.txt")

    var previous_idx: Int = 0

    var sum = 0
    for idx in range(len(adventure) + 1):
        if adventure[idx] == "\n" or idx == len(adventure):
            print(previous_idx, idx)
            let line = adventure[previous_idx:idx+1]
            let value = extract_calibration_value(line)
            sum += value
            previous_idx = idx + 1
            print(value)
    print(sum)

fn part2() raises -> None:
    """Processes the calibration document and prints the sum of all calibration values."""
    let adventure = read_file("2023/inputs/day1.txt")

    var previous_idx: Int = 0

    var sum = 0
    var count = 0
    for idx in range(len(adventure) + 1):
        if adventure[idx] == "\n" or idx == len(adventure):
            print("Row", count)
            print("Indices", previous_idx, idx)
            let line = adventure[previous_idx:idx]
            let line_with_substitutions = swap_words_to_digits(line)
            let value = extract_calibration_value(swap_words_to_digits(line))
            sum += value
            previous_idx = idx + 1
            count += 1
            print("Line:         ", line)
            print("Line w/ Subs: ", line_with_substitutions)
            print("Value:        ", value)
            print("Sum:          ", sum)
            print("\n\n")
    print("Final sum", sum)

fn main() raises -> None:
    part2()