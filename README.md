# CPP-Project-Template
Project Template for CPP projects

Contains a Base Class with its header.
All 42 Canonical Classes cpp modules compliant.

## Canonical Classes
- Default Constructor
- Copy Consturctor
- Destructor
- Copy Assignement Operator

### Example
```c
class FortyTwo
{
	FortyTwo( void );	// Default Constructor
	FortyTwo( int var );	// Fields Constructor

	FortyTwo( const FortyTwo &copy);	// Copy Constructor
	FortyTwo & operator=(const FortyTwo &assign);	// Copy Assignement Operator

	~FortyTwo( void );	// Destructor
}
```
[more info on canonical classes](https://www.francescmm.com/orthodox-canonical-class-form/)
