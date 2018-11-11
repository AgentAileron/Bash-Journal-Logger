# Bash-Journal-Logger
*A logger for making journal entries via vim (written in bash)*

----

***This is a personal logger I use for making entries about projects - use this creamy memey at your own peril***   

----

## Formatting

The logger formats files in the following way:

**Filename**: `<#> - <weekday> <month> DD - <Time of Day>`
```
<Date+Time Unix>
// <Time of Day>, <Imprecise Location> //
-  <x> days since last entry  -

===========================================================

<TEXT>
```

Where `<Imprecise Location>` will be prompted for, and `<TEXT>` will be prompted via vim. 

----

## Placement

The logger (`Entry_Logger.sh`) should be placed in a subdirectory to the directory that will hold entries. 

Avoid using the journal entry directory for anything else

**EG:**
```
/home/user/Documents/
|-- Project Logs
|   |-- Entry Logger
|       |-- Entry_Logger.sh
|
|-- <Log files will be saved here>
```
