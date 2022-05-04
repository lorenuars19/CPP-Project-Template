# CPP-Project-Template
Project Template for CPP projects
## contents
- Scripts to generate Project quickly
- Makefile
- symlinks to quickly access the scripts

# Features
- Makefile

- ## script to update SRCS variable in Makefile automatically and run it :<br>
  - a symlink `u` to the script
  - Run with
```bash
  bash update_srcs.sh
```

- ## script to generate new canonical classes with the attributes[NEW!] :<br>
  - a symlink `c` to the script
  - Run with
```bash
bash cpp_gen.sh
```

- ## script to help adding new variables in class:<br>
  - a symlink `b` to the script
  - Run with
```bash
bash boiler.sh
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
