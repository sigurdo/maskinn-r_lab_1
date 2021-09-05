fn main() {
    println!("Hello, palindrome!");

    let input = "testse T";

    let nowhitespace = input.replace(" ", "");
    let lowercase = nowhitespace.to_lowercase();

    println!("Input: {}", input);

    // for ch in input.chars() {
    //     println!("{}", ch);
    // }

    let length = lowercase.len();
    let halflength = lowercase.len() / 2;

    println!("length: {}, halflength: {}", length, halflength);
    let mut palindrome = true;

    for i in 0..halflength {
        // println!("{}", i);
        if !(lowercase.chars().nth(i) == lowercase.chars().nth(length-1-i)) {
            palindrome = false;
            // println!("Not palindrome");
            break;
        }
    }

    println!("\"{}\" is {}a palindrome", input, if palindrome { "" } else {"not "});
}
