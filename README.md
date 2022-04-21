# CPP-Project-Template
Project Template for CPP projects
## contents
- Scripts to generate Project quickly
- Makefile

# Features
- Makefile
- script to update SRCS variable in Makefile automatically :<br>
Run with
```bash
bash update_srcs.sh
```
- script to generate new canonical classes :<br>
```bash
bash cpp_gen.sh
```
This script will ask you for the class name or you can pass it as an argument.
## Canonical Classes
- Default Constructor
- Copy Constructor
- Destructor
- Copy Assignement Operator

### Example
```c
class FortyTwo
{
	FortyTwo( void );				// Default Constructor
	FortyTwo( int var );				// Fields Constructor

	FortyTwo( const FortyTwo& copy );		// Copy Constructor
	FortyTwo & operator=(const FortyTwo& assign );	// Copy Assignement Operator

	~FortyTwo( void );				// Destructor
}
```
[more info on canonical classes](https://www.francescmm.com/orthodox-canonical-class-form/)
