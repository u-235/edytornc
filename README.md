## EdytorNC

EdytorNC is text editor for CNC programmers.

http://sourceforge.net/projects/edytornc/

EdytorNC Google Plus Community: https://plus.google.com/communities/117267107585407507443/

Any user feedback are welcomed.

Source code of EdytorNC can be downloaded from SVN server on sourceforge.net (http://sourceforge.net/p/edytornc/code/HEAD/tree/)


### Some features

*   Bolt holes calculation
*   Solutions of triangles calculation
*   Speed, feed calculation
*   Send/receive through serial port with automatic file saving and Serial port file server - possibility to download new CNC program directly from machine.
*   Conversion inch/mm, mm/inch. You can write inches in format 1.3/4  1/4 ...
*   Find in files
*   Simple project management - you can keep links to (almost) all files related to your part program in one place.
*   First comment in program is displayed in title bar. In first comment you can write part name.
*   Comment with date will be replaced with current date on file save. Comment format: (dd-/.mm-/.yyyy) or ;dd-/.mm-/.yyyy - now system localization settings are used.
*   Block renumbering - whole program or selection
*   Code colourizing. Now with help function - click on "Help"->"Create cnc tooltips" and put mouse pointer above G, M or other codes - should appear tooltip with short information about pointed code.

    Default tooltips are in file "cnc_tooltips_lang_code.txt" (lang_code = pl_PL - for Polish) in folder with application settings (~.config on Linux. C:\Documents and Settings\USERNAME\Application Data\EdytorNC on Windows).

    You may copy it to folder with cnc programs and customize for your machine. File must be renamed to "cnc_tips.txt". Now this is done by functions in help menu.

    Currently tooltip file contains some information about codes for OKUMA, SINUMERIK 850 and FANUC.

	  Code colourizing detects control type by 'in file' file name eg. : $EXAMPLE.MIN%  $SUBS.SSB% - OKUMA; :0110 O1234 - FANUC
*   Ctrl+;  Comments/uncomments selected text with semicolon ;
*   Ctrl+9  Comments/uncomments selected text with parentheses ()
*   Ctrl+2  Adds Block Skip (/) and/or increments it
*   Ctrl+3  Adds Block Skip (/) and/or decrements it
*   Ctrl+1  Removes Block Skip (/)
*   Find/Replace can be used to addition, subtraction, multiplication, division on numbers or highlighting text.

    in Find: Y$$ in Replace $$*2 will multiply by 2 all numbers found with Y

    in Find: Y$100 $10 in Replace $$*2 will multiply by 2 only numbers between 10 and 100 found with Y

    Find can be used also to highlight specific program blocks
*   Sessions - to save/restore open file list
*	Ctrl+0 or Ctrl+Double Click 	In line calculator, you can do some math operations directly in editor. You can select address (eg X123.45) before pressing Ctrl+0 (Ctrl+Double Click will do the same), value will be entered in the calc.

    After presing Enter (and if no error) result will be pasted in cursor position. Supported operators: + - * / SIN(x) COS(x) TAN(x) SQRT(x) SQR(x) ABS(x) TRUNC(x) PI

* 	Clipboard to store five last texts copied to system clipboard. Later they can be stored permanently (by editing item title).


### Experimental features
*   macro program - parametric programming. See EXAMPLES dir.
*   split file - if file contains more than one program this function tries to split it into separate files. No auto save yet.


### Command line options

    open file -> edytornc file.nc
    diff two files -> edytornc -diff file1.nc file2.nc


EdytorNC is developed in QT Creator (best for compile EdytorNC) (libs Qt 5.4) : http://www.qtsoftware.com/products/developer-tools
Cross platform installer made by BitRock InstallBuilder for Qt : http://installbuilder.bitrock.com

If you have any suggestion (bug/translations mistakes) about EdytorNC please email me - artkoz78(at)gmail.com.


### Compile EdytorNC
- install Qt5 SDK. Download: http://www.qt.io/download-open-source/#section-2  or use your software manager
- download latest version of EdytorNC source files (http://sourceforge.net/p/edytornc/code/HEAD/tree/  Click on "Download Snapshot")
- unzip downloaded file
- run Terminal (Console application)
- go to the EdytorNC src directory (cd /user_dir/unzipped_folder)

  - run qmake (this creates proper Makefile)
  - run make clean
  - run make (there is no make install)
  - go to (cd /user_dir/unzipped_folder/bin) and execute edytornc file

   or

  - open edytornc.pro in Qt Creator
  - press Ctrl+R

http://wiki.qt.io/Deploying-Windows-Applications

To translate EdytorNC to your language you may use "Qt Linguist Download"
http://qt-apps.org/content/show.php/Qt+Linguist+Download?content=89360
Qt Linguist maybe also included in Qt SDK
More about translations : http://doc.qt.io/qt-5/qtlinguist-index.html




