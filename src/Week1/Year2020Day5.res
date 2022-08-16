@val external parseInt: (string, int) => int = "parseInt" // 포기할 수 없었씁니다...

let convertSeatIdStringToBinaryNumberArr = arr => {
  arr
  ->Js.String.castToArrayLike
  ->Js.Array.from
  ->Belt.Array.map(character => {
    switch character {
    | "F" | "L" => "0"
    | _ => "1"
    }
  })
}

let sortedSeatIds =
  Node.Fs.readFileAsUtf8Sync("input/Week1/Year2020Day5.sample.txt")
  ->Js.String2.split("\n")
  ->Belt.Array.map(convertSeatIdStringToBinaryNumberArr)
  ->Belt.Array.map(seatIdArr => Js.String2.concatMany("", seatIdArr))
  ->Belt.Array.map(binaryNumber => parseInt(binaryNumber, 2))
  ->Js.Array2.sortInPlaceWith((n1, n2) => n2 - n1)

// part 1
let highestSeatID = Belt.Array.get(sortedSeatIds, 0)->Js.log

let compareSeatId = ((seatId, prevIndexSeatId)) => {
  switch (seatId, prevIndexSeatId) {
  | (Some(seatId'), Some(prevIndexSeatId')) =>
    if mod(seatId', prevIndexSeatId') > 1 {
      Some(seatId')
    } else {
      None
    }
  | _ => None
  }
}

let findMissingSeatIdPair =
  sortedSeatIds
  ->Belt.Array.mapWithIndex((i, _) => (
    Belt.Array.get(sortedSeatIds, i),
    Belt.Array.get(sortedSeatIds, i + 1),
  ))
  ->Belt.Array.keepMap(compareSeatId)

// part 2
let mySeatNumber =
  Belt.Array.get(findMissingSeatIdPair, 0)->Belt.Option.mapWithDefault(0, id => id - 1)->Js.log
