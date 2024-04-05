# AbsenceTracker-NC3

![Simulator Screenshot - iPhone 15 - 2024-04-05 at 15 38 42](https://github.com/paulinalh/AbsenceTracker-NC3/assets/65806675/cd183346-24e8-4985-8bb8-f2c906961bf3)
![Simulator Screenshot - iPhone 15 - 2024-04-05 at 15 47 52](https://github.com/paulinalh/AbsenceTracker-NC3/assets/65806675/0a0e2db0-097e-48e3-9f5c-32f3fbc9c3f0)
![Simulator Screenshot - iPhone 15 - 2024-04-05 at 15 51 52](https://github.com/paulinalh/AbsenceTracker-NC3/assets/65806675/83545adc-5eae-4980-9d28-8267946aecbf)
![Simulator Screenshot - iPhone 15 - 2024-04-05 at 15 47 55](https://github.com/paulinalh/AbsenceTracker-NC3/assets/65806675/2f755147-330a-4ef5-ba9f-da5f1e132207)


### Subject Model Sorting
This project demonstrates sorting an array of SubjectModel instances based on different sorting options using SwiftUI and Swift programming language. Here's an overview of the project structure and functionality:

### Project Overview
This app aims to work as a tool or tracker for absences in classes, aswell as ordering each and every subject by its different priorities. The project concists of 5 SwiftUI views and 2 SwiftData models that were later used primarly as arrays during the performance of the app. Given this, the efficent and optimized use of arrays in the development of the application was essential. The user is able to choose the sorting or filtration of the array of subjects in the given choices:

- Less Absences to Most
- Most Absences to Less
- More in Risk to Less Risky
- Less Risky to More in Risk

In addition to this, the app consist of a diversed use of data handling revolving around Dates and its given calculations. Most of the functions and utils used for this performance can be found inside the utils folder inside the repository.

The SubjectModel struct represents a subject with attributes like name, number of absences, and required attendance.

### The most used data structure on this project: arrays. But, how do they work?
Swift arrays are ordered collections of values that are stored sequentially in memory. They are mutable, meaning their elements can be modified after creation. Arrays in Swift offer various methods for manipulation and traversal, making them versatile data structures for storing and processing collections of elements.

# Sorting Implementation
The sorting implementation (sortSubjectModels function) utilizes Swift's sorting methods on arrays. For each sorting option, the subjectModels array is sorted based on the specified criteria using a closure passed to the sort method.

## Big O Notation
The Big O notation for sorting the subjectModels array in each case is as follows:

Less Absences to Most: O(n log n)

This is the average time complexity of Swift's built-in sorting algorithm (sort method), which uses an optimized version of the merge sort algorithm.
Most Absences to Less: O(n log n)

Similar to the previous case, the average time complexity remains O(n log n) due to the same sorting algorithm.
More in Risk to Less Risky: O(n log n)

The time complexity is also O(n log n) as it involves sorting based on a single criterion, which does not change the fundamental complexity.
Less Risky to More in Risk: O(n log n)

Similarly, the time complexity remains O(n log n) for the same reasons as the previous cases.
Approach and Rationale
This project uses SwiftUI and Swift's built-in sorting methods to achieve the desired functionality efficiently. The chosen approach provides a straightforward and concise way to implement sorting based on different criteria, allowing for easy maintenance and scalability.

