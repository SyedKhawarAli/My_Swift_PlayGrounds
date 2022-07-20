
// MARK: - Searching

// Linear search

// Binary search

// MARK: - Sorting

// Bubble sort

// Selection sort

// Insertion sort

// Merg sort

// Quick sort

// Heap sort

// MARK: - extra

let arr = [1, 2, 3, 4, 5, 5, 5]

let myString = "haveaniceday"

encryption(s: myString)

func encryption(s: String) -> String {
    // Write your code here
    let sCount: Int = s.count
    let underRootValue = Double(sCount).squareRoot()
    var noColums = Int(underRootValue.rounded(.down))
    let noRows = Int(underRootValue.rounded(.up))
    if noRows * noColums < sCount {
        noColums = noRows
    }
    var resultString = ""
    for colum in 0..<noRows {
        for row in 0..<noColums {
            let charIndex = colum+(row*(noRows))
            if charIndex <= (sCount-1){
                resultString.append(Array(s)[charIndex])
            }
        }
        resultString.append(" ")
    }
    return resultString
}

func birthdayCakeCandles(candles: [Int]) -> Int {
    let max = candles.max()
    var count  = 0
    for num in candles {
        if num == max {
            count += 1
        }
    }
    return count
}

birthdayCakeCandles(candles: arr)

func gradingStudents(grades: [Int]) -> [Int] {
    // Write your code here
    var multipleOfFives: [Int] = []
    for num in 1...20 {
        multipleOfFives.append(num*5)
    }
    var finalGrades: [Int] = []
    for num in grades {
        if num < 38 {
            finalGrades.append(num)
        }else {
            for numOfFive in multipleOfFives {
                if numOfFive >= num {
                    if numOfFive - num < 3 {
                        finalGrades.append(numOfFive)
                    }else{
                        finalGrades.append(num)
                    }
                    break
                }
            }
        }
    }
    return finalGrades
}
let arr2  = [73, 100, 98, 33, 44]
gradingStudents(grades: arr2)

func breakingRecords(scores: [Int]) -> [Int] {
    var maxValue: Int = scores.count > 0 ? scores[0] : 0
    var minValue: Int = scores.count > 0 ? scores[0] : 0
    var maxScore = 0
    var minScore = 0
    for item in scores {
        if item > maxValue {
            maxScore += 1
            maxValue = item
        }else if item < minValue {
            minScore += 1
            minValue = item
        }
    }
    return [maxScore, minScore]
}

let scores1 = [3, 4, 21, 36, 10, 28, 35, 5, 24, 42]
let scores2 = [10, 5, 20, 20, 4, 5, 2, 25, 1]
breakingRecords(scores: scores2)

func birthday(s: [Int], d: Int, m: Int) -> Int {
    let totalSequences = 0
    for item in s {
        
    }

    return totalSequences
}

func countApplesAndOranges(s: Int, t: Int, a: Int, b: Int, apples: [Int], oranges: [Int]) -> Void {
    // Write your code here
    var applesLocations: [Int] = []
    var oragnesLocations: [Int] = []
    var totalApplesInLocation = 0
    var totalOrangesInLocation = 0
    for item in apples {
        applesLocations.append(item + a)
    }
    for item in oranges {
        oragnesLocations.append(item + b)
    }
    for item in applesLocations {
        if item >= s && item <= t {
            totalApplesInLocation += 1
        }
    }
    for item in oragnesLocations {
        if item >= s && item <= t {
            totalOrangesInLocation += 1
        }
    }
    print(totalApplesInLocation)
    print(totalOrangesInLocation)
}
countApplesAndOranges(s: 7, t: 11, a: 5, b: 15, apples: [-2, 2, 1], oranges: [5, -6])
countApplesAndOranges(s: 7, t: 10, a: 4, b: 12, apples: [2, 3, -4], oranges: [3, -2, -4])

func hourglassSum(arr: [[Int]]) -> Int {
    var temp_sum: Int?
    var MaxSum: Int?
    for j in 0..<6 {
        for i in 0..<6 {
            if (j + 2 < 6 && i + 2 < 6) {
                temp_sum = arr[i][j] + arr[i][j + 1] + arr[i][j + 2] + arr[i + 1][j + 1] + arr[i + 2][j] + arr[i + 2][j + 1] + arr[i + 2][j + 2];
                guard let newMaxSum = MaxSum, let newTempSum = temp_sum else {
                    MaxSum = temp_sum
                    break
                }
                if (newTempSum >= newMaxSum) {
                    MaxSum = temp_sum;
                }

            }
        }
    }
    for i in 0..<6 {
        for j in 0..<6 {
            if (j + 2 < 6 && i + 2 < 6) {
                temp_sum = arr[i][j] + arr[i][j + 1] + arr[i][j + 2] + arr[i + 1][j + 1] + arr[i + 2][j] + arr[i + 2][j + 1] + arr[i + 2][j + 2];
                guard let newMaxSum = MaxSum, let newTempSum = temp_sum else {
                    MaxSum = temp_sum
                    break
                }
                if (newTempSum >= newMaxSum) {
                    MaxSum = temp_sum;
                }

            }
        }
    }
    return MaxSum ?? 0
}
let hours2d = [[-1, -1, 0, -9, -2, -2],
               [-2, -1, -6, -8, -2, -5],
               [-1, -1, -1, -2, -3, -4],
               [-1, -9, -2, -4, -4, -5],
               [-7, -3, -3, -2, -9, -9],
               [-1, -3, -1, -2, -4, -5]]

let hours = [[-1, 1, -1, 0, 0, 0],
             [0, -1, 0, 0, 0, 0],
             [-1, -1, -1, 0, 0, 0],
             [0, -9, 2, -4, -4, 0],
             [-7, 0, 0, -2, 0, 0],
             [0, 0, -1, -2, -4, 0]]

hourglassSum(arr: hours2d)
hourglassSum(arr: hours)

