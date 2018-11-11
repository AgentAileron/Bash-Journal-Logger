# Bash-Journal-Logger
*A logger for making journal entries via vim (written in bash)*

----

Bash isn't the greatest for a thing like this, but it's convenient and educational to make. 

***This is a personal logger I use for making entries about projects - use this creamy memey at your own peril***   return

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




## Placement

The logger (`Entry_Logger.sh`) should be placed in a subdirectory to the directory that will hold entries. The `persist` file should be placed in the same subdirectory. Avoid using the directory for entries for anything else

**EG:**
```
/home/user/Documents/
|-- Project Logs
|   |-- Entry Logger
|       |-- Entry_Logger.sh
|       |-- persist
|
|-- <Log files will be saved here>
```
