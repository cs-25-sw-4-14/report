#import "../custom.typ": *

= Problem Analysis

== What is Memory?

=== Heap \& Stack

== Explaining Memory Safety
Memory safety is the practice of preventing certain types of bugs related to memory management in a program. These bugs can have severe consequences, as they often lead to malicious code being ran, program crashes, or data extrapolation (kilde: https://www.memorysafety.org/docs/memory-safety/). Memory safety vulnerabilities arise when memory is allocated, deallocated, accessed, or modified in unintended ways. These issues are not specific to any single programming paradigm, but can occur in different ways, based on programming languages ways of handling memory.(kilde: https://media.defense.gov/2023/Dec/06/2003352724/-1/-1/0/THE-CASE-FOR-MEMORY-SAFE-ROADMAPS-TLP-CLEAR.PDF) Memory itself is stored as sequences of bits, typically representing booleans, in electronic computer space. This space consists of a finite number of memory addresses, each storing values that can be manipulated by a program. These addresses are like spots in a giant warehouse, and the values stored in them are pieces of data that the program works with. (https://www.techtarget.com/whatis/definition/memory) (måske uddybe med cache, RAM, storage osv.)

A way of conceptualizing how memory safety vulnerability may arise, can be seen with the analogy of software containing grocery lists stored in arrays. If a list of groceries has 10 items, it consists of 10 memory addresses stored in sequence in the memory. Normally, in a secure system, it should not be possible to access a grocery item stored outside of the array, such as index -1 or 10. However, if proper memory safety precautions have not been taken serious, it may be possible to access memory outside of the grocery list stored. Getting access to memory at index -1 may lead to sensitive information leakage or other serious software concerns. This conceptualization highlights how even seemingly harmless errors in memory access can have significant consequences. .(kilde: https://media.defense.gov/2023/Dec/06/2003352724/-1/-1/0/THE-CASE-FOR-MEMORY-SAFE-ROADMAPS-TLP-CLEAR.PDF, obs same kilde som nr 2) (bedre/mere overgang her) 

== Types of memory safety vulnerabilities
To get a greater understanding of memory safety vulnerabilities, one can look at some of the common types of memory bugs occurring in software programs.
Out-of-bounds reads
The memory bug illustrated in the grocery list analogy is a classic example of an out-of-bounds read. This occurs when a program reads data from a memory address that lies outside the bounds of the intended data structure, like accessing index -1 or 10 in the grocery list. When this happens, the program may retrieve data that it should not have access to, potentially leading to unintended behavior.

=== Out of bounds writes
An out-of-bounds write is closely related to an out-of-bounds read, but instead of reading unintended memory, it involves writing data to an unintended memory location. (https://sternumiot.com/iot-blog/memory-safety-5-common-memory-bugs-and-how-to-secure-your-system/ ) This occurs when a program mistakenly writes past the allocated bounds of an array or buffer. In the grocery list analogy, this would be like trying to add an 11th item to a list that only has space for 10, which could overwrite other unrelated data in memory.

=== Use After Free
A closely related bug to to “Out-of-Bounds reads”, where unintended information is being accessed, is the “Use After Free” vulnerability. This occurs when a program is attempting to access memory that has been freed. This is possible since some programming languages does not clear the pointer to the memory, leading to the existence of a dangling pointer. If the memory of the location the pointer is pointing to gets allocated a different object, it leads to the possibility of accessing that data through the dangling pointer (https://encyclopedia.kaspersky.com/glossary/use-after-free/) . 
To illustrate this with the grocery list analogy: imagine that a grocery list (array) is deleted from memory, but there is still a pointer that references the location where the list was stored. If, at a later point, a new grocery list is created and gets assigned the same memory location as the deleted list, the dangling pointer may still point to that location. As a result, when the program tries to access the memory through that pointer, it could end up retrieving data from the new list rather than the one that was originally intended, leading to unpredictable behavior, sensitive information exposure, or even malicious exploitation of the program.
Buffer overflow???


== Memory Safety Issues in Existing Languages for Embedded Systems

== Common Memory Errors

== Challenges of Programming Embedded Systems for Rockets

== Overview of ARM Assembly and its Relevance to Embedded Systems

== Existing Approaches to Memory Safety in Programming Languages

== Problem Statement (Refined based on analysis)


