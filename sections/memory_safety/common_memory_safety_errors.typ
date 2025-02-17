#import "../../custom.typ": *
#import "../../template.typ": *


== Common Memory Safety Errors

=== Buffer Overflows and Underflows

*What is the error?* #linebreak()
Buffer overflows and underflows are errors in memory management that occur when a program accesses memory outside the boundaries of a designated buffer. In C, a buffer overflow happens when a program writes more data to a buffer than it is allocated to hold, causing the excess data to overwrite adjacent memory. On the other hand, a buffer underflow (or under-read) occurs when a program reads or writes data before the beginning of a buffer. These errors are particularly dangerous in C because the language does not automatically enforce array bounds, placing the responsibility on the programmer to ensure safe memory access.

*How It Occurs* #linebreak()
In C programming, these errors typically occur due to several common issues:
- *Lack of Bounds Checking:* #linebreak() Functions such as `strcpy()`, `sprintf()`, and others do not verify if the destination buffer is large enough to hold the source data. Without explicit size checks, data can overflow the allocated memory.
- *Off-by-One Errors:* #linebreak() Occur when loop conditions are miscalculated. For example, using `<=` instead of `<` when iterating over an array can result in one extra iteration, writing past the end of the buffer.
- *Improper Pointer Arithmetic:* #linebreak() Miscalculations in pointer adjustments can lead to references to memory before the start (buffer underflow) or after the end (buffer overflow) of an allocated block.
- *Incorrect Memory Allocation:* #linebreak() Failing to correctly calculate the required memory size when using functions like `malloc()` may result in allocating a buffer that is too small for the intended operations.

*Potential Consequences* #linebreak()
The impact of buffer overflows and underflows on system security and stability is significant:
- *Memory Corruption:* #linebreak() Overwriting adjacent memory can corrupt other variables or control structures (such as return addresses), leading to unpredictable program behavior.
- *Security Vulnerabilities:* #linebreak() Buffer overflows can be exploited to execute arbitrary code by overwriting critical control data.
- *Data Leakage:* #linebreak() Underflows might inadvertently reveal sensitive data stored in memory that precedes the buffer.

*Example Scenario:* #linebreak()
Consider the following examples that demonstrate both a buffer overflow and a buffer underflow in C.

#code(lang: "C")[Buffer Overflow Example][
  ```C
int main() {
    char buffer[10];  // Buffer allocated for 10 characters (including the null terminator)
    
    // Using strcpy without checking if the string fits into the buffer
    strcpy(buffer, "This string is too long!");
    
    // The string exceeds the buffer size, causing a buffer overflow
    printf("Buffer: %s\n", buffer);
    return 0;
}
  ```
]

In this example, the `strcpy()` function copies the string into buffer without verifying that the destination has enough space. Since the string `"This string is too long!"` exceeds 10 characters, the extra data spills over into adjacent memory, leading to a buffer overflow.

#code(lang: "C")[Buffer Underflow Example][
  ```C
int main() {
    int *array = malloc(5 * sizeof(int));
    if (!array) {
        perror("Memory allocation failed");
        return 1;
    }
    
    // Incorrect pointer arithmetic: moving one position before the allocated memory
    int *underflow_ptr = array - 1;
    *underflow_ptr = 42;  // Writing to memory outside the allocated region
    
    // Attempting to print the value at the underflowed pointer
    printf("Underflow value: %d\n", *underflow_ptr);
    
    free(array);
    return 0;
}
  ```
]

In this scenario, memory is allocated for an array of five integers. However, the pointer `underflow_ptr` is deliberately adjusted to point one integer before the start of the allocated block. Writing to this position leads to a buffer underflow, as the program is accessing memory that was not reserved for the array. This may corrupt nearby data and result in unpredictable behavior or crashes.

#pagebreak()

=== Out-of-Bounds Access



