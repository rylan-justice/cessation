@echo off

rem SPDX-License-Identifier: GPL-3.0-or-later
rem
rem Cessation: Initiates the termination of startup processes.
rem Copyright (C) 2023-2024  Rylan Justice
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
rem You should have received a copy of the GNU General Public License
rem along with this program.  If not, see <https://www.gnu.org/licenses/>.

title Cessation

set newlines=echo. ^& echo.
set startup_script="%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Cessation.cmd"

:main
  cls & type menus\main.txt
  set /p "command=> " || goto main
  cls & call :%command% || goto main

:interlude
  %newlines% & pause >nul
  goto main

:help
  type menus\help.txt
  goto interlude

:schedule
  cls & set /p "program_name=Program name <program>.<extension>: " & %newlines%
  set /p "termination_delay=Termination delay [0-99999]s: "

  if not defined termination_delay goto schedule

  for /f "delims=0123456789" %%a in ("%termination_delay%") do goto schedule

  if %termination_delay% gtr 99999 set termination_delay=99999

  echo @timeout /t %termination_delay% ^& taskkill /im "%program_name%" /t /f ^>nul 2^>^&^1>>%startup_script%
  goto interlude

:display
  if not exist %startup_script% echo Cannot display the startup script because it is missing.

  type %startup_script% 2>nul
  goto interlude

:remove
  if not exist %startup_script% echo Cannot remove the startup script because it is missing.

  del /p %startup_script% 2>nul
  goto interlude

:exit
  exit
