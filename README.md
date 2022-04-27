# CPP-Project-Template
Project Template for CPP projects
## contents
- Scripts to generate Project quickly
- Makefile
- symlinks to quickly access the scripts

# Features
- Makefile
- script to update SRCS variable in Makefile automatically and run it :<br>
Run with
```bash
bash update_srcs.sh
```
and a symlink `u`
- script to generate new canonical classes :<br>
```bash
bash cpp_gen.sh
```
and a symlink `c`
- script to help adding new variables in class:<br>
```bash
bash boiler.sh
```
and a symlink `b`


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
