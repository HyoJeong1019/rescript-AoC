let input =
  Node.Fs.readFileAsUtf8Sync("input/Week1/Year2020Day3.sample.txt")->Js.String2.split("\n")

let (x, y) = (1, 2) //part1
let slopes = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)] //part2

let findAllTree = ((x, y)) =>
  input
  ->Belt.Array.keepWithIndex((_, i) => mod(i, y) <= 0)
  ->Belt.Array.keepWithIndex((arr, i) =>
    Js.String.charAt(mod(i * x, arr->String.length), arr) == "#"
  )
  ->Js.Array.length

slopes->Belt.Array.map(findAllTree)->Js.log //[ 85, 272, 66, 73, 35 ] 532
