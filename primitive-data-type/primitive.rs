fn main() {
  let x: i32 = -42;
  let y: u64 = 100;
  println! ("Signed Integer: {}", x);
  println! ("Unsigned Integer: {}", y);
//=======================================================
//floats [floating point types]
// we have only two f32, f64
  let pi: f64 = 3.14;
  println!("Value of pi: {}", pi);
//=======================================================

//boolean values can either take true or false.
  let is_snowing: bool = true;
  println!("is it snowing? {}", is_snowing);

// Character type Char: its represent a single unicode scalar value
let letter: char = 'a';
println! ("First late of the Alphabet is {}", letter);

// How to compound data types in rust
// (arrays, tuples, slices, and strings, (slice string))
// arrays: are fixed size collections of the element of the same types. eg [1,2,3,34,4], ["foo", "bar"]
let numbers: [i32; 5] = [1,2,3,4,5];
println!("Print array {:?}", numbers);

let fruits: [&str; 3] = ["apple", "orange", "bananna"];
println!("All the fruits: {:?}", fruits);
println!("1st fruits: {}", fruits[0]);
println!("2nd fruits: {}", fruits[1]);
println!("3rd  fruits: {}", fruits[2]);

//tuples: conatian heterogenious collections of element of fixed size.


}
