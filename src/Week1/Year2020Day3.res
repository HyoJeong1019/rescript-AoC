let input =
  Node.Fs.readFileAsUtf8Sync("input/Week1/Year2020Day3.sample.txt")->Js.String2.split("\n")

let (x, y) = (3, 1)

input
->Belt.Array.keepWithIndex((_, i) => i * y == i)
->Belt.Array.keepWithIndex((arr, i) => Js.String.charAt(mod(i * x, arr->String.length), arr) == "#")
->Js.Array.length
->Js.log
