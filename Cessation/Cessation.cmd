:: SPDX-License-Identifier: GPL-3.0-or-later
::
:: Cessation: A script that initiates the termination of startup processes.
:: Copyright (C) 2023  Rylan Justice
::
:: This program is free software: you can redistribute it and/or modify
:: it under the terms of the GNU General Public License as published by
:: the Free Software Foundation, either version 3 of the License, or
:: (at your option) any later version.
::
:: This program is distributed in the hope that it will be useful,
:: but WITHOUT ANY WARRANTY; without even the implied warranty of
:: MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
:: GNU General Public License for more details.
::
:: You should have received a copy of the GNU General Public License
:: along with this program.  If not, see <https://www.gnu.org/licenses/>.

@echo off
title Cessation

set startup_script="%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Cessation.cmd"

:main
  cls
  type data\menus\main.txt
  set /p "command_prompt=> " || goto main
  cls
  call :%command_prompt%
  goto main

:interlude
  echo:
  echo:
  pause
  goto main

:help
  type data\menus\help.txt
  goto interlude

:schedule
  cls
  set /p "program_name=Program name <program>.exe: "

  if "%program_name:~-4%" neq ".exe" (
    goto schedule
  )

  echo:
  echo:
  set /p "termination_delay=Termination delay [0-99999]s: "

  for /f "delims=0123456789" %%a in ("%termination_delay%") do (
    goto schedule
  )

  if %termination_delay% gtr 99999 (
    set termination_delay=99999
  )

  echo @timeout /t %termination_delay% ^& taskkill /im "%program_name%" /t /f>>%startup_script%
  goto interlude

:display
  if exist %startup_script% (
    type %startup_script%
  ) else (
    echo Cannot display the startup script because it is missing.
  )

  goto interlude

:remove
  if exist %startup_script% (
    del /p %startup_script%
  ) else (
    echo Cannot remove the startup script because it is missing.
  )

  goto interlude

:exit
  exit
