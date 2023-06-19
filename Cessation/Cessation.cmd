:: Cessation is a script that initiates the termination of startup processes.
:: Copyright (C) 2023  Rylan Justice <rylanjustice@protonmail.com>
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

@ECHO OFF
TITLE Cessation

SET file="%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\Cessation.cmd"
SET error=The startup script is missing.


:main
	CLS
	TYPE data\main
	SET /P input= || SET input=main
	CLS

	IF /I "%input%"=="help" (
		TYPE data\help
	) ELSE IF /I "%input%"=="schedule" (
		GOTO schedule
	) ELSE IF /I "%input%"=="display" (
		TYPE %file% 2>NUL || ECHO %error%
	) ELSE IF /I "%input%"=="remove" (
		IF EXIST %file% (
			DEL /P %file%
		) ELSE (
			ECHO %error%
		)
	) ELSE IF /I "%input%"=="exit" (
		EXIT
	) ELSE (
		GOTO main
	)

	ECHO:
	ECHO:
	PAUSE >NUL
	GOTO main


:schedule
	CLS
	SET /P "name=Name: "
	ECHO:
	ECHO:
	SET /P "seconds=Seconds: "
	ECHO @TIMEOUT /T %seconds% /NOBREAK ^& TASKKILL /IM "%name%" /T /F>>%file%

	ECHO:
	ECHO:
	PAUSE >NUL
	GOTO main