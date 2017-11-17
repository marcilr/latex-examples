rem
rem clean.bat
rem Created 
rem by Raymond E. Marcil <marcilr@gmail.com>
rem Copyright (C) 2010 Raymond E. Marcil
rem 
rem This program is free software: you can redistribute it and/or modify
rem it under the terms of the GNU General Public License as published by
rem the Free Software Foundation, either version 3 of the License, or
rem (at your option) any later version.
rem
rem This program is distributed in the hope that it will be useful,
rem but WITHOUT ANY WARRANTY; without even the implied warranty of
rem MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
rem GNU General Public License for more details.
rem
rem Remove dynamically created files from build process.
rem Analogous to 'make clean' target.
rem


rem Delete log, postscript, temp, etc files
del *.aux *.dvi *.lof *.log *.lot *.out *.ps *.toc *.tmp *~
