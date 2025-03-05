#import "../custom.typ": *


= Problem Analysis

== What is Memory?

In a computer, memory is a sequential set of locations that store numbers, characters, or boolean values. Memory is laid out in sequential order and each position in memory has an address. The compiler associates variable names with memory addresses. Some programming languages like C, allow you to ask the computer for the address of a variable in memory using the address operator (`&`). Memory locations are 8 bits long, or one byte.

When a program is running, it occupies memory, which is allocated when new variables are created. This memory is divided into multiple segments: stack (stores local variables), heap (provides dynamic memory for the programmer to allocate), data (stores global variables, separated into initialized and uninitialized), and text (stores the code being executed).

#figure(image("../assets/memory_layout_in_c.jpg", width: 40%), caption: [What the memory layout looks like in C]) <memory_layout_in_c>

Memory management in program execution primarily involves two regions of memory: the stack and the heap. These two memory structures serve different purposes and have distinct characteristics that affect how programs are written and executed.

=== Stack \& Heap Memory

*Stack Memory* #linebreak()
The stack segment is located near the top of memory with high addresses. Each function call allocates stack memory, which grows downwards as local variables are declared. Once the function returns, the stack memory is deallocated, and local variables become invalid. This allocation and deallocation of stack memory is automatic. Variables allocated on the stack are called stack variables or automatic variables.

Stack memory works like a stack of plates: you can only take off the top plate (the last one you put on), and you can only put a new plate on top of the stack. This is called "Last-In-First-Out" or LIFO.

The computer keeps track of where the top of the stack is using a special pointer called the Stack Pointer. When you call a function in your program, all its local variables get added to the top of the stack. When the function finishes, all those variables get removed automatically. 

This simple system makes function calls work smoothly because the computer can easily remember what it was doing before. When one function calls another, the first function's information stays on the stack while the new function runs. When the new function finishes, the computer knows exactly where to return because that information was saved on the stack.

In C, local variables declared within functions are allocated on the stack:

#code(lang: "C")[][
  ```C
void example_function() {
    int local_variable = 10;    // Allocated on the stack
    char buffer[100];           // Also allocated on the stack
    
    // When this function returns, local_variable and buffer are automatically deallocated
}
  ```
]

The stack's automatic memory management prevents memory leaks since all memory is reclaimed when a function completes. However, this also means that stack variables cannot persist beyond the scope of the function that created them. Additionally, the stack typically has a fixed size determined at program start, which can lead to stack overflow errors if exceeded.



*Heap Memory* #linebreak()

The heap is a region of a computer's memory dedicated to dynamic memory allocation. Unlike the stack, which follows a strict ordering, the heap is a more flexible memory pool where data can be allocated and freed in any order during program execution. This flexibility allows programs to request memory as needed at runtime rather than having memory requirements defined before the program starts.

The heap is particularly valuable for data whose size is determined during program execution, or for data that needs to persist beyond the scope of the function that created it. When a program needs memory from the heap, it requests a specific amount, and the memory manager finds an appropriate block of available memory.

In C programming, heap memory is allocated using standard library functions:
#code(lang: "C")[][
  ```C
// Request memory for 50 integers from the heap
int *numbers = (int*)malloc(50 * sizeof(int));

// Check if allocation was successful
if (numbers != NULL) {
    // Use the allocated memory
    numbers[0] = 42;
    numbers[1] = 73;
    
    // When finished, release the memory
    free(numbers);
    numbers = NULL;  // Good practice to avoid dangling pointers
}
  ```
]


In most programming environments, the programmer must explicitly manage heap memory by requesting it when needed and releasing it when finished. This manual management introduces both power and responsibility—while it provides fine-grained control over memory usage, it also requires disciplined memory management to prevent issues such as memory leaks (when allocated memory is never freed) or dangling pointers (when memory is freed but still accessed).

Programming languages handle heap memory in different ways. Lower-level languages like C require manual allocation and deallocation through functions like `malloc()` and `free()`, while higher-level languages often implement automatic memory management through garbage collection.

The heap is typically larger than the stack and can grow as needed within the constraints of available system memory. It provides the foundation for complex data structures like linked lists, trees, and dynamically sized arrays that can expand and contract during program execution. While heap operations are generally slower than stack operations due to the additional overhead of memory management, the flexibility they provide is essential for many programming tasks.

== Explaining Memory Safety
Memory safety is the practice of preventing certain types of bugs related to memory management in a program. These bugs can have severe consequences, as they often lead to malicious code being ran, program crashes, or data extrapolation (kilde: https://www.memorysafety.org/docs/memory-safety/). Memory safety vulnerabilities arise when memory is allocated, deallocated, accessed, or modified in unintended ways. These issues are not specific to any single programming paradigm, but can occur in different ways, based on programming languages ways of handling memory.(kilde: https://media.defense.gov/2023/Dec/06/2003352724/-1/-1/0/THE-CASE-FOR-MEMORY-SAFE-ROADMAPS-TLP-CLEAR.PDF) Memory itself is stored as sequences of bits, typically representing booleans, in electronic computer space. This space consists of a finite number of memory addresses, each storing values that can be manipulated by a program. These addresses are like spots in a giant warehouse, and the values stored in them are pieces of data that the program works with. (https://www.techtarget.com/whatis/definition/memory) (måske uddybe med cache, RAM, storage osv.)

A way of conceptualizing how memory safety vulnerability may arise, can be seen with the analogy of software containing grocery lists stored in arrays. If a list of groceries has 10 items, it consists of 10 memory addresses stored in sequence in the memory. Normally, in a secure system, it should not be possible to access a grocery item stored outside of the array, such as index -1 or 10. However, if proper memory safety precautions have not been taken serious, it may be possible to access memory outside of the grocery list stored. Getting access to memory at index -1 may lead to sensitive information leakage or other serious software concerns. This conceptualization highlights how even seemingly harmless errors in memory access can have significant consequences. .(kilde: https://media.defense.gov/2023/Dec/06/2003352724/-1/-1/0/THE-CASE-FOR-MEMORY-SAFE-ROADMAPS-TLP-CLEAR.PDF, obs same kilde som nr 2) (bedre/mere overgang her) 

== Types of memory safety issues


To achieve a greater understanding of memory safety issues, one can look at some of the common types of memory bugs occurring in software programs.

=== Out-of-bounds reads

The memory bug illustrated in the grocery list analogy is a classic example of an out-of-bounds read. This occurs when a program reads data from a memory address that lies outside the bounds of the intended data structure, like accessing index -1 or 10 in the grocery list. When this happens, the program may retrieve data that it should not have access to, potentially leading to unintended behavior.

=== Out of bounds writes
An out-of-bounds write is closely related to an out-of-bounds read, but instead of reading unintended memory, it involves writing data to an unintended memory location. (https://sternumiot.com/iot-blog/memory-safety-5-common-memory-bugs-and-how-to-secure-your-system/ ) This occurs when a program mistakenly writes past the allocated bounds of an array or buffer. In the grocery list analogy, this would be like trying to add an 11th item to a list that only has space for 10, which could overwrite other unrelated data in memory.

=== Use After Free
A closely related bug to to “Out-of-Bounds reads”, where unintended information is being accessed, is the “Use After Free” vulnerability. This occurs when a program is attempting to access memory that has been freed. This is possible since some programming languages does not clear the pointer to the memory, leading to the existence of a dangling pointer. If the memory of the location the pointer is pointing to gets allocated a different object, it leads to the possibility of accessing that data through the dangling pointer (https://encyclopedia.kaspersky.com/glossary/use-after-free/) . 
To illustrate this with the grocery list analogy: imagine that a grocery list (array) is deleted from memory, but there is still a pointer that references the location where the list was stored. If, at a later point, a new grocery list is created and gets assigned the same memory location as the deleted list, the dangling pointer may still point to that location. As a result, when the program tries to access the memory through that pointer, it could end up retrieving data from the new list rather than the one that was originally intended, leading to unpredictable behavior, sensitive information exposure, or even malicious exploitation of the program.
Buffer overflow???


=== Out-of-memory Kill
The Out-of-Memory (OOM) Killer in Linux is a mechanism designed to prevent system crashes by forcibly terminating processes when available memory is critically low. While this feature helps maintain system responsiveness, it can pose significant challenges in environments running critical applications on essential hardware.

One major issue arises from the unpredictability of process termination. The OOM Killer selects processes for termination based on factors such as memory consumption, process priority, and the OOM score—a heuristic that estimates the relative impact of terminating a process. However, this selection mechanism does not inherently account for the operational or business-critical importance of an application. As a result, essential services, such as databases, real-time processing applications, or control systems, may be terminated, leading to service disruptions and potential data loss.

Additionally, the abrupt termination of a critical process can cause system instability, particularly if the affected process has dependencies that are integral to overall system functionality. In database-driven environments, for example, forced termination can result in data corruption or incomplete transactions, requiring extensive recovery efforts. Furthermore, certain applications may not restart automatically, necessitating manual intervention, which can be time-sensitive and operationally costly.

In extreme cases, if the OOM Killer is unable to free sufficient memory, the system may enter a kernel panic state, leading to a complete system failure. To mitigate these risks, administrators can employ various strategies, such as tuning OOM priorities via /proc/\<pid\>/oom_score_adj, using cgroups to enforce memory limits per process, and implementing proactive monitoring tools like oomd or earlyoom to take preemptive actions before an OOM event occurs. Additionally, failover mechanisms or container orchestration tools, such as Kubernetes, can enhance system resilience by ensuring automatic recovery of terminated processes @kernel_oomkill.

== Existing Approaches to Memory Safety in Programming Languages

== Memory Safety for Embedded Systems

=== Issues in Existing Languages for Embedded Systems



== Challenges of Programming Embedded Systems for Satellite Applications
When programming embedded systems for satellite applications a parameter to be aware of is the signal to noise ratio (SNR). This measures the stregth of the recived signal compared to the power of the noise. The higher the SNR the clearer the recieved data will be, due to less interference @signal-to-noise-ratio 

Common types of interference from satelite communication, known as radio noise include: 

#show figure: set block(breakable: true)
#figure(kind: table, tablex(
    columns: 2,
    inset: 5pt,
    align: horizon,
    stroke: 0.4pt,
    map-cells: cell => {
      
      cell.fill = luma(280)
      if cell.y < 1 {
        cell.content = strong(cell.content)
        cell.fill = (cell.fill).darken(6%)
      } 
      cell.fill = (cell.fill).darken(if calc.odd(cell.y) {0%} else {5%})
      cell
    },
    [Type],[Explaination],
    [Shot Noise],[],
    [Thermal Noise],[],
    [Radiation Noise],[],


    ), caption: [Common types of interference in satellite signals ]
    )<table:interferencetypes>

thermal and shot noise
https://web.mit.edu/dvp/Public/noise-paper.pdf


radio noise
https://link.springer.com/chapter/10.1007/978-94-011-7027-7_7








Financial, and environmental challenges
https://www.captechu.edu/blog/satellite-constellation-technology-management-challenges-and-trends

Interference and jamming 
https://www.linkedin.com/advice/0/what-challenges-solutions-implementing

supply chain attacks 
https://www.ndss-symposium.org/wp-content/uploads/spacesec2024-57-paper.pdf

embedded code contraints
https://www.linkedin.com/pulse/embedded-design-constraints-embedded-hash-v0lvc/


== Overview of ARM Assembly and its Relevance to Embedded Systems

== Problem Statement (Refined based on analysis)
