The ScreenCap tool just takes a snapshot of the desktop, converts it
to a PNG file and saves it in the directory given as a parameter.

If the directory name contains blank spaces, put the directory name
into double-quotes!

If the directory does not exist (i.e. SetCurrentDirectory fails), the
program will try to save the snapshot into the program's directory.

Examples:

ScreenCap
-> will save the PNGs in the program's directory

ScreenCap C:\Temp
-> Will save the PNGs in C:\Temp

ScreenCap ..\
-> Will save the PNGs in the parent directory of the program

ScreenCap .\Screenshots
-> Will save the PNGs in the sub-directory ".\Screenshots" of the program.

NOTE: In all cases the directory has to exist! Else the program will
silently fail and give no alarm or error message or anything the like.
